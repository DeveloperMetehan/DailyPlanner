//
//  ViewController.swift
//  ToDoListApp1
//
//  Created by Metehan Karadeniz on 8.01.2023.
//

import UIKit

final class HomeViewController: UIViewController {
    // MARK: - UI Elements
    @IBOutlet weak var trashImageView: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var homeTableView: UITableView!
    // MARK: - Variables
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTodoList()
        // TODO: - Transport to custom tableView
        homeTableView.delegate = self
        homeTableView.dataSource = self
        //make table view look good
        homeTableView.separatorStyle = .none
        homeTableView.showsVerticalScrollIndicator = false
    }
    
    func getTodoList() {
        viewModel.getTodoList()
        trashImageView.isHidden = !(self.viewModel.todoList.count == 0)
        homeTableView.reloadData()
    }

   @IBAction func hamburgerBttn(_ sender: Any) {
       let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "ListVC") as! ListViewController
       secondVC.modalPresentationStyle = .custom
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
        self.navigateToCreateNote()
    }
    
}
extension HomeViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTableView.dequeueReusableCell(withIdentifier: "homeCell") as! HomeTableViewCell
        cell.configure(with: viewModel.todoList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigateToDetail(with: self.viewModel.todoList[indexPath.row])
    }
}

// MARK: - Transitions
extension HomeViewController {
    func navigateToCreateNote() {
        guard let noteController = storyboard?.instantiateViewController(identifier: "NoteViewController", creator: { coder in
            let viewModel = AddNoteViewModel()
            return NoteViewController(coder: coder, viewModel: viewModel)
        }) as? NoteViewController else { fatalError("NoteViewController failed to be initialized") }
        noteController.modalPresentationStyle = .overFullScreen
        noteController.didSaveTap = { [weak self] in
            self?.getTodoList()
        }
        self.present(noteController, animated: true, completion: nil)
    }
  
    func navigateToDetail(with todo: Todo) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TaskDetailViewController") as! TaskDetailViewController
        vc.modalPresentationStyle = .overFullScreen
        // TODO: - Don't forget to pass object
        /*
        vc.nameLabel.text = self.nameArray[indexPath.row]
        vc.setNewDeadlineTextField.text = self.dateArray[indexPath.row]
        vc.descriptionTextField.text = self.descriptionArray[indexPath.row]
        */
        self.present(vc, animated: true, completion: nil)
    }
}
