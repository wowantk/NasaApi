//
//  TableViewResponseCell.swift
//  NasaApi
//
//  Created by macbook on 21.02.2021.
//

import UIKit

class TableViewResponseCell: UITableViewCell {
    
    @IBOutlet weak var labelRespons: UILabel!
    
    
    func setModel(with rep:String){
        self.labelRespons.text = rep
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
