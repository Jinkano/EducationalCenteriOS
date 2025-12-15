//
//  Users.swift
//  EducationalCenter
//
//  Created by Mananas on 1/12/25.
//

import Foundation
import FirebaseCore

/**/
struct user: Codable
{
    let uid: String
    let active : Bool
    let email: String
    let name: String
    let rol: String
    
    // Inicializador para crear el objeto Empleado a partir de datos de Firestore
    init?(dictionary: [String: Any])
    {
        // Hacemos el casting seguro de los campos. Si falta alguno, la inicialización falla.
        guard let uid = dictionary["uid"] as? String,
              let active = dictionary["active"] as? Bool,
              let email = dictionary["email"] as? String,
              let name = dictionary["name"] as? String,
              let rol = dictionary["rol"] as? String else {
            return nil
        }
        
        self.uid = uid
        self.active = active
        self.email = email
        self.name = name
        self.rol = rol
        
    }
}
