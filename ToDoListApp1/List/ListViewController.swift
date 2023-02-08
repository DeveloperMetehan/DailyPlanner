//
//  ListViewController.swift
//  ToDoListApp1
//
//  Created by Metehan Karadeniz on 10.01.2023.
//

import UIKit

class ListViewController: UIViewController {
    let categories = ["Doğa", "Manzara", "İnsan", "Bilgisayar", "Kültür", "Ekonomi","sgjsdlksdg","dspogksdg"]
    @IBOutlet weak var ListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ListTableView.delegate = self
        ListTableView.dataSource = self
        //make table view look good
        ListTableView.separatorStyle = .none
        ListTableView.showsVerticalScrollIndicator = false
    }
    @IBAction func CreateListBttn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PopUpForListVC") as! PopUpForListVC
        vc.modalPresentationStyle = .popover
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func backToHomeBttn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
extension ListViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ListTableView.dequeueReusableCell(withIdentifier: "listCell") as! ListTableViewCell
        cell.listNameLabel.text = categories[indexPath.row]
        cell.listColorView.layer.cornerRadius = 4
        cell.listView.layer.cornerRadius = 14
        return cell
    }
}
