//
//  CreatingNoteViewController.swift
//  ToDoListApp1
//
//  Created by Metehan Karadeniz on 9.01.2023.
//

import UIKit
import CoreData
class CreatingNoteViewController: UIViewController {
    
    let categories = ["Doğa", "Manzara", "İnsan", "Bilgisayar", "Kültür", "Ekonomi","sgjsdlksdg","dspogksdg"]
    @IBOutlet weak var collectionViewForCategories: UICollectionView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    let datePicker = UIDatePicker()

    var textFieldBtn: UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "dateTextFieldIcon"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: -7, left: 0, bottom: 8, right: 0)
        button.frame = CGRect(x: CGFloat(dateTextField.frame.size.width - 40), y: CGFloat(5), width: CGFloat(35), height: CGFloat(30))
       // button.addTarget(self, action: #selector(datePickerBttnTapped), for: UIControl.Event.touchUpInside)
        return button
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        
        collectionViewForCategories.setCollectionViewLayout(layout, animated: true)
        collectionViewForCategories.delegate = self
        collectionViewForCategories.dataSource = self
        
        editTextfield()
       
    }
    @IBAction func toHomeBackBttn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
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
        //Attributeslere değerlerini atama
        CoreDataManager.shared.insert(name: nameTextField.text!, detail_description: descriptionTextField.text!, date: dateTextField.text!)
       
        //Kaydetme
            //save fonksiyonunu çağırıp kaydedeceksin.
        CoreDataManager.shared.save()
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    
}

extension CreatingNoteViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return categories.count
}
    
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? CreatingCollectionViewCell else { return UICollectionViewCell() }
    cell.categoryNameLabel.text = categories[indexPath.row]
    return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let gridLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 3 - gridLayout.minimumInteritemSpacing
        return CGSize(width:widthPerItem, height:60)
    } 
}
