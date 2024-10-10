//
//  Recipe.swift
//  Recipe
//
//  Created by friend on 03/06/24.
//

import Foundation

struct APIResponse : Codable{
    var recipes :[Recipy]
    var total : Int
    var skip : Int
    var limit : Int
}
struct Recipy : Codable{
    var id : Int
    var name : String
    var ingredients : [String]
    var instructions : [String]
    var prepTimeMinutes : Int
    var cookTimeMinutes : Int
    var caloriesPerServing : Int
    var servings : Int
    var tags : [String]
    var image : String
    var rating : Double
    var mealType : [String]
}
