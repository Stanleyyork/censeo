//
//  ExpenseView.swift
//  censeo
//
//  Created by Stanley Stevens on 10/10/17.
//  Copyright © 2017 Stanley Stevens. All rights reserved.
//

import UIKit
@IBDesignable
class ExpenseView: UIView {

    var lineWidth: CGFloat = 4.0
    var scale: CGFloat = 0.9
    
    private var circleCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    private var circleRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }
    
    private func pathForCircle() -> UIBezierPath {
        let path = UIBezierPath(arcCenter: circleCenter, radius: circleRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        path.lineWidth = lineWidth
        UIColor.white.set()
        path.fill()
        return path
    }
    
    override func draw(_ rect: CGRect) {
        pathForCircle().stroke()
    }

}
