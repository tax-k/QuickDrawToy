//
//  Canvas.swift
//  QuickDrawToy
//
//  Created by tax_k on 02/02/2019.
//  Copyright © 2019 tax_k. All rights reserved.
//

import UIKit

class Canvas:UIView {
    
    fileprivate var strokeColor = UIColor.black
    fileprivate var strokeWidth:Float = 3
    
    func setStrokeColor(color:UIColor){
        self.strokeColor = color
    }
    
    func setStrokeWidth(width: Float){
        self.strokeWidth = width
    }
    
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
        
        context.setLineCap(CGLineCap.butt)
        
        lines.forEach { (line) in
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(CGFloat(line.strokeWidth))
            for (idx, value) in line.points.enumerated() {
                if idx == 0 {
                    context.move(to: value)
                }else {
                    context.addLine(to: value)
                }
            }
            context.strokePath()
        }
    }
    
    var lines = [Line]()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line.init(strokeWidth: strokeWidth, color: strokeColor, points: []))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else {
            return
        }
        
        guard var lastLine = lines.popLast() else { return }
        lastLine.points.append(point)
        lines.append(lastLine)
        
        setNeedsDisplay()
    }
}
