//
//  ViewController.swift
//  Recipe
//
//  Created by friend on 03/06/24.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    var url: URL?
    var urlRequest: URLRequest?
    var urlSession: URLSession?
    var recipes: [Recipy] = []
    var uiNib: UINib?
    var scrollTimer: Timer?

    @IBOutlet weak var recipeTableView: UITableView!
    @IBOutlet weak var recipeTypesCollectionView: UICollectionView!
    @IBOutlet weak var themeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var themeLabel: UILabel!

    var recipeDetailViewController = RecipeDetailsViewController()
    var foodTypeViewController = FoodTypeViewController()
    let recipeTypes = ["Veg", "NonVeg", "Vegan", "Jain"]
    let recipeTypeImages = ["vegfood", "nonvegfood", "veganfood", "jainfood"]
    
    // Infinite scrolling arrays
    var infiniteRecipeTypes: [String] = []
    var infiniteRecipeTypeImages: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJson()
        registerCellWithTableView()
        initializeTableView()
        
        if let savedTheme = UserDefaults.standard.string(forKey: "selectedTheme") {
            updateTheme(theme: savedTheme)
        }

        // Create infinite scrolling arrays
        let repeatCount = 20
        infiniteRecipeTypes = Array(repeating: recipeTypes, count: repeatCount).flatMap { $0 }
        infiniteRecipeTypeImages = Array(repeating: recipeTypeImages, count: repeatCount).flatMap { $0 }

        startAutoScrolling()
    }
    
    func registerCellWithTableView() {
        let uinib = UINib(nibName: "RecipeTableViewCell", bundle: nil)
        self.recipeTableView.register(uinib, forCellReuseIdentifier: "RecipeTableViewCell")
    }
    
    func initializeTableView() {
        recipeTableView.dataSource = self
        recipeTableView.delegate = self
        recipeTypesCollectionView.dataSource = self
        recipeTypesCollectionView.delegate = self
    }
    
    func parseJson() {
        url = URL(string: "https://dummyjson.com/recipes")
        urlRequest = URLRequest(url: url!)
        urlRequest?.httpMethod = "GET"
        urlSession = URLSession(configuration: .default)
        
        let dataTask = urlSession?.dataTask(with: urlRequest!) { data, response, error in
            let responseObject = try! JSONDecoder().decode(APIResponse.self, from: data!)
            self.recipes = responseObject.recipes
            
            DispatchQueue.main.async {
                self.recipeTableView.reloadData()
            }
        }
        
        dataTask?.resume()
    }
    
    // Auto-scrolling implementation
    func startAutoScrolling() {
        scrollTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(scrollCollectionView), userInfo: nil, repeats: true)
    }

    @objc func scrollCollectionView() {
        let contentOffset = recipeTypesCollectionView.contentOffset
        let nextOffset = CGPoint(x: contentOffset.x + 1, y: contentOffset.y)
        
        recipeTypesCollectionView.setContentOffset(nextOffset, animated: false)
        
        // Reset to the middle to simulate infinite scroll
        if nextOffset.x >= recipeTypesCollectionView.contentSize.width / 2 {
            recipeTypesCollectionView.setContentOffset(CGPoint(x: 0, y: contentOffset.y), animated: false)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        recipeTypesCollectionView.setContentOffset(CGPoint(x: recipeTypesCollectionView.contentSize.width / 4, y: 0), animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        scrollTimer?.invalidate()
        scrollTimer = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startAutoScrolling()
    }

    @IBAction func themeChanged(_ sender: UISegmentedControl) {
        let selectedTheme = sender.selectedSegmentIndex == 0 ? "Light" : "Dark"
        UserDefaults.standard.set(selectedTheme, forKey: "selectedTheme")
        updateTheme(theme: selectedTheme)
    }
    
    func updateTheme(theme: String) {
        if theme == "Light" {
            view.backgroundColor = .white
            themeLabel.textColor = .black
        } else {
            view.backgroundColor = .black
            themeLabel.textColor = .white
        }
        themeLabel.text = "\(theme) Mode"
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipeTableViewCell = self.recipeTableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as! RecipeTableViewCell
        recipeTableViewCell.recipeNameLabel.text = recipes[indexPath.row].name
        recipeTableViewCell.recipeImage.kf.setImage(with: URL(string: recipes[indexPath.row].image))
        return recipeTableViewCell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recipeDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "RecipeDetailsViewController") as! RecipeDetailsViewController
        
        recipeDetailViewController.namecontainer = recipes[indexPath.row].name
        recipeDetailViewController.ingredientContainer = recipes[indexPath.row].ingredients.joined(separator: "\n")
        recipeDetailViewController.instructionContainer = recipes[indexPath.row].instructions.joined(separator: "\n")
        recipeDetailViewController.prepTimeContanier = recipes[indexPath.row].prepTimeMinutes
        recipeDetailViewController.cookTimeContainer = recipes[indexPath.row].cookTimeMinutes
        recipeDetailViewController.caloriesContainer = recipes[indexPath.row].caloriesPerServing
        
        self.navigationController?.pushViewController(recipeDetailViewController, animated: true)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return infiniteRecipeTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let recipeCollectionViewCell = self.recipeTypesCollectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCollectionViewCell", for: indexPath) as! RecipeCollectionViewCell
        
        recipeCollectionViewCell.recipeType.text = infiniteRecipeTypes[indexPath.row]
        recipeCollectionViewCell.recipeTypeImage.image = UIImage(named: infiniteRecipeTypeImages[indexPath.row])
        return recipeCollectionViewCell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        foodTypeViewController = self.storyboard?.instantiateViewController(withIdentifier: "FoodTypeViewController") as! FoodTypeViewController
        foodTypeViewController.selectedFoodType = recipeTypes[indexPath.row % recipeTypes.count]

        self.navigationController?.pushViewController(foodTypeViewController, animated: true)
    }
}
