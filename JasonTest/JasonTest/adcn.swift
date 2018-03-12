//
//  adcn.swift
//  JasonTest
//
//  Created by Володимир Смульський on 3/5/18.
//  Copyright © 2018 Володимир Смульський. All rights reserved.
//

import UIKit

class adcn: UIView {

    
//     Only override draw() if you perform custom drawing.
//     An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        let r = CGRect(x: 10, y: 10, width: 50, height: 50)
        
        let context = UIGraphicsGetCurrentContext()
        context?.move(to: r.origin)
        context?.addEllipse(in: r)
        context?.fillPath()
        
//         let b = UIBezierPath(roundedRect: r, cornerRadius: r.height*0.5)
//        b.fill()
        let s = NSString(string: "asdf")
        s.draw(at: CGPoint(x:120, y:20), withAttributes: nil)
    }
    

}
