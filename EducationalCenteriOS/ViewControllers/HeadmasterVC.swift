//
//  ViewController.swift
//  EducationalCenter
//
//  Created by Mananas on 2/12/25.
//

import UIKit

class ViewController: UIViewController
{
    /* Esta variable recibirá los datos del usuario */
    var currentUser: User?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let user = currentUser {
                    print("Bienvenido Director: \(user.name)")
                    // Aquí puedes actualizar labels, etc.
                }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
