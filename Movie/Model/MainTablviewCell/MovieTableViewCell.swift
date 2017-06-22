//
//  MovieTableViewCell.swift
//  Movie
//
//  Created by VInoth on 3/1/17.
//  Copyright © 2017 Aryvart. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var Movie_release: UILabel!
    @IBOutlet weak var Movie_Title: UILabel!
    @IBOutlet weak var Movie_Overview: UITextView!
    
    @IBOutlet weak var Movies_Language: UILabel!
    
    @IBOutlet weak var Movie_Votes: UILabel!
    @IBOutlet weak var Movie_Relase: UILabel!
    
    @IBOutlet weak var Movie_Rates: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
