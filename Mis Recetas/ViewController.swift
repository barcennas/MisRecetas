//
//  ViewController.swift
//  Mis Recetas
//
//  Created by Abraham Barcenas M on 10/2/16.
//  Copyright © 2016 Abraham Barcenas M. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var recetas : [Receta] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        
        var platillo : Receta = Receta(nombre: "Pizza",
                                       imagen: #imageLiteral(resourceName: "pizza"),
                                       tiempo: 20,
                                       ingredientes: ["Masa", "Salsa de tomate", "Queso", "Peperoni", "Jalapeño"],
                                       pasos: ["Moldear masa", "Agregar salsa de tomate", "Agregar queso", "Agregar jalapeño y peperoni"])
        recetas.append(platillo)
        
        platillo = Receta(nombre: "Hamburguesa",
                          imagen: #imageLiteral(resourceName: "hamburguesa"),
                          tiempo: 10,
                          ingredientes: ["Pan", "Aderezos", "Lechuga", "Carne", "Jamon", "Queso", "Tocino"],
                          pasos: ["Agregar aderezo a pan", "Agregar los ingredientes faltantes"])
        recetas.append(platillo)
        
        platillo = Receta(nombre: "Consome",
                          imagen: #imageLiteral(resourceName: "consome"),
                          tiempo: 30,
                          ingredientes: ["Caldo de pollo", "Arroz", "Zanahoria", "Calabaza", "Papa"],
                          pasos: ["Calentar caldo", "Agregar ingredientes en trocitos"])
        recetas.append(platillo)
        
        platillo = Receta(nombre: "Albondigas en chipotle",
                          imagen: #imageLiteral(resourceName: "albondigas"),
                          tiempo: 20,
                          ingredientes: ["Carne molida", "Chipotle", "Agua"],
                          pasos: ["Dar forma circuclar a la carne", "Preparar salsa chipotle", "Cocinar la carne con la salsa chipotle"])
        recetas.append(platillo)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override var prefersStatusBarHidden: Bool{
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: - UITableViewDataSource
    //Funciones que delegan las tareas de la tabla al ViewController
    
    //Indica el numero de secciones en la tabla (como todas son recetas solo es 1)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //indica el numero de filas en la tabla (agarras el numero de recetas del array)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recetas.count
    }
    
    //funcion de rows reutilizables
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let receta = recetas[indexPath.row]
        let cellID = "TableCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! RecipeCell
        
        cell.ImagenReceta.image = receta.imagen
        cell.lblNombre.text = receta.nombre
        cell.lblTiempo.text = "Tiempo: \(receta.tiempo!) minutos"
        cell.lblIngredientes.text = "Ingredientes: "
        
        /*for ingrediente in receta.ingredientes {
            cell.lblIngredientes.text = cell.lblIngredientes.text! + "\(ingrediente) ,"
        }*/
        
        cell.lblIngredientes.text = "Ingredientes: \(receta.ingredientes.count)"
        
        //hace que la imagen sea circular
        /*cell.ImagenReceta.layer.cornerRadius = 34.5 //le da el radio que es la mitad de la altura para que sea un circulo perfecto
        cell.ImagenReceta.clipsToBounds = true*/ //indica si los bordes que estan afuera del circulo se ocultaran o no
        
        
        //cell.accesoryType indica el accesorio de la cell, checkmark es una palomita
        if receta.esFavorita != nil {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
    
    /*override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            self.recetas.remove(at: indexPath.row)
        }
        
        //self.tableView.reloadData()  //recarga todo el table view, no muy eficioente
        
        //se elimina solo el cell de la tabla y agrega una animacion
        self.tableView.deleteRows(at: [indexPath], with: .fade)
        
    }*/
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        //Borrar
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            
            
                self.recetas.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        
        //Compartir
        let shareAction = UITableViewRowAction(style: .default, title: "Share") { (action, indexPath) in
            let platillo = self.recetas[indexPath.row]
            
            let shareDefaultText = "Estoy mirando el platillo \(platillo.nombre!)"
            
            let activityController = UIActivityViewController(activityItems: [shareDefaultText, platillo.imagen!], applicationActivities: nil)
            
            self.present(activityController, animated: true, completion: nil)
        }
        
        shareAction.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        return[shareAction, deleteAction]
        
    }
    
    //MARK: - UITableViewDelegate
    
    
    //Funcion para poner un checkMark en el platillo favorito preguntandole mediante un alert
    /*override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("Se selecciono la opcion \(self.recetas[indexPath.row].nombre)")
        
        let receta = self.recetas[indexPath.row]
        
        let alert = UIAlertController(title: receta.nombre, message: "Valora este platillo", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        var favoriteActionTitle = "Favorito"
        var favoriteActionStyle = UIAlertActionStyle.default
        if receta.esFavorita{
            favoriteActionTitle = "No Favorito"
            favoriteActionStyle = UIAlertActionStyle.destructive
        }
        
        let favoriteAction = UIAlertAction(title: favoriteActionTitle, style: favoriteActionStyle) { (action) in
            
            //let receta = self.recetas[indexPath.row]
            receta.esFavorita = !receta.esFavorita
            self.tableView.reloadData()
        }
        alert.addAction(favoriteAction)
        
        self.present(alert, animated: true, completion: nil)
    }*/
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segeDetallePlatillo" {
            
            if let indexPath = self.tableView.indexPathForSelectedRow{
                
                let platilloSeleccionado = self.recetas[indexPath.row]
                
                let viewDestino = segue.destination as! DetailViewController
                
                viewDestino.platillo = platilloSeleccionado
                
            }
            
        }
    }
}

