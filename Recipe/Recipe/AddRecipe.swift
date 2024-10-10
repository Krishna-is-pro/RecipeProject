//
//  AddRecipe.swift
//  Recipe
//
//  Created by friend on 26/07/24.
//

import Foundation
struct AddRecipe: Codable {
    let name: String
    let ingredients: [String]
    let instructions: [String]
    let cookTimeMinutes: Int
    let prepTimeMinutes : Int
    let caloriesPerServing: Int
}
