//
//  Receta.swift
//  Mis Recetas
//
//  Created by Abraham Barcenas M on 10/2/16.
//  Copyright © 2016 Abraham Barcenas M. All rights reserved.
//

import Foundation
import UIKit

class Receta: NSObject {
    
    var nombre : String!
    var imagen : UIImage!
    var tiempo : Int!
    var ingredientes : [String]!
    var pasos : [String]!
    var esFavorita : String?
    
    init(nombre : String, imagen : UIImage, tiempo: Int, ingredientes : [String], pasos: [String]) {
        self.nombre = nombre
        self.imagen = imagen
        self.tiempo = tiempo
        self.ingredientes = ingredientes
        self.pasos = pasos
        
    }
    
}
