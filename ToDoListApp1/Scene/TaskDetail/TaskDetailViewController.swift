//
//  TaskDetailViewController.swift
//  ToDoListApp1
//
//  Created by Metehan Karadeniz on 11.01.2023.
//

import UIKit

class TaskDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var setNewDeadlineTextField: UITextField!
    @IBOutlet weak var addNoteTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editTextfield()
        
    }
    
    func editTextfield(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: setNewDeadlineTextField.frame.height, width: setNewDeadlineTextField.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.init(hex: "BBBCBF").cgColor
        setNewDeadlineTextField.layer.addSublayer(bottomLine)
        let bottomLine2 = CALayer()
        bottomLine2.frame = CGRect(x: 0, y: addNoteTextField.frame.height, width: addNoteTextField.frame.width, height: 2)
        bottomLine2.backgroundColor = UIColor.init(hex: "BBBCBF").cgColor
        addNoteTextField.layer.addSublayer(bottomLine2)
        let bottomLine3 = CALayer()
        bottomLine3.frame = CGRect(x: 0, y: descriptionTextField.frame.height, width: descriptionTextField.frame.width, height: 2)
        bottomLine3.backgroundColor = UIColor.init(hex: "BBBCBF").cgColor
        descriptionTextField.layer.addSublayer(bottomLine3)
    }
    
    @IBAction func backToHomeBttn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            vc.modalPresentationStyle = .currentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    
}

  

