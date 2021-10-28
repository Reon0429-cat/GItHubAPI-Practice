//
//  CustomTableViewCell.swift
//  GItHubAPI-Practice
//
//  Created by 大西玲音 on 2021/10/29.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var commitCountLabel: UILabel!
    
    static var identifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }

    func configure(name: String, commitCount: Int) {
        nameLabel.text = name
        commitCountLabel.text = String(commitCount)
    }
    
}
