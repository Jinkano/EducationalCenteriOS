//
//  EmployeeRegistrationVC.swift
//  EducationalCenter
//
//  Created by Mananas on 9/12/25.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class RegisterUserVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource
{
    /**/
    @IBOutlet weak var tfRolUser: UITextField!
    @IBOutlet weak var tfNameUser: UITextField!
    @IBOutlet weak var tfEmailUser: UITextField!
    @IBOutlet weak var tvAddressUser: UITextView!
    @IBOutlet weak var tfPasswordUser: UITextField!
    
    /**/
    let roles = ["director", "secretaria", "profesor", "alumno"]
    let picker = UIPickerView()

    
    /**/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Apariencia similar a UITextField
        tvAddressUser.layer.borderColor = UIColor.systemGray4.cgColor
        tvAddressUser.layer.borderWidth = 0.5
        tvAddressUser.layer.cornerRadius = 3.0
        // Padding interno (para que el texto no quede pegado al borde)
        tvAddressUser.textContainerInset = UIEdgeInsets(top: 8, left: 5, bottom: 8, right: 5)
        // Opcional: Fondo blanco
        //tvAddress.backgroundColor = .white
        // Opcional: Fuente similar a UITextField
        //tvAddress.font = UIFont.systemFont(ofSize: 17)
        
        /**/
        picker.delegate = self
        picker.dataSource = self
        tfRolUser.inputView = picker
    }
    
    /* Picker */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {1}
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        roles.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return roles[row].capitalized
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tfRolUser.text = roles[row].capitalized   // lo que ve el usuario
        tfRolUser.tag = row                       // índice del rol seleccionado
    }

    // Convierte a minúsculas antes de guardar en Firestore
    func selectedRole() -> String {
        return roles[tfRolUser.tag].lowercased()
    }
    
    /**/
    @IBAction func saveRecord(_ sender: Any)
    {
        // Validación de text fields
        if (!validateData())
        {
            return
        }
        
        //
        let email = tfEmailUser.text ?? ""
        let password = tfPasswordUser.text ?? ""
        let name = tfNameUser.text ?? ""
        let rol = tfRolUser.text?.lowercased() ?? ""
        
        
        // Guardar usuario y contraseña
        Auth.auth().createUser(withEmail: email, password: password){ [unowned self] authResult, error in
            if let error = error
            {
                print(error.localizedDescription)
                self.showMessage(message: error.localizedDescription)
                return
            }
            
            // Capturamos el id del nuevo empleado
            let newId = authResult!.user.uid
            print("SOLO PARA COMPROBAR  " + newId)
            
            /* METODO PROFE/
            let employee = Employee(uid: userId, role: role, name: name, email: email)
            do {
                let db = Firestore.firestore()
                try db.collection("Employee").document(userId).setData(from: employee)
            } catch let error {
                print("Error writing user to Firestore: \(error)")
                self.showMessage(message: error.localizedDescription)
                return
            }
            print("User created account successfully")
            self.showMessage(title: "Create account", message: "Account created successfully")*/
            
            /*/ --- LÓGICA PARA OBTENER EL ROL ---
             let selectedIndex = roleSegmentedControl.selectedSegmentIndex
             let role: String
             
             switch selectedIndex {
             case 0:
             role = "secretaria"
             case 1:
             role = "profesor"
             case 2:
             role = "alumno"
             default:
             // Manejo de error
             self.showMessage(message: "Debe seleccionar un rol.")
             return
             }*/
            
            // 4. Crear la cuenta y guardar en Firestore
            //uid: userId, role: role, name: name, email: email
            self.saveUserDataToFirestore(uid: newId, rol: rol, name: name, email: email)
        }
        
        /**/
        func validateData() -> Bool
        {
            if tfRolUser.text?.isEmpty ?? true
            {
                showMessage(message: "Ingresa la categoría del empleado")
                return false
            }
            if tfNameUser.text?.isEmpty ?? true
            {
                showMessage(message: "Ingresa el nombre del empleado.")
                return false
            }
            if tfEmailUser.text?.isEmpty ?? true
            {
                showMessage(message: "Ingresa el correo electrónico del empleado.")
                return false
            }
            if tfPasswordUser.text?.isEmpty ?? true
            {
                showMessage(message: "Ingresa la clave de acceso del empleado.")
                return false
            }
            /*if passwordTextField.text != passwordRepeatTextField.text {
             showMessage(message: "Password do not match repeat password")
             return false
             }*/
            return true
        }
        
        
    }
    
    
    /*uid role name email*/
    func saveUserDataToFirestore(uid: String, rol: String, name: String, email: String)
    {
        let db = Firestore.firestore()
        
        // Datos a guardar
        let userData: [String: Any] = [
            "active": true,
            "email": email,
            "name": name,
            "createdAt": FieldValue.serverTimestamp(),
            "rol": rol
        ]
        
        // Escribiendo en el documento del nuevo empleado
            db.collection("users").document(uid).setData(userData) { error in
                if let error = error {
                    print("Error al guardar datos en Firestore: \(error.localizedDescription)")
                    
                    return
                }
                
                self.showMessage(message: "Registro de \(rol) exitoso.")
                
            }
    }
}
