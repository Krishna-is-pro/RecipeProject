//
//  AddRecipeViewController.swift
//  Recipe
//
//  Created by friend on 20/07/24.
//

import UIKit
import Alamofire
class AddRecipeViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var ingredientsTextField: UITextField!
    @IBOutlet weak var instructionsTextField: UITextField!
    @IBOutlet weak var prepTimeTextField: UITextField!
    @IBOutlet weak var cookTimeTextField: UITextField!
    @IBOutlet weak var caloriesTextField: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func uploadButtonTapped(_ sender: Any) {
        // Validate and collect the data from the fields
        guard let title = titleTextField.text, !title.isEmpty,
              let ingredients = ingredientsTextField.text, !ingredients.isEmpty,
              let instructions = instructionsTextField.text, !instructions.isEmpty,
              let prepTimeText = prepTimeTextField.text, let prepTime = Int(prepTimeText),
              let cookTimeText = cookTimeTextField.text, let cookTime = Int(cookTimeText),
              let caloriesText = caloriesTextField.text, let calories = Int(caloriesText) else {
            // Handle validation error
            return
        }
        
        if let url = URL(string: "http://localhost:3000/api/recipe/newRecipe") {
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
            let ingredientsArray = ingredients.components(separatedBy: ",")
            let instructionsArray = instructions.components(separatedBy: ",")
            
            let newRecipe: [String: Any] = [
                "title": title,
                "ingredients": ingredientsArray,
                "instructions": instructionsArray,
                "cookTimeMinutes": cookTime,
                "prepTimeMinutes": prepTime,
                "caloriesPerServing": calories
            ]
            
            AF.request(url, method: .post, parameters: newRecipe, encoding: JSONEncoding.default).responseJSON { response in
                switch response.result {
                case .success(let data):
                    print("Success: \(data)")
                    // Handle the successful response, e.g., show a success message
                    
                case .failure(let error):
                    print("Error: \(error)")
                    // Handle the error, e.g., show an error message
                }
            }
        }
    }
}
            
            
