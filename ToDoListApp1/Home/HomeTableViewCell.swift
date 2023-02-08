//
//  HomeTableViewCell.swift
//  ToDoListApp1
//
//  Created by Metehan Karadeniz on 8.01.2023.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var notesView: UIView!
    @IBOutlet weak var checkBttn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
  
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }

}
