//
//  TodayTableViewCell.swift
//  Today
//
//  Created by MasamichiUeta on 2015/12/21.
//  Copyright © 2015年 Masamichi Ueta. All rights reserved.
//

import UIKit
import TodayKit

class TodayTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scoreCircleView: TodayScoreCircleView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        scoreCircleView.animated = false
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

private let dateFormatter: NSDateFormatter = {
    let formatter = NSDateFormatter()
    formatter.dateStyle = .MediumStyle
    formatter.timeStyle = .NoStyle
    formatter.doesRelativeDateFormatting = true
    return formatter
}()


extension TodayTableViewCell: ConfigurableCell {
    func configureForObject(today: Today) {
        dateLabel.text = dateFormatter.stringFromDate(today.date)
        scoreCircleView.score = Int(today.score)
        scoreLabel.text = "\(today.score)"
        scoreLabel.textColor = today.type.color()
        iconImageView.image = today.type.icon("28")
        iconImageView.tintColor = today.type.color()
    }
}
