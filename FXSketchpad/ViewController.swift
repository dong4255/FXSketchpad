//
//  ViewController.swift
//  FXSketchpad
//
//  Created by Dong on 2019/5/14.
//  Copyright © 2019 dong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var canvasView: FXDrawView!
    
    @IBOutlet weak var brushItem: UIBarButtonItem!
    
    @IBOutlet weak var eraserItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        canvasView.backgroundImage = #imageLiteral(resourceName: "default_bg.png")
    }


    @IBAction func drawAction(_ sender: UIBarButtonItem) {
        canvasView.isErase = false
        brushItem.tintColor = .red
        eraserItem.tintColor = .blue
    }
    
    @IBAction func eraserAction(_ sender: UIBarButtonItem) {
        canvasView.isErase = true
        eraserItem.tintColor = .red
        brushItem.tintColor = .blue
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
    
    
}

