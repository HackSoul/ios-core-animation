//
//  TreeViewTrunk.swift
//  ios-animation
//
//  Created by jiyou xu on 2019/4/13.
//  Copyright © 2019 jiyou xu. All rights reserved.
//

import UIKit

class TreeViewTrunk: UIView {
    
    lazy var imageV: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        imageV.frame = rect
        self.addSubview(imageV)
    }
    
    func setImage(imgStr: String) {
        imageV.image = UIImage(named: imgStr)
    }
 

}
