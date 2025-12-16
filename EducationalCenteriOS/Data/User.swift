//
//  Users.swift
//  EducationalCenter
//
//  Created by Mananas on 1/12/25.
//

import Foundation
import FirebaseCore

/**/
struct User: Codable {

    let uid: String
    let active: Bool
    let email: String
    let name: String
    let rol: UserRole

    init?(dictionary: [String: Any], uid: String) {

        guard let uid = dictionary["uid"] as? String,
              let active = dictionary["active"] as? Bool,
              let email = dictionary["email"] as? String,
              let name = dictionary["name"] as? String,
              let rol = dictionary["rol"] as? String else {
            return nil
        }

        //AQUÍ roleString ES String
        let cleanRol = rol
            .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            .lowercased()

        guard let rol = UserRole(rawValue: cleanRol) else {
            return nil
        }

        self.uid = uid
        self.active = active
        self.email = email
        self.name = name
        self.rol = rol
    }
}
