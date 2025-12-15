//
//  ViewController.swift
//  EducationalCenter
//
//  Created by Mananas on 1/12/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignInVC: UIViewController
{
    /**/
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    /**/
    @IBAction func signIn(_ sender: Any)
    {
        let email = tfUserName.text ?? ""
        let password = tfPassword.text ?? ""
        
        Auth.auth().signIn(withEmail: email, password: password) { [unowned self] authResult, error in
            if let error = error
            {
                print(error.localizedDescription)
                self.showMessage(message: error.localizedDescription)
                return
            }
            
            print("Datos correctos")
            
            // 1. Captura el ID de usuario (UID)
            guard let user = authResult?.user else
            {
                print("Error: No se encontró el objeto de usuario.")
                return
            }
            
            let uid = user.uid
            print("UID del usuario autenticado: \(uid)")
            
            // 2. Utiliza el UID para buscar los datos en Firestore
            self.getFirestoreData(uid: uid)
        }
    }
    
    /**/
    func goToViewController(userData: user)
    {
        let role = userData.rol.lowercased()

        DispatchQueue.main.async
        {
            switch role
            {
            case "director":
                // Navegar a la vista principal del Director
                self.performSegue(withIdentifier: "GoTo VC Headmaster", sender: userData)
            case "secretaria":
                // Navegar a la vista principal de la Secretaría
                self.performSegue(withIdentifier: "GoTo VC Secretary", sender: userData)
            case "profesor":
                // Navegar a la vista principal del Profesor
                self.performSegue(withIdentifier: "GoTo VC Teacher", sender: userData)
            case "alumno":
                // Navegar a la vista principal del Alumno
                self.performSegue(withIdentifier: "GoTo VC Student", sender: userData)
            default:
                self.showMessage(message: "Rol de usuario desconocido.")
            }
        }
    }


    /**/
    func getFirestoreData(uid: String)
    {
        let db = Firestore.firestore()
        
        // Consulta el documento de perfil usando el UID como ID del documento
            db.collection("users").document(uid).getDocument { [weak self] document, error in
                guard let self = self else { return }
                
                if let error = error {
                    self.showMessage(message: "Error: \(error.localizedDescription)")
                    return
                }

                // 1. Intentamos convertir todo el documento en tu struct 'user'
                // Esto es mucho más limpio que usar userData["rol"]
                if let document = document, document.exists,
                           let datosDelUsuario = try? document.data(as: user.self) {
                            
                            print("Datos cargados para: \(datosDelUsuario.name)")
                            
                            // 2. Llamamos a la navegación pasándole el OBJETO completo
                            self.goToViewController(userData: datosDelUsuario)
                            
                        } else {
                            self.showMessage(message: "Perfil no encontrado en la base de datos.")
                        }
            }
    }
    
}

