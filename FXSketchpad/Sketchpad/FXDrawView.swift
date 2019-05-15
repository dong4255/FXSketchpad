//
//  FXDrawView.swift
//  FXSketchpad
//
//  Created by Dong on 2019/5/14.
//  Copyright © 2019 dong. All rights reserved.
//  iOS 使用 CAShapeLayer + UIBezierPath 画板

import UIKit

public class FXDrawView: UIView, FXSketchpadProtocol {
    
    
    /// 路径
    private var path: UIBezierPath?
    /// 线条
    private var lineLayer: CAShapeLayer?
    
    private var lines = [CAShapeLayer]()
    private var undoLines = [CAShapeLayer]()
    
    /// 线宽
    public var lineWidth: CGFloat = 3 {
        didSet {
            if lineWidth <= 0 {
                lineWidth = 3
            }
        }
    }
    
    /// 线条颜色
    public var lineColor: UIColor = .black
    
    /// 线条拐点样式
    public var lineCapStyle: CGLineCap = .round
    
    /// 线条头尾样式
    public var lineJoinStyle: CGLineJoin = .round
    
    /// 橡皮擦
    public var isErase: Bool = false
    
    /// 背景图片
    public var backgroundImage: UIImage? {
        didSet {
            setBackgroundImage()
        }
    }
    
    /// 清屏
    public func clean() {
        for line in lines {
            line.removeFromSuperlayer()
        }
        lines.removeAll()
        undoLines.removeAll()
    }
    
    /// 回撤
    public func undo() {
        if !lines.isEmpty {
            let line = lines.removeLast()
            line.removeFromSuperlayer()
            undoLines.append(line)
        }
    }
    
    /// 还原
    public func redo() {
        if !undoLines.isEmpty {
            let undoLine = undoLines.removeLast()
            self.layer.addSublayer(undoLine)
            lines.append(undoLine)
        }
    }
    
    /// 导出为图片
    public func exportToImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let startPoint = touches.first?.location(in: self) else {
            return
        }
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        path.lineCapStyle = lineCapStyle
        path.lineJoinStyle = lineJoinStyle
        path.move(to: startPoint)
        self.path = path
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.backgroundColor = UIColor.clear.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = isErase ? backgroundColor?.cgColor : lineColor.cgColor
        shapeLayer.lineWidth = path.lineWidth
        
        self.layer.addSublayer(shapeLayer)
        self.lineLayer = shapeLayer
        
        lines.append(shapeLayer)
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let movedPoint = touches.first?.location(in: self) else {
            return
        }
        self.path?.addLine(to: movedPoint)
        self.lineLayer?.path = self.path?.cgPath
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setBackgroundImage()
    }
    
    // MARK: - private
    private func setBackgroundImage() {
        guard let image = backgroundImage else { return }
        UIGraphicsBeginImageContext(bounds.size)
        let context = UIGraphicsGetCurrentContext()
        context?.scaleBy(x: 1, y: -1)
        context?.translateBy(x: 0, y: -bounds.size.height)
        image.draw(in: bounds)
        if let stretchedImage = UIGraphicsGetImageFromCurrentImageContext() {
            self.backgroundColor = UIColor(patternImage: stretchedImage)
        }
        self.layer.contents = image.cgImage
        UIGraphicsEndImageContext()
    }

}
