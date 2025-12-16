//
//  UserRole.swift
//  EducationalCenteriOS
//
//  Created by Mananas on 16/12/25.
//

import Foundation

enum UserRole: String, Codable
{
    case director
    case secretaria
    case profesor
    case alumno
    
    
    var title: String
    {
        rawValue.capitalized
    }

    var segueIdentifier: String
    {
        switch self
        {
        case .director: return "GoTo VC Headmaster"
        case .secretaria: return "GoTo VC Secretary"
        case .profesor: return "GoTo VC Teacher"
        case .alumno: return "GoTo VC Student"
        }
    }
}
