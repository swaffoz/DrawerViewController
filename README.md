Swift Drawer Demo
=================

## About
This is a demo of slide-out-side-drawer-doo-dads in Swift.
This code is based on the instruction given by James Frost at [raywenderlich.com](http://www.raywenderlich.com/78568/create-slide-out-navigation-panel-swift).
The demo has been stripped down to just provide a basic pull-out-drawer-sliding-ma-bob to the left of the main view controller.

**This code is meant as a demo and mostly for my personal use. Do whatever you want but it isn't made to be general purpose.**

## Usage
You can put whatever views you would like in the the DrawerViewController and DrawerPanelViewController. 
To add a DrawerViewController to an existing project:
 * Include the Following files:
   * `DrawerViewController.swift`
   * `DrawerContainerViewController.swift`
   * `DrawerPanelViewController.swift` 
 * Make sure that the Root View Controller is a DrawerContainerViewController
   * Check the `AppDelegate.swift` file on this project to see an example
 * Subclass or modify DrawerViewController and call the `delegate!.toggleDrawer()` method when you want to open/close the Drwer panel.
