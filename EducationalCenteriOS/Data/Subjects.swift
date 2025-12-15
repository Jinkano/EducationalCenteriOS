//
//  Subjects.swift
//  EducationalCenter
//
//  Created by Mananas on 2/12/25.
//

import Foundation

/* Almacenará la información de todas las asignaturas que se imparten.*/

struct Subjects: Codable
{
    let subjectId: String //ID único para la asignatura
    let name: String //nombre : de la asignatura (e.g., "Matemáticas", "Historia")
    let teacherUid: String //profesorUid: UID del profesor asignado a esta asignatura.
}
