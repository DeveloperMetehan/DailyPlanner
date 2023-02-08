//
//  PopUpForListVC.swift
//  ToDoListApp1
//
//  Created by Metehan Karadeniz on 11.01.2023.
//

import UIKit

class PopUpForListVC: UIViewController {

    @IBOutlet weak var newListTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editTextField()
       
    }
    func editTextField(){
        newListTextField.layer.borderWidth = 2
        newListTextField.layer.borderColor = UIColor(hex: "FFC300").cgColor
        newListTextField.layer.cornerRadius = newListTextField.frame.height/2
        newListTextField.layer.masksToBounds = true
    }

    
    @IBAction func bttnClickedForCancel(_ sender: Any)
    {
        self.dismiss(animated: true)
    }
}
