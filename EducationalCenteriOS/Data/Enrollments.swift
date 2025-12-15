//
//  Enrollments.swift
//  EducationalCenter
//
//  Created by Mananas on 2/12/25.
//

import Foundation

/* Esta colección es la que conecta a los alumnos con las asignaturas y es donde se registrarán las notas.*/
struct Enrollments: Codable
{
    let enrollmentId: String //ID único para la matrícula
    let studentId: String //ID del alumno matriculado
    let subjectId: String //ID de la asignatura matriculada
    let finalNote: Double //Nota final de la asignatura
    let partialGrades: String //notasParciales : Un array para guardar las notas de diferentes exámenes/trabajos
}
