//
//  NavigationController.swift
//  FoodPin
//
//  Created by Güray Gül on 25.12.2023.
//

import UIKit

class NavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
