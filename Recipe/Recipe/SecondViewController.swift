//
//  SecondViewController.swift
//  Recipe
//
//  Created by friend on 03/06/24.
//

import UIKit
import Kingfisher

class SecondViewController: UIViewController {
    
    @IBOutlet weak var fevoritesRecipeTableView: UITableView!
    var fevRecipes : [Recipy] = []
   // var recipes : [Recipy] = []

    var recipeDetailViewController = RecipeDetailsViewController()
    var shouldRefresh = false
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        registerTableViewCell()
        loadFavorites()
        
        
    }
    func initTableView(){
        fevoritesRecipeTableView.dataSource = self
        fevoritesRecipeTableView.delegate = self
    }
    func registerTableViewCell(){
        let uiNib = UINib(nibName: "FevoriteRecipeTableViewCell", bundle: nil)
        self.fevoritesRecipeTableView.register(uiNib, forCellReuseIdentifier: "FevoriteRecipeTableViewCell")
    
    }
    func loadFavorites() {
           if let data = UserDefaults.standard.data(forKey: "favoriteRecipes"),
              let favorites = try? JSONDecoder().decode([Recipy].self, from: data) {
               fevRecipes = favorites
           }
       }
}
    extension SecondViewController : UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return fevRecipes.count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let fevoritesRecipesTableViewCell = self.fevoritesRecipeTableView.dequeueReusableCell(withIdentifier: "FevoriteRecipeTableViewCell", for: indexPath) as! FevoriteRecipeTableViewCell
            
            fevoritesRecipesTableViewCell.fevroitnameLabel.text = fevRecipes[indexPath.row].name
            
            fevoritesRecipesTableViewCell.fevRecipeImageView.kf.setImage(with: URL(string: fevRecipes[indexPath.row].image))
            
            return fevoritesRecipesTableViewCell
        }
}

extension SecondViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        recipeDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "RecipeDetailsViewController") as! RecipeDetailsViewController
        
     
        recipeDetailViewController.namecontainer = fevRecipes[indexPath.row].name
        recipeDetailViewController.ingredientContainer = fevRecipes[indexPath.row].ingredients.joined(separator: "\n")
        recipeDetailViewController.instructionContainer = fevRecipes[indexPath.row].instructions.joined(separator: "\n")
        recipeDetailViewController.prepTimeContanier = fevRecipes[indexPath.row].prepTimeMinutes
        recipeDetailViewController.cookTimeContainer = fevRecipes[indexPath.row].cookTimeMinutes
        recipeDetailViewController.caloriesContainer = fevRecipes[indexPath.row].caloriesPerServing
        
        self.navigationController?.pushViewController(recipeDetailViewController, animated: true)
    }
}
