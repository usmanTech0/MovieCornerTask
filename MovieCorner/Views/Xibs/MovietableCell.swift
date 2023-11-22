//
//  movietableCell.swift
//  MovieCorner
//
//  Created by M Usman on 21/11/2023.
//

import UIKit

class MovietableCell: UITableViewCell {
    
    @IBOutlet weak var imgView:UIImageView!
    @IBOutlet weak var titlelbl:UILabel!
    @IBOutlet weak var detaillbl:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
