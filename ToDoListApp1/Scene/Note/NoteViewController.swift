//
//  CreatingNoteViewController.swift
//  ToDoListApp1
//
//  Created by Metehan Karadeniz on 9.01.2023.
//

import UIKit

final class NoteViewController: UIViewController {
    @IBOutlet weak var collectionViewForCategories: UICollectionView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    let datePicker = UIDatePicker()
    
    var didSaveTap: (() -> ())?
    
    var textFieldBtn: UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "dateTextFieldIcon"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: -7, left: 0, bottom: 8, right: 0)
        button.frame = CGRect(x: CGFloat(dateTextField.frame.size.width - 40), y: CGFloat(5), width: CGFloat(35), height: CGFloat(30))
        // button.addTarget(self, action: #selector(datePickerBttnTapped), for: UIControl.Event.touchUpInside)
        return button
    }
    
    private let viewModel: NoteViewModel
    
    init?(coder: NSCoder, viewModel: NoteViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
       
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        editTextfield()
    }
    
    func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let donebtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([donebtn], animated: true)
        
        return toolbar
    }
    func createDatePicker() {
        
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        dateTextField.textAlignment = .center
        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = createToolbar()
    }
    @objc func donePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        self.dateTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    func editTextfield(){
        let bottomLine = CALayer()
        let bottomLine2 = CALayer()
        let bottomLine3 = CALayer()
        bottomLine.frame = CGRect(x: 0, y: nameTextField.frame.height, width: nameTextField.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.init(hex: "BBBCBF").cgColor
        bottomLine2.frame = CGRect(x: 0, y: dateTextField.frame.height, width: dateTextField.frame.width, height: 2)
        bottomLine2.backgroundColor = UIColor.init(hex: "BBBCBF").cgColor
        bottomLine3.frame = CGRect(x: 0, y: nameTextField.frame.height, width: nameTextField.frame.width, height: 2)
        bottomLine3.backgroundColor = UIColor.init(hex: "BBBCBF").cgColor
        nameTextField.layer.addSublayer(bottomLine)
        dateTextField.layer.addSublayer(bottomLine2)
        descriptionTextField.layer.addSublayer(bottomLine3)
        
        dateTextField.rightView = textFieldBtn
        dateTextField.rightViewMode = .always
    }
    
    @IBAction func bttnClickedForCreate(_ sender: Any) {
        self.viewModel.didClickSaveButton(name: nameTextField.text!, detailDescription: descriptionTextField.text!)
        didSaveTap?()
        dismiss(animated: true)
    }
}

// MARK: - Transitions

extension NoteViewController {
    @IBAction func toHomeBackBttn(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
