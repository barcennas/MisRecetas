//
//  SingleViewController.swift
//  Mis Recetas
//
//  Created by Abraham Barcenas M on 10/3/16.
//  Copyright © 2016 Abraham Barcenas M. All rights reserved.
//

import UIKit

class SingleViewController: UIViewController  {

    
    @IBOutlet var tableView: UITableView!
    var recetas : [Receta] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Asignar el viewController que sea el DataSource y el Delegado Con Codigo
        /*
         self.tableView.dataSource = self
         self.tableView.delegate = self
         */
        
        //Asignar el viewController que sea el DataSource y el Delegado con diseño
        //1.- Arrastrar el tableView al circulo amarillo en el borde del view y oprimir datasoruce y delegate
        
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
    
    override var prefersStatusBarHidden: Bool{
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SingleViewController : UITableViewDataSource{
    //MARK: - UITableViewDataSource
    //Funciones que delegan las tareas de la tabla al ViewController
    
    //Indica el numero de secciones en la tabla (como todas son recetas solo es 1)
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //indica el numero de filas en la tabla (agarras el numero de recetas del array)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recetas.count
    }
    
    //funcion de rows reutilizables
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let receta = self.recetas[indexPath.row]
        let cellID = "TableCell"
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! FullRecipeCell
        
        cell.cellImage.image = receta.imagen
        cell.lblNombre.text = receta.nombre
        
        
        return cell
    }
}
