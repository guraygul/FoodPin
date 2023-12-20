//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Güray Gül on 19.12.2023.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    enum Section {
        case all
    }
    
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster",
                           "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery",
                           "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif",
                           "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore",
                           "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster",
                            "forkee", "posatelier", "bourkestreetbakery", "haigh", "palomino",
                            "upstate", "traif", "graham", "waffleandwolf", "fiveleaves",
                            "cafelore", "confessional", "barrafina", "donostia", "royaloak", "cask"]
    
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong",
                               "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney",
                               "New York", "New York", "New York", "New York", "New York",
                               "New York", "New York", "London", "London", "London", "London"]
    
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian/ Causual Drink",
                           "French", "Bakery", "Bakery", "Chocolate", "Cafe",
                           "American / Seafood", "American", "American", "Breakfast & Brunch",
                           "Coffee &Tea", "Coffee & Tea", "Latin American", "Spanish",
                           "Spanish", "Spanish", "British", "Thai"]
    
    var restaurantIsFavorites = Array(repeating: false, count: 21)
    
    lazy var dataSource = configureDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.dataSource = dataSource
        tableView.separatorStyle = .none
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.all])
        snapshot.appendItems(restaurantNames, toSection: .all)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Create an option menu as an action sheet
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        if let popoverController = optionMenu.popoverPresentationController {
            if let cell = tableView.cellForRow(at: indexPath) {
                popoverController.sourceView = cell
                popoverController.sourceRect = cell.bounds
            }
        }
        
        //Add actions to menu
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        
        //Add "Reserve a table" action
        let reserveActionHandler = { (action:UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title: "Not available yet",
                                                 message: "Sorry, this feature is not available yet. Please retry later.",
                                                 preferredStyle: .alert)
            
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
        }
        
        let reserveAction = UIAlertAction(title: "Reserve a table", style: .default, handler: reserveActionHandler)
        optionMenu.addAction(reserveAction)
        
        let favoriteActionTitle = self.restaurantIsFavorites[indexPath.row] ? "Remove from favorite" : "Mark as favorite"
        
        let favoriteAction = UIAlertAction(title: favoriteActionTitle,
                                           style: .default,
                                           handler: { (action: UIAlertAction!) -> Void in

            
            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
            
            cell.favoriteImageView.isHidden = self.restaurantIsFavorites[indexPath.row]
            
            self.restaurantIsFavorites[indexPath.row].toggle()
        })
        optionMenu.addAction(favoriteAction)
        
        
        //Displat the menu
        present(optionMenu, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
    //Mark as favorite action
    
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, String> {
        
        let cellIdentifier = "favoritecell"
        
        let dataSource = UITableViewDiffableDataSource<Section, String>(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, restaurantName in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
                
                cell.nameLabel.text = restaurantName
                cell.thumbnailImageView.image = UIImage(named: self.restaurantImages[indexPath.row])
                cell.locationLabel.text = self.restaurantLocations[indexPath.row]
                cell.typeLabel.text = self.restaurantTypes[indexPath.row]
                cell.favoriteImageView.isHidden = self.restaurantIsFavorites[indexPath.row] ? false : true
                
                return cell
            }
        )
        
        return dataSource
    }
}
