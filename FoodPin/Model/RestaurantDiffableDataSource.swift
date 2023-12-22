//
//  RestaurantDiffableDataSource.swift
//  FoodPin
//
//  Created by Güray Gül on 22.12.2023.
//

import UIKit

enum Section {
    case all
}

class RestaurantDiffableDataSource: UITableViewDiffableDataSource<Section, Restaurant> {

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexpath: IndexPath) {
        
        if editingStyle == .delete {
            if let restaurant = self.itemIdentifier(for: indexpath) {
                var snapshot = self.snapshot()
                snapshot.deleteItems([restaurant])
                self.apply(snapshot, animatingDifferences: true)
            }
        }
        
    }
    
}
