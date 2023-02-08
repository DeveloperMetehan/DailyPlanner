//
//  HomeTableViewCell.swift
//  ToDoListApp1
//
//  Created by Metehan Karadeniz on 8.01.2023.
//

import UIKit

final class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var notesView: UIView!
    @IBOutlet weak var checkBttn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        notesView.layer.cornerRadius = 20
    }
    
    func configure(with todo: Todo) {
        titleLabel.text = todo.name
        // TODO: - Don't forget to get day string and today check
        let day = Calendar.current.component(.day, from: todo.date)
        timeLabel.text = "\(day)"
    }
}
