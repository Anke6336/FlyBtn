//
//  FlyButton.swift
//  ZYSS
//
//  Created by ZLX on 2019/6/21.
//  Copyright © 2019 Zhanglx. All rights reserved.
//

import UIKit

class FlyButton: UIButton {

    typealias clickEvent = (() -> Void)
    
    let kEdgeMargin: CGFloat = 5.0
    let kAnimateTime: TimeInterval = 0.25
    var clicked: clickEvent?

    var p_start: CGPoint?
    var isDrag: Bool?
    
    func addFlyAttributeEvent(clickEvent: clickEvent?) {
        
        isDrag = false
        p_start = center
        
        if clickEvent != nil {
            clicked = clickEvent
        }
        
        addTarget(self, action: #selector(dragMoving(btn: event:)), for: .touchDragInside)
        addTarget(self, action: #selector(dragEnd(btn:event:)), for: .touchUpInside)
    }
    
    @objc func dragMoving(btn: UIButton, event: UIEvent) -> Void {

        guard let touch = event.allTouches?.first else {
            print("⚠️ 无法获取 Touch ⚠️ ")
            return
        }
        
        var point = touch.location(in: superview)
        
        if !isDrag! {
            p_start = point
            isDrag = true
        }
        
        let x = point.x as CGFloat
        let y = point.y as CGFloat
        
        let btnx = btn.frame.size.width / 2
        let btny = btn.frame.size.height / 2
        
        if x <= btnx {
            point.x = btnx + kEdgeMargin
        }
        
        if x >= (superview?.bounds.size.width)! - btnx {
            point.x = (superview?.bounds.size.width)! - btnx - kEdgeMargin
        }
        
        if y <= btny {
            point.y = btny + kEdgeMargin
        }
        
        if y >= (superview?.bounds.size.height)! - btny - 45 {
            point.y = (superview?.bounds.size.height)! - btny - kEdgeMargin
        }
        
        UIView.animate(withDuration: kAnimateTime) {
            btn.center = point
        }
    }
    
    @objc func dragEnd(btn: UIButton, event: UIEvent) -> Void {
        
        guard let touch = event.allTouches?.first else {
            print("⚠️ 无法获取 Touch ⚠️ ")
            return
        }
        
        isDrag = false
        
        var point = touch.location(in: superview)
        let p_end = point
        let x = point.x as CGFloat
        let y = point.y as CGFloat
        
        let btnx = btn.frame.size.width / 2
        let btny = btn.frame.size.height / 2
        
        if x <= (superview?.bounds.size.width)! / 2  {
            point.x = btnx + kEdgeMargin
        }
        
        if x > (superview?.bounds.size.width)! / 2  {
            point.x = (superview?.bounds.size.width)! - btnx - kEdgeMargin
        }
        
        if y <= btny {
            point.y = btny + kEdgeMargin
        }
        
        if y >= (superview?.bounds.size.height)! - btny - 45 {
            point.y = (superview?.bounds.size.height)! - btny - kEdgeMargin - 45
        }
        
        UIView.animate(withDuration: kAnimateTime) {
            btn.center = point
        }
        
        if abs(p_start!.x - p_end.x) < 5 && abs(p_start!.y - p_end.y) < 5 {
            if (clicked != nil) {
                clicked!()
            }
        }
    }
}
