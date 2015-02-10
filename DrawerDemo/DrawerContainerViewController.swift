//
//  DrawerContainerViewController.swift
//  DrawerDemo
//
//  Created by Zane Swafford on 2/9/15.
//  Copyright (c) 2015 Zane Swafford. All rights reserved.
//

import UIKit
import QuartzCore

let MAIN_STORYBOARD_IDENTIFIER = "Main"
let DRAWER_PANEL_VIEW_CONTROLLER_IDENTIFIER = "DrawerPanelViewController"
let DRAWER_VIEW_CONTROLLER_IDENTIFIER = "DrawerViewController"

enum DrawerState {
    case Open
    case Closed
}

class DrawerContainerViewController: UIViewController, DrawerViewControllerDelegate, UIGestureRecognizerDelegate {
    var drawerNavigationController: UINavigationController!
    var drawerViewController: DrawerViewController!
    var drawerPanelViewController: DrawerPanelViewController?
    let centerPanelExpandedOffset: CGFloat = 60
    
    var currentState: DrawerState = .Closed {
        didSet {
            let shouldShowShadow = currentState != .Closed
            showShadowForDrawerViewController(shouldShowShadow)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawerViewController = UIStoryboard.drawerViewController()
        drawerViewController.delegate = self
        
        drawerNavigationController = UINavigationController(rootViewController: drawerViewController)
        view.addSubview(drawerNavigationController.view)
        addChildViewController(drawerNavigationController)
        
        drawerNavigationController.didMoveToParentViewController(self)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
        drawerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    func toggleDrawer() {
        let notAlreadyOpened = (currentState != .Open)
        
        if notAlreadyOpened {
            addDrawerPanelViewController()
        }
        
        animateDrawerPanel(shouldOpen: notAlreadyOpened)
    }
    
    func addDrawerPanelViewController() {
        if (drawerPanelViewController == nil) {
            drawerPanelViewController = UIStoryboard.drawerPanelViewController()
            drawerPanelViewController!.delegate = drawerViewController
            
            view.insertSubview(drawerPanelViewController!.view, atIndex: 0)
            
            addChildViewController(drawerPanelViewController!)
            drawerPanelViewController!.didMoveToParentViewController(self)
        }
    }
    
    func animateDrawerPanel(#shouldOpen: Bool) {
        if (shouldOpen) {
            currentState = .Open
            
            animateDrawerViewControllerXPosition(targetPosition: CGRectGetWidth(drawerNavigationController.view.frame) - centerPanelExpandedOffset)
        } else {
            animateDrawerViewControllerXPosition(targetPosition: 0) { finished in
                self.currentState = .Closed
                
                self.drawerPanelViewController!.view.removeFromSuperview()
                self.drawerPanelViewController = nil;
            }
        }
    }
    
    func animateDrawerViewControllerXPosition(#targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.drawerNavigationController.view.frame.origin.x = targetPosition
            }, completion: completion)
    }
    
    func showShadowForDrawerViewController(shouldShowShadow: Bool) {
        if (shouldShowShadow) {
            drawerNavigationController.view.layer.shadowOpacity = 0.8
        } else {
            drawerNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
    
    // MARK: UIPanGestureRecognizer
    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        let gestureIsDraggingFromLeftToRight = (recognizer.velocityInView(view).x > 0)
        
        switch(recognizer.state) {
        case .Began:
            if (currentState == .Closed) {
                addDrawerPanelViewController()
                showShadowForDrawerViewController(true)
            }
        case .Changed:
            let translation = recognizer.view!.frame.origin.x + recognizer.translationInView(view).x
            if translation >= 0 {
                recognizer.view!.frame.origin.x = translation
                recognizer.setTranslation(CGPointZero, inView: view)
            }
        case .Ended:
            if (drawerPanelViewController != nil) {
                let hasMovedGreaterThanHalfway = recognizer.view!.center.x > view.bounds.size.width
                animateDrawerPanel(shouldOpen: hasMovedGreaterThanHalfway)
            }
        default:
            break
        }
    }
}

private extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: MAIN_STORYBOARD_IDENTIFIER, bundle: NSBundle.mainBundle()) }
    
    class func drawerPanelViewController() -> DrawerPanelViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier(DRAWER_PANEL_VIEW_CONTROLLER_IDENTIFIER) as? DrawerPanelViewController
    }
    
    class func drawerViewController() -> DrawerViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier(DRAWER_VIEW_CONTROLLER_IDENTIFIER) as? DrawerViewController
    }
}
