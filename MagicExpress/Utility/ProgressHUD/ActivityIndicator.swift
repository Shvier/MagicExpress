//
//  ActivityIndicator.swift
//  MagicExpress
//
//  Created by Shvier on 12/06/2017.
//  Copyright © 2017 Shvier. All rights reserved.
//

import Cocoa

class ActivityIndicator: NSView {

    let numFins: NSInteger = 12
    let kAlphaWhenStopped: CGFloat = 0.15
    let kFadeMultiplier: CGFloat = 0.85
    
    var isAnimating: Bool = false
    var isFadingOut: Bool = false
    var animationTimer: Timer?
    
    var position: NSInteger = 0
    
    lazy var finColors: [NSColor] = {
        return Array<NSColor>()
    }()
    
    lazy var foreColor: NSColor = {
        return NSColor.black
    }()
    
    lazy var backColor: NSColor = {
        return NSColor.clear
    }()
    
    func startAnimation() {
        if isAnimating && !isFadingOut {
            return
        }
        actuallyStartAnimation()
    }
    
    func stopAnimation() {
        isFadingOut = true
    }
    
    func setColor(value: NSColor) {
        if foreColor != value {
            foreColor = value
            for index in 0..<finColors.count {
                let finColor = finColors[index]
                let alpha = finColor.alphaComponent
                finColors[index] = foreColor.withAlphaComponent(alpha)
            }
            needsDisplay = true
        }
    }
    
    func setBackgroundColor(value: NSColor) {
        if backColor != value {
            backColor = value
            needsDisplay = true
        }
    }
    
    func updateFrame(timer: Timer) {
        if position > 0 {
            position -= 1
        } else {
            position = finColors.count - 1
        }
        let minAlpha = kAlphaWhenStopped
        for index in 0..<finColors.count {
            let finColor = finColors[index]
            var newAlpha = finColor.alphaComponent * kFadeMultiplier
            if newAlpha < minAlpha {
                newAlpha = minAlpha
            }
            finColors[index] = foreColor.withAlphaComponent(newAlpha)
        }
        if isFadingOut {
            var done = true
            for index in 0..<finColors.count {
                if fabs(finColors[index].alphaComponent - minAlpha) > 0.01 {
                    done = false
                    break
                }
            }
            if done {
                actuallyStartAnimation()
            }
        } else {
            finColors[position] = foreColor
        }
        needsDisplay = true
    }
    
    func actuallyStartAnimation() {
        actuallyStopAnimation()
        isAnimating = true
        isFadingOut = false
        position = 1
        animationTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(self.updateFrame(timer:)), userInfo: nil, repeats: true)
        RunLoop.current.add(animationTimer!, forMode: RunLoopMode.commonModes)
        RunLoop.current.add(animationTimer!, forMode: RunLoopMode.defaultRunLoopMode)
        RunLoop.current.add(animationTimer!, forMode: RunLoopMode.eventTrackingRunLoopMode)
    }
    
    func actuallyStopAnimation() {
        isAnimating = false
        isFadingOut = false
        if animationTimer != nil {
            animationTimer?.invalidate()
        }
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        position = 0
        for _ in 0..<numFins {
            finColors.append(foreColor)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        let size = bounds.size
        let maxSize: CGFloat = size.width > size.height ? size.height : size.width
        backColor.set()
        NSBezierPath.fill(bounds)
        let currentContext: CGContext = NSGraphicsContext.current()?.graphicsPort as! CGContext
        NSGraphicsContext.saveGraphicsState()
        currentContext.translateBy(x: bounds.size.width/2, y: bounds.size.height/2)
        let path = NSBezierPath()
        path.lineWidth = 0.0859375*maxSize
        path.lineCapStyle = .roundLineCapStyle
        path.move(to: NSPoint(x: 0, y: 0.234375*maxSize))
        path.line(to: NSPoint(x: 0, y: 0.421875*maxSize))
        for finColor in finColors {
            if isAnimating {
                finColor.set()
            } else {
                foreColor.withAlphaComponent(kAlphaWhenStopped).set()
            }
            path.stroke()
            currentContext.rotate(by: 6.282185/CGFloat(finColors.count))
        }
        NSGraphicsContext.restoreGraphicsState()
    }
    
}
