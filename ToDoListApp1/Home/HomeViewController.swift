//
//  ViewController.swift
//  ToDoListApp1
//
//  Created by Metehan Karadeniz on 8.01.2023.
//

import UIKit

class HomeViewController: UIViewController {
    var nameArray = [String]()
    var dateArray = [String]()
    var descriptionArray = [String]()
    var currentDate = ""
    
    
    @IBOutlet weak var trashImageView: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var homeTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        findCurrentDate()
        //veriyi çek
        getData()
       
        if nameArray.count == 0 {
            trashImageView.isHidden = false
        } else {
            trashImageView.isHidden = true
        }
        homeTableView.delegate = self
        homeTableView.dataSource = self
        //make table view look good
        homeTableView.separatorStyle = .none
        homeTableView.showsVerticalScrollIndicator = false
    }
    
    func findCurrentDate(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let dateString = dateFormatter.string(from: Date() as Date)
        currentDate = dateString
    }
    
    func getData(){
        nameArray.removeAll(keepingCapacity: false)
        dateArray.removeAll(keepingCapacity: false)
        descriptionArray.removeAll(keepingCapacity: false)
        
        let todoList = CoreDataManager.shared.fetch()
        
       /* print(todoList.first?.name)
        print(todoList.first?.date)
        print(todoList.first?.detail_description)*/
        
        for n in todoList {
            nameArray.append(n.name)
            dateArray.append(n.date)
            descriptionArray.append(n.detail_description)
        }
        
    }
   @IBAction func hamburgerBttn(_ sender: Any) {
       let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "ListVC") as! ListViewController
       secondVC.modalPresentationStyle = .custom
       secondVC.transitioningDelegate = self
       self.present(secondVC, animated: true, completion: nil)
    }
    
    @IBAction func notifibttn(_ sender: Any) {
        
    }
    
    @IBAction func filterBttn(_ sender: Any) {
        
    }
    
    @IBAction func sortBttn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PopUpViewController") as! PopUpViewController
        vc.modalPresentationStyle = .formSheet
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func toCreatingVCBttn(_ sender: Any) {
      
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreatingNewTaskVC") as! CreatingNoteViewController
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}
extension HomeViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTableView.dequeueReusableCell(withIdentifier: "homeCell") as! HomeTableViewCell
        cell.titleLabel.text = nameArray[indexPath.row]
        if currentDate == dateArray[indexPath.row]{
            cell.timeLabel.text = "Today"
        } else {
            cell.timeLabel.text = dateArray[indexPath.row]
        }
        cell.notesView.layer.cornerRadius = 20
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TaskDetailViewController") as! TaskDetailViewController
        vc.modalPresentationStyle = .overFullScreen
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
            vc.nameLabel.text = self.nameArray[indexPath.row]
            vc.setNewDeadlineTextField.text = self.dateArray[indexPath.row]
            vc.descriptionTextField.text = self.descriptionArray[indexPath.row]
            
        }
        self.present(vc, animated: true, completion: nil)
    }
}
extension HomeViewController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentTransition()
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissTransition()
    }
    
}
