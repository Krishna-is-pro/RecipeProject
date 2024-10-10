//
//  RecipeDetailsViewController.swift
//  Recipe
//
//  Created by friend on 03/06/24.
//

import UIKit
import PDFKit

class RecipeDetailsViewController: UIViewController {
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    
    @IBOutlet weak var recipeIngredientsLabel: UILabel!
    
    @IBOutlet weak var recipeInstructionsLabel: UILabel!
    
    @IBOutlet weak var prepTimeLabel: UILabel!
    
    @IBOutlet weak var cookTimeLabel: UILabel!
    
    @IBOutlet weak var caloriresLabel: UILabel!
    
    @IBOutlet weak var recipeRatingsButton: UIButton!
    
    var idContainer : Int?
    var servingsCpntainer : Int?
    var tagsContainer : [String]?
    var imageContainer : String?
    var mealtypeContainer : [String]?
    var namecontainer : String?
    var ingredientContainer : String?
    var instructionContainer : String?
    var prepTimeContanier : Int?
    var cookTimeContainer : Int?
    var servingContainer : Int?
    var cuisinCointaner : String?
    var caloriesContainer : Int?
    var ratingsContainer : Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
       // saveToFavorites(recipe: Recipy)
       // getFavorites()
    }
    
    func bindData(){
        recipeNameLabel.text = namecontainer
        
        recipeIngredientsLabel.text = ingredientContainer
        recipeInstructionsLabel.text = instructionContainer
        prepTimeLabel.text = "\(prepTimeContanier ?? 0) mins"
        cookTimeLabel.text = "\(cookTimeContainer ?? 0) mins"
        caloriresLabel.text = "\(caloriesContainer ?? 0) calories"
        //   recipeRatingsButton.text = ratingsContainer.CodingKey.init(stringValue: //<#T##String#>)
    }
    
    @IBAction func addToFevoriteBtn(_ sender: Any) {
        let newRecipe = Recipy(
                id: idContainer ?? 0,
                name: namecontainer ?? "",
                ingredients: ingredientContainer?.components(separatedBy: "\n") ?? [""],
                instructions: instructionContainer?.components(separatedBy: "\n") ?? [""],
                prepTimeMinutes: prepTimeContanier ?? 0,
                cookTimeMinutes: cookTimeContainer ?? 0,
                caloriesPerServing: caloriesContainer ?? 0,
                servings: servingContainer ?? 0,
                tags: tagsContainer ?? [""],
                image: imageContainer ?? "",
                rating: ratingsContainer ?? 0.0,
                mealType: mealtypeContainer ?? [""]
            )

            saveToFavorites(recipe: newRecipe)
    }
    
    
    @IBAction func downLoadPDF_btn(_ sender: Any) {
        guard let recipe = createRecipeObject() else { return }
                let pdfData = createPDF(recipe: recipe)
                
                let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("\(recipe.name).pdf")
                
                do {
                    try pdfData.write(to: tempURL)
                    
                    let activityViewController = UIActivityViewController(activityItems: [tempURL], applicationActivities: nil)
                    present(activityViewController, animated: true, completion: nil)
                } catch {
                    print("Could not save PDF file: \(error)")
                }
        
    }
    func createRecipeObject() -> Recipy? {
            guard let id = idContainer,
                  let name = namecontainer,
                  let ingredients = ingredientContainer?.components(separatedBy: "\n"),
                  let instructions = instructionContainer?.components(separatedBy: "\n"),
                  let prepTime = prepTimeContanier,
                  let cookTime = cookTimeContainer,
                  let calories = caloriesContainer,
                  let servings = servingContainer,
                  let tags = tagsContainer,
                  let image = imageContainer,
                  let rating = ratingsContainer,
                  let mealType = mealtypeContainer else {
                return nil
            }
            
            let recipe = Recipy(
                id: id,
                name: name,
                ingredients: ingredients,
                instructions: instructions,
                prepTimeMinutes: prepTime,
                cookTimeMinutes: cookTime,
                caloriesPerServing: calories,
                servings: servings,
                tags: tags,
                image: image,
                rating: rating,
                mealType: mealType
            )
            
            return recipe
        }
    func createPDF(recipe: Recipy) -> Data {
            let pdfMetaData = [
                kCGPDFContextCreator: "Recipe App",
                kCGPDFContextAuthor: "Your Name"
            ]
            let format = UIGraphicsPDFRendererFormat()
            format.documentInfo = pdfMetaData as [String: Any]

            let pageWidth = 8.5 * 72.0
            let pageHeight = 11 * 72.0
            let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)

            let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
            let data = renderer.pdfData { (context) in
                context.beginPage()
                
                let titleAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
                let titleString = NSAttributedString(string: recipe.name, attributes: titleAttributes)
                titleString.draw(at: CGPoint(x: 20, y: 20))

                let bodyAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
                var bodyString = "Ingredients:\n" + recipe.ingredients.joined(separator: "\n") + "\n\n"
                bodyString += "Instructions:\n" + recipe.instructions.joined(separator: "\n") + "\n\n"
                bodyString += "Prep Time: \(recipe.prepTimeMinutes) mins\n"
                bodyString += "Cook Time: \(recipe.cookTimeMinutes) mins\n"
                bodyString += "Calories: \(recipe.caloriesPerServing) calories\n"
                let bodyText = NSAttributedString(string: bodyString, attributes: bodyAttributes)
                bodyText.draw(at: CGPoint(x: 20, y: 60))
            }

            return data
        }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFavorites" {
            if let destinationVC = segue.destination as? SecondViewController {
             }
            }
        }
        
    }
    func saveToFavorites(recipe: Recipy) {
        var favoriteRecipes = getFavorites()
        favoriteRecipes.append(recipe)

        if let encoded = try? JSONEncoder().encode(favoriteRecipes) {
            UserDefaults.standard.set(encoded, forKey: "favoriteRecipes")
        }
    }

    func getFavorites() -> [Recipy] {
        if let data = UserDefaults.standard.data(forKey: "favoriteRecipes"),
           let favorites = try? JSONDecoder().decode([Recipy].self, from: data) {
            return favorites
        }
        return []
    }

