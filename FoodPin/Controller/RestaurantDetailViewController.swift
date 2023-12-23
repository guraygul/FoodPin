//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Güray Gül on 23.12.2023.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    @IBOutlet var restaurantImageView: UIImageView!
    @IBOutlet var restaurantName: UILabel!
    @IBOutlet var restaurantType: UILabel!
    @IBOutlet var restaurantLocation: UILabel!
    
//    var restaurantImageName = ""
    var restaurant = Restaurant()
    override func viewDidLoad() {
        super.viewDidLoad()

//        restaurantImageView.image = UIImage(named: restaurantImageName)
        restaurantImageView.image = UIImage(named: restaurant.image)
        restaurantName.text = restaurant.name
        restaurantType.text = restaurant.type
        restaurantLocation.text = restaurant.location
        
        navigationItem.largeTitleDisplayMode = .never
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
