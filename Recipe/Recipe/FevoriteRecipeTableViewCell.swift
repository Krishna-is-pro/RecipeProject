//
//  FevoriteRecipeTableViewCell.swift
//  Recipe
//
//  Created by friend on 23/06/24.
//

import UIKit

class FevoriteRecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var fevroitnameLabel: UILabel!
    
    @IBOutlet weak var fevRecipeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
