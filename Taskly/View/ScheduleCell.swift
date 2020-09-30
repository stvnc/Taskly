//
//  ScheduleCell.swift
//  Taskly
//
//  Created by Vincent Angelo on 25/06/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit

class ScheduleCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
