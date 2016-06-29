//
//  Robot.swift
//  EnhancedGigapetS4L57
//
//  Created by Michel Besnard on 29-06-16.
//  Copyright © 2016 Michel YJL Besnard. All rights reserved.
//

import Foundation
import UIKit

class Robot: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        self.animationImages = nil
        
        playIdleAnimation()
//        playIdleAnimation2()
//        playIdleAnimation3()
//        
    }



func playIdleAnimation() {
    
    self.image = UIImage(named: "dmIdle1.png") // sets the default image once the animation is completed
    self.animationImages = nil // empties the array to start fresh upon game restart
    
    var imgArray = [UIImage]()
    for x in 1...11 {
        let img = UIImage(named: "dmIdle\(x).png")
        imgArray.append(img!)
    }
    
    self.animationImages = imgArray
    self.animationDuration = 0.8
    self.animationRepeatCount = 0 // causes the animation to be infinite/loop
    self.startAnimating()
}

func playDeathAnimation() {
    
    self.image = UIImage(named: "dmDeath15.png") // sets the default image once the animation is completed
    self.animationImages = nil // empties the array to start fresh upon game restart
    
    var imgArray = [UIImage]()
    for x in 1...15 {
        let img = UIImage(named: "dmDeath\(x).png")
        imgArray.append(img!)
    }
    
    self.animationImages = imgArray
    self.animationDuration = 0.8
    self.animationRepeatCount = 1 // causes animation to only play once
    self.startAnimating()
    }
}
