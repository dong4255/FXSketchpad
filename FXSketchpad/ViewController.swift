//
//  ViewController.swift
//  FXSketchpad
//
//  Created by Dong on 2019/5/14.
//  Copyright © 2019 dong. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {

    @IBOutlet weak var canvasView: FXDrawView!
    
    @IBOutlet weak var brushItem: UIBarButtonItem!
    
    @IBOutlet weak var eraserItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        canvasView.backgroundImage = #imageLiteral(resourceName: "IMG_0682")
    }


    @IBAction func drawAction(_ sender: UIBarButtonItem) {
        canvasView.isErase = false
        brushItem.tintColor = .red
        eraserItem.tintColor = nil
    }
    
    @IBAction func eraserAction(_ sender: UIBarButtonItem) {
        canvasView.isErase = true
        eraserItem.tintColor = .red
        brushItem.tintColor = nil
    }
    
    @IBAction func undoAction(_ sender: UIBarButtonItem) {
        canvasView.undo()
    }
    
    @IBAction func redoAction(_ sender: UIBarButtonItem) {
        canvasView.redo()
    }
    
    @IBAction func cleanAction(_ sender: UIBarButtonItem) {
        canvasView.clean()
    }
    
    @IBAction func lineWidthValueChanged(_ sender: UISlider) {
        canvasView.lineWidth = CGFloat(sender.value)
    }
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        guard let image = canvasView.exportToImage() else { return }
        
        /*
         info.plist
         <key>NSPhotoLibraryUsageDescription</key>
         <string>App需要访问相册</string>
        */
        PHPhotoLibrary.requestAuthorization { (status) in
            if status == .authorized {
                
                PHPhotoLibrary.shared().performChanges({
                    PHAssetChangeRequest.creationRequestForAsset(from: image)
                }) { (isSuccess, aError) in
                    if aError == nil {
                        print("保存成功")
                    }else {
                        print("保存失败")
                    }
                }
                
            }else {
                print("未授权访问相册")
            }
        }
        
    }
    
    
}

