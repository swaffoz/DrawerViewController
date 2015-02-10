//
//  DrawerViewController.swift
//  DrawerDemo
//
//  Created by Zane Swafford on 2/9/15.
//  Copyright (c) 2015 Zane Swafford. All rights reserved.
//

import UIKit

protocol DrawerViewControllerDelegate {
    func toggleDrawer()
}

class DrawerViewController: UIViewController, DrawerPanelViewControllerDelegate {
    
    var delegate: DrawerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func menuButtonTapped(sender: AnyObject) {
        delegate?.toggleDrawer()
    }
}
