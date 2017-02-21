//  Created by Yura Braiko on 20.02.17.
//  Copyright © 2017 Yura Braiko. All rights reserved.
//

import UIKit

class DrawingView: UIView {
    
    private var touchBeginPos = [CGPoint]()
    private var touchEndPos = [CGPoint]()
    private var touchMovePos = [CGPoint]()
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let h = frame.height
        let w = frame.width
        let color:UIColor = UIColor.red
        let circleBeginColor:UIColor = UIColor.green
        let circleMoveColor:UIColor = UIColor.blue
        let circleEndColor:UIColor = UIColor.cyan
        let circleR = min(h/50,w/50)
        
        let bpath:UIBezierPath = UIBezierPath(rect: rect)
        
        color.set()
        bpath.fill()
        
        if(touchMovePos.count>0){
            let linePath:UIBezierPath = UIBezierPath()
            linePath.move(to: touchMovePos[0])
            circleMoveColor.set()
            for tp in touchMovePos{
                linePath.addLine(to: tp)
                
                let circleR = circleR/2
                let myOvalRect = CGRect(x: tp.x-circleR, y: tp.y-circleR, width: circleR*2, height: circleR*2)
                let bpath:UIBezierPath = UIBezierPath(ovalIn: myOvalRect)
                
                bpath.fill()
            }
            linePath.lineWidth = circleR/4
            linePath.stroke()
        }
        
        
        circleBeginColor.set()
        for tp in touchBeginPos{
            let myOvalRect = CGRect(x: tp.x-circleR, y: tp.y-circleR, width: circleR*2, height: circleR*2)
            let bpath:UIBezierPath = UIBezierPath(ovalIn: myOvalRect)
            
            bpath.fill()
        }
        
        
        
        for tp in touchEndPos{
            let myOvalRect = CGRect(x: tp.x-circleR, y: tp.y-circleR, width: circleR*2, height: circleR*2)
            let bpath:UIBezierPath = UIBezierPath(ovalIn: myOvalRect)
            
            circleEndColor.set()
            bpath.fill()
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            touchBeginPos.append(touch.location(in: self))
        }
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            touchEndPos.append(touch.location(in: self))
        }
        self.setNeedsDisplay()
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            touchMovePos.append(touch.location(in: self))
        }
        self.setNeedsDisplay()

        
    }
    
    private class TouchPoint{
        init(_ xPos:CGFloat,_ yPos:CGFloat){
            self.x = xPos
            self.y = yPos
        }
        var x:CGFloat = 0
        var y:CGFloat = 0
    }
    
}
