//
//  FoodListTableViewCell.swift
//  Recipe
//
//  Created by friend on 25/06/24.
//

import UIKit

class FoodListTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var vegFoodName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
