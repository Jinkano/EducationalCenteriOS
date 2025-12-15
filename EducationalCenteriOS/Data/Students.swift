//
//  Students.swift
//  EducationalCenter
//
//  Created by Mananas on 2/12/25.
//

import Foundation

/* Almacenará la información de todos los estudiantes.*/

struct Students: Codable
{
    let studentId: String //ID único para el alumno (generado por Firestore)
    let name: String //nombre : completo del alumno
    let dateOfBirth: String //fechaNacimiento - Timestamp
    //let claseId: String //Referencia a la clase o grupo al que pertenece (opcional)
}
