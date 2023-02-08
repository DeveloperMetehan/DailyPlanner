//
//  ListTableViewCell.swift
//  ToDoListApp1
//
//  Created by Metehan Karadeniz on 11.01.2023.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var listColorView: UIView!
    @IBOutlet weak var listNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
  
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
