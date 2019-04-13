//
//  ViewController.swift
//  ios-animation
//
//  Created by jiyou xu on 2019/4/13.
//  Copyright © 2019 jiyou xu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var expandButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.orange
        button.setTitle("显示", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        
    }


}

