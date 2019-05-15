//
//  FXSketchpadProtocol.swift
//  FXSketchpad
//
//  Created by Dong on 2019/5/14.
//  Copyright © 2019 dong. All rights reserved.
//

import UIKit

public protocol FXSketchpadProtocol {
    
    /// 线条宽度
    var lineWidth: CGFloat { get set }
    
    /// 线条颜色
    var lineColor: UIColor { get set }
    
    /// 线条拐点样式
    var lineCapStyle: CGLineCap { get set }
    
    /// 线条头尾样式
    var lineJoinStyle: CGLineJoin { get set }
    
    /// 橡皮擦
    var isErase: Bool { get set }
    
    /// 背景图片
    var backgroundImage: UIImage? { get set }
   
    /// 清屏
    func clean()
    
    /// 回撤
    func undo()
    
    /// 还原
    func redo()
    
    /// 导出为图片
    func exportToImage() -> UIImage?
}
