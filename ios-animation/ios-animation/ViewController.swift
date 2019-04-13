//
//  ViewController.swift
//  ios-animation
//
//  Created by jiyou xu on 2019/4/13.
//  Copyright © 2019 jiyou xu. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    lazy var expandButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.orange
        button.setTitle("显示", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 4.0
        button.addTarget(self, action: #selector(tapbutton), for: .touchUpInside)
        self.view.addSubview(button)
        return button
    }()
    
    lazy var treeView: TreeView = {
        let tv = TreeView()
        self.view.addSubview(tv)
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
       
        
        expandButton.snp_makeConstraints({make in
            make.bottom.equalToSuperview().offset(-100)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(42)
        })
        
        treeView.snp_makeConstraints({make in
            make.center.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(100)
        })
    }
    
    @objc func tapbutton(button: UIButton) {
        if self.treeView.isExpend {
            self.expandButton.setTitle("显示", for: .normal)
            self.treeView.expand(isExpend: false)
        } else {
            self.expandButton.setTitle("隐藏", for: .normal)
            self.treeView.expand(isExpend: true)
        }
    }


}

