//
//  TopNavigationStackView.swift
//  Taskly
//
//  Created by Vincent Angelo on 25/06/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit

protocol TopNavigationViewDelegate: class {
    func addTask()
}

class TopNavigationView: UIView {
    
    
    // MARK: - Properties
    let addButton = UIButton(type: .system)
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Taskly"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    weak var delegate: TopNavigationViewDelegate?
    
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        backgroundColor = .systemBlue
        
        addButton.setImage(#imageLiteral(resourceName: "icon_40pt"), for: .normal)
        
        
        addSubview(titleLabel)
        titleLabel.centerX(inView: self)
        
        addSubview(addButton)
        addButton.anchor(right: rightAnchor, paddingRight: 10)
        
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        
        addButton.addTarget(self, action: #selector(handleAddTask), for: .touchUpInside)
        
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    @objc func handleAddTask(){
        delegate?.addTask()
    }
}
