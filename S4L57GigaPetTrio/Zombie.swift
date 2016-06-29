//
//  Zombie.swift
//  EnhancedGigapetS4L57
//
//  Created by Michel Besnard on 29-06-16.
//  Copyright © 2016 Michel YJL Besnard. All rights reserved.
//

import Foundation
import UIKit

class Zombie: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        playIdleAnimation()
        
}

    func playIdleAnimation() {
        
        self.image = UIImage(named: "hmIdle1.png") // sets the default image once the animation is completed
        self.animationImages = nil // empties the array to start fresh upon game restart
        
        var imgArray = [UIImage]()
        for y in 1...32 {
            let img = UIImage(named: "hmIdle\(y).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0 // causes the animation to be infinite/loop
        self.startAnimating()
    }
    
    func playDeathAnimation() {
        
        self.image = UIImage(named: "hmDeath20.png") // sets the default image once the animation is completed
        self.animationImages = nil // empties the array to start fresh upon game restart
        
        var imgArray = [UIImage]()
        for y in 1...20 {
            let img = UIImage(named: "hmDeath\(y).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1 // causes animation to only play once
        self.startAnimating()
}
}
