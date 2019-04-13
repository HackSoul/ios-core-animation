//
//  TreeView.swift
//  ios-animation
//
//  Created by jiyou xu on 2019/4/13.
//  Copyright © 2019 jiyou xu. All rights reserved.
//

import UIKit

class TreeView: UIView {
    
    lazy var menuItems: [TreeViewSub] = {
        let sub1 = TreeViewSub(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        sub1.setImage(imgStr: "s1")
        let sub2 = TreeViewSub(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        sub2.setImage(imgStr: "s2")
        let sub3 = TreeViewSub(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        sub3.setImage(imgStr: "s3")
        let sub4 = TreeViewSub(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        sub4.setImage(imgStr: "s4")
        let sub5 = TreeViewSub(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        sub5.setImage(imgStr: "s4")
        
        let items = [sub1, sub2, sub3, sub4, sub5]
        return items
    }()
    lazy var mainView: TreeViewTrunk = {
        let trunkView = TreeViewTrunk(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        trunkView.setImage(imgStr: "center")
        return trunkView
    }()
    
    lazy var startPoint: CGPoint = {
        return CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
    }()
    var endDistance: CGFloat = 30.0
    var nearDistance: CGFloat = 60.0
    var farDistance: CGFloat = 30.0
    
    var isExpend: Bool = false
    var scale: Bool = true

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        self.addSubview(mainView)
        layoutItems()
    }
    
    func layoutItems() {
        
        let count = menuItems.count
        var cnt:Double = 1.0;
        for i in 0...count - 1 {
            let item = menuItems[i]
            item.startPoint = self.startPoint
            item.tag = 1000 + i;
            let pi = Double.pi / Double(count)
            let endRadius = item.bounds.size.width / 2 + self.endDistance + mainView.bounds.size.width / 2;
            let nearRadius = item.bounds.size.width / 2 + self.nearDistance + mainView.bounds.size.width / 2;
            let farRadius = item.bounds.size.width / 2 + self.farDistance + mainView.bounds.size.width / 2;
            item.endPoint = CGPoint(
                x: self.startPoint.x + endRadius * CGFloat(sinf(Float(pi * cnt))),
                y: self.startPoint.y - endRadius * CGFloat(cosf(Float(pi * cnt)))
            );
            item.nearPoint = CGPoint(
                x: self.startPoint.x + nearRadius * CGFloat(sinf(Float(pi * cnt))),
                y: self.startPoint.y - nearRadius * CGFloat(cosf(Float(pi * cnt)))
            );
            item.farPoint = CGPoint(
                x: self.startPoint.x + farRadius * CGFloat(sinf(Float(pi * cnt))),
                y: self.startPoint.y - farRadius * CGFloat(cosf(Float(pi * cnt)))
            );
            
            self.addSubview(item)
            
            item.center = item.startPoint!;
            self.mainView.center = item.center;
            print(self.center)
            print(self.mainView.center)
            
            
            cnt += 2;
        }
        
        self.bringSubviewToFront(mainView)
    }
    
    func expand(isExpend: Bool) {
        self.isExpend = isExpend
        let enumeratedSequence = self.menuItems.enumerated()
        enumeratedSequence.forEach({offset, item in
            if self.scale {
                if (isExpend) {
                    item.transform = .identity
                } else {
                    item.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                }
            }
            addRotateAndPostisionForItem(item: item, show: isExpend)
        })
    }
    
    func addRotateAndPostisionForItem(item: TreeViewSub, show: Bool) {
        if show {
            var springAnimation: CASpringAnimation?
            if (self.scale) {
                springAnimation = CASpringAnimation(keyPath: "transform.scale")
                springAnimation?.damping = 5
                springAnimation?.stiffness = 100
                springAnimation?.mass = 1
                springAnimation?.duration = 0.5
                springAnimation?.fromValue = 0.2
                springAnimation?.toValue = 1.0
            }
            let rotateAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
            rotateAnimation.values = [Double.pi, 0.0]
            rotateAnimation.duration = 0.5
            rotateAnimation.keyTimes = [0.3, 0.4]
            
            let positionAnimation = CAKeyframeAnimation(keyPath: "position")
            positionAnimation.duration = 0.5
            let path = CGMutablePath()
            path.move(to: CGPoint(x: item.startPoint!.x, y: item.startPoint!.y))
            path.addLine(to: CGPoint(x: item.farPoint!.x, y: item.farPoint!.y))
            path.addLine(to: CGPoint(x: item.nearPoint!.x, y: item.nearPoint!.y))
            path.addLine(to: CGPoint(x: item.endPoint!.x, y: item.endPoint!.y))
            positionAnimation.path = path
            
            let animationgroup = CAAnimationGroup()
            if self.scale {
                animationgroup.animations = [positionAnimation, rotateAnimation, springAnimation!]
            } else {
                animationgroup.animations = [positionAnimation, rotateAnimation]
            }
            animationgroup.duration = 0.5
            animationgroup.fillMode = .forwards
            animationgroup.timingFunction = CAMediaTimingFunction(name: .easeIn)
            item.layer.add(animationgroup, forKey: "Expand")
            item.center = item.endPoint!;
        } else {
            var springAnimation: CASpringAnimation?
            if (self.scale) {
                springAnimation = CASpringAnimation(keyPath: "transform.scale")
                springAnimation?.damping = 5
                springAnimation?.stiffness = 100
                springAnimation?.mass = 1
                springAnimation?.duration = 0.5
                springAnimation?.fromValue = 1.0
                springAnimation?.toValue = 0.7
            }
            let rotateAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
            rotateAnimation.values = [0.0, Double.pi * 2, 0.0]
            rotateAnimation.duration = 0.5
            rotateAnimation.keyTimes = [0.0, 0.4, 0.5]
            
            let positionAnimation = CAKeyframeAnimation(keyPath: "position")
            positionAnimation.duration = 0.5
            let path = CGMutablePath()
            path.move(to: CGPoint(x: item.endPoint!.x, y: item.endPoint!.y))
            path.addLine(to: CGPoint(x: item.farPoint!.x, y: item.farPoint!.y))
            path.addLine(to: CGPoint(x: item.startPoint!.x, y: item.startPoint!.y))
            positionAnimation.path = path
            
            let animationgroup = CAAnimationGroup()
            if self.scale {
                animationgroup.animations = [positionAnimation, rotateAnimation, springAnimation!]
            } else {
                animationgroup.animations = [positionAnimation, rotateAnimation]
            }
            animationgroup.duration = 0.5
            animationgroup.fillMode = .forwards
            animationgroup.timingFunction = CAMediaTimingFunction(name: .easeIn)
            item.layer.add(animationgroup, forKey: "Close")
            item.center = item.startPoint!;
        }
    }
 

}
