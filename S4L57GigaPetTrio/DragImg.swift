//
//  DragImg.swift
//  MyLittleMonster
//
//  Created by Michel Besnard on 23-06-16.
//  Copyright © 2016 Michel YJL Besnard. All rights reserved.
//

import Foundation
import UIKit

class DragImg: UIImageView {
    
    var originalPosition: CGPoint!
    var dropTarget: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        originalPosition = self.center
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: self.superview)
            self.center = position
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first, let target = dropTarget {
            let position = touch.location(in: self.superview)
            if target.frame.contains(position) {

                NotificationCenter.default().post(NSNotification(name: "onTargetDropped" as NSNotification.Name, object: nil) as Notification)
                
            }
        }
        
        self.center = originalPosition
    }
    
    
}
