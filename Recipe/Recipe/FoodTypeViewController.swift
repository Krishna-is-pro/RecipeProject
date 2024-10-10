//
//  FoodTypeViewController.swift
//  Recipe
//
//  Created by friend on 25/06/24.
//

import UIKit

class FoodTypeViewController: UIViewController {

    @IBOutlet weak var foodListTableView: UITableView!
    @IBOutlet weak var foodTypeImage: UIImageView!
    var vegFoodList = ["Masala Bhendi","Dal Fry","Palak Paneer","Paneer Masala","Dal Mkhani","Panner LababDar"]
    var nonVegFoodList = ["Chicken Curry", "Fish Fry", "Mutton Biryani", "Prawn Masala", "Butter Chicken", "Tandoori Chicken", "Lamb Korma"]
    var jainFoodList = ["Plain Dal", "Gujarati Kadhi", "Vegetable Pulao", "Jain Paneer", "Jain Dal Tadka", "Jain Mixed Vegetable", "Jain Stuffed Capsicum"]
    var veganFoodList = ["Tofu Stir Fry", "Vegetable Salad", "Chickpea Curry", "Vegan Burrito", "Vegan Pasta", "Vegan Sushi", "Vegan Buddha Bowl"]

     let recipeTypeImages1 = ["vegfood","nonvegfood","veganfood","jainfood"]
    var selectedFoodType: String?
    var foodList: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeTableView()
        registerXIBWithTableView()
        updateUI()
    }
    func initializeTableView(){
        foodListTableView.dataSource = self
        foodListTableView.delegate = self
    }
   func  registerXIBWithTableView(){
       let uiNib = UINib(nibName: "FoodListTableViewCell", bundle: nil)
       self.foodListTableView.register(uiNib, forCellReuseIdentifier: "FoodListTableViewCell")
   }
    func updateUI() {
            switch selectedFoodType {
            case "Veg":
                foodTypeImage.image = UIImage(named: "vegfood")
                foodList = vegFoodList
            case "NonVeg":
                foodTypeImage.image = UIImage(named: "nonvegfood")
                foodList = nonVegFoodList
            case "Vegan":
                foodTypeImage.image = UIImage(named: "veganfood")
                foodList = veganFoodList
            case "Jain":
                foodTypeImage.image = UIImage(named: "jainfood")
                foodList = jainFoodList
            default:
                break
            }
            foodListTableView.reloadData()
        }
}
extension FoodTypeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return vegFoodList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let foodListTableViewCell = self.foodListTableView.dequeueReusableCell(withIdentifier: "FoodListTableViewCell", for: indexPath) as! FoodListTableViewCell
        foodListTableViewCell.vegFoodName.text = foodList[indexPath.row]

            return foodListTableViewCell
    }
}
extension FoodTypeViewController : UITableViewDelegate {
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 60.0
     }
}


