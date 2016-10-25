//
//  DetailViewController.swift
//  Mis Recetas
//
//  Created by Abraham Barcenas M on 10/5/16.
//  Copyright © 2016 Abraham Barcenas M. All rights reserved.
// 

import UIKit

class DetailViewController: UIViewController{

    @IBOutlet var imagenDetalle: UIImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var btnRating: UIButton!
   
    var platillo : Receta!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = platillo.nombre
        
        self.imagenDetalle.image = self.platillo.imagen
        tableView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        tableView.separatorColor = UIColor.clear
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableViewAutomaticDimension
        if let rating = platillo.esFavorita{
            switch rating {
            case "Me encanta":
                self.btnRating.setImage(#imageLiteral(resourceName: "great"), for: .normal)
            case "Me gusta":
                self.btnRating.setImage(#imageLiteral(resourceName: "good"), for: .normal)
            case "No me gusta":
                self.btnRating.setImage(#imageLiteral(resourceName: "dislike"), for: .normal)
            default:
                break
            }
        }else{
            btnRating.setImage(#imageLiteral(resourceName: "rating"), for: .normal)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = false
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueRating" {

        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    @IBAction func close(segue: UIStoryboardSegue){
        if let ratingVC = segue.source as? RatingPopoverController{
            
            if let rating = ratingVC.ratingSeleccted{
                switch rating {
                case "Me encanta":
                    self.platillo.esFavorita = "Me encanta"
                    self.btnRating.setImage(#imageLiteral(resourceName: "great"), for: .normal)
                case "Me gusta":
                    self.platillo.esFavorita = "Me gusta"
                    self.btnRating.setImage(#imageLiteral(resourceName: "good"), for: .normal)
                case "No me gusta":
                    self.platillo.esFavorita = "No me gusta"
                    self.btnRating.setImage(#imageLiteral(resourceName: "dislike"), for: .normal)
                default:
                    break
                }
            }
        
        }
    }
    
}

extension DetailViewController : UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.platillo.accessibilityElementCount()
        switch section {
        case 0:
            return 3
        case 1:
            return self.platillo.ingredientes.count
        case 2:
            return self.platillo.pasos.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "DetallePlatilloCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! DetallePlatilloCell
        
        //hace que la cell sea casi trasparente
        //cell.backgroundColor = UIColor.clear
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.lblKey.text = "Nombre"
                cell.lblValor.text = self.platillo.nombre
            case 1:
                cell.lblKey.text = "Tiempo"
                cell.lblValor.text = "\(self.platillo.tiempo!) min"
            case 2:
                cell.lblKey.text = "Rating"
                if let ratingExistente = self.platillo.esFavorita {
                    cell.lblValor.text = ratingExistente
                }else{
                    cell.lblValor.text = "Sin calificar"
                }
            default:
                break
            }
        case 1:
            /*if indexPath.row == 0 {
                cell.lblKey.text = "Ingredientes"
            }else{
                cell.lblKey.text = ""
            }*/
            cell.lblKey.text = ""
            cell.lblValor.text = self.platillo.ingredientes[indexPath.row]
        case 2:
            if indexPath.row == 0 {
                //cell.lblKey.text = "Pasos"
            }else{
                cell.lblKey.text = ""
            }
            cell.lblKey.text = ""
            cell.lblValor.text = self.platillo.pasos[indexPath.row]
        default:
            break
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionTitle = ""
        
        switch section {
        case 1:
            sectionTitle = "Ingredientes"
            return sectionTitle
        case 2:
            sectionTitle = "Pasos"
            return sectionTitle
        default:
            return sectionTitle
        }
    }
}
