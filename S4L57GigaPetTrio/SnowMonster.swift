//
//  SnowMonster.swift
//  EnhancedGigapetS4L57
//
//  Created by Michel Besnard on 29-06-16.
//  Copyright © 2016 Michel YJL Besnard. All rights reserved.
//

import Foundation
import UIKit

class SnowMonster: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        self.animationImages = nil
        
//        playIdleAnimation1()
//        playIdleAnimation2()
        playIdleAnimation()
        
}

    func playIdleAnimation() {
        
        self.image = UIImage(named: "imIdle1.png") // sets the default image once the animation is completed
        self.animationImages = nil // empties the array to start fresh upon game restart
        
        var imgArray = [UIImage]()
        for x in 1...32 {
            let img = UIImage(named: "imIdle\(x).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0 // causes the animation to be infinite/loop
        self.startAnimating()
    }
    
    func playDeathAnimation() {
        
        self.image = UIImage(named: "imDeath20.png") // sets the default image once the animation is completed
        self.animationImages = nil // empties the array to start fresh upon game restart
        
        var imgArray = [UIImage]()
        for x in 1...20 {
            let img = UIImage(named: "imDeath\(x).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1 // causes animation to only play once
        self.startAnimating()
    }
    
}
