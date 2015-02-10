//
//  DrawerPanelViewController.swift
//  DrawerDemo
//
//  Created by Zane Swafford on 2/9/15.
//  Copyright (c) 2015 Zane Swafford. All rights reserved.
//

import UIKit

protocol DrawerPanelViewControllerDelegate {
    // Functions that need to pass information 
    // from the DrawerPanelVC to the DrawerVC can be put here
}

class DrawerPanelViewController: UIViewController {
    
    var delegate: DrawerPanelViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
