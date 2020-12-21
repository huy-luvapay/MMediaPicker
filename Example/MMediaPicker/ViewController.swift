//
//  ViewController.swift
//  MMediaPicker
//
//  Created by huy-luvapay on 11/23/2020.
//  Copyright (c) 2020 huy-luvapay. All rights reserved.
//

import UIKit
import MMediaPicker

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showPressed() {
        //, selectedColor: UIColor.red
        MMediaPicker.shared.present(in: self, maxSelectCount: 100, isOnlySelectPhoto: true, languageEng: false, usedCameraButton: true) { (arrayAsset) in
            print("Completion")
        } cancel: {
            print("Cancel")
        } handleTakeImageFromCamera: { (image) in
            print("\(image)")
        }

    }

}

