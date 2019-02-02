//
//  Canvas.swift
//  QuickDrawToy
//
//  Created by tax_k on 02/02/2019.
//  Copyright © 2019 tax_k. All rights reserved.
//

import UIKit

class Canvas:UIView {
    func undo(){
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func clear(){
        lines.removeAll()
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        context.setStrokeColor(UIColor.red.cgColor)
        context.setLineWidth(8)
        context.setLineCap(CGLineCap.butt)
        
        lines.forEach { (line) in
            for (idx, value) in line.enumerated() {
                if idx == 0 {
                    context.move(to: value)
                }else {
                    context.addLine(to: value)
                }
            }
            
        }
        
        context.strokePath()
    }
    
    var lines = [[CGPoint]]()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else {
            return
        }
        
        
        guard var lastLine = lines.popLast() else { return }
        lastLine.append(point)
        lines.append(lastLine)
        
        setNeedsDisplay()
    }
}
