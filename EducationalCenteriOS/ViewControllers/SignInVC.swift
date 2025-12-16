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
    /*func goToViewController(role: String)
    {
        guard let userRole = UserRole(rawValue: role) else
        {
            showMessage(message: "Rol desconocido")
            return
        }
        performSegue(withIdentifier: userRole.segueIdentifier, sender: nil)
    }*/
    func goToViewController(role: UserRole)
    {
        performSegue(withIdentifier: role.segueIdentifier, sender: nil)
    }



    /**/
    func getFirestoreData(uid: String) {

        let db = Firestore.firestore()

        db.collection("users").document(uid).getDocument { document, error in

            if let error = error {
                print("Firestore error:", error.localizedDescription)
                return
            }

            guard let document = document else {
                print("Documento nil")
                return
            }

            print("Document exists:", document.exists)

            if let data = document.data() {
                print("Firestore data:", data)
            }

            guard document.exists,
                  let data = document.data(),
                  let user = User(dictionary: data, uid: uid) else {

                self.showMessage(message: "Perfil inválido o incompleto.")
                return
            }

            print("Usuario cargado:", user)
        }

        /*db.collection("users").document(uid).getDocument { [weak self] document, error in
            guard let self = self else { return }

            if let error = error {
                print("Firestore error: \(error.localizedDescription)")
                self.showMessage(message: "Error al cargar perfil.")
                return
            }

            guard let document = document,
                  document.exists,
                  let data = document.data(),
                  let user = User(dictionary: data) else {

                self.showMessage(message: "Perfil inválido o incompleto.")
                return
            }
            //
            //
            print("Firestore data:", data)
            //
            //
            // Validar usuario activo
            guard user.active else {
                self.showMessage(message: "Usuario desactivado. Contacte al administrador.")
                return
            }

            print("Usuario cargado:", user)

            // Navegación en main thread
            DispatchQueue.main.async {
                self.goToViewController(role: user.rol)
            }
        }*/
    }

    
}


