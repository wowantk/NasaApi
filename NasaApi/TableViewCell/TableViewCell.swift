//
//  TableViewCell.swift
//  NasaApi
//
//  Created by macbook on 20.02.2021.
//

import UIKit
import Kingfisher
class TableViewCell: UITableViewCell {
    @IBOutlet weak var roverLabel: UILabel!
    @IBOutlet weak var cameraLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageCamera: UIImageView!
    
    private var receivedPhotos = [Photo]()
        private var repositoryModel:ReposisotiryObject?
        
    
         func setRepositoryModel(with model:Photo){
            
           
            
            self.roverLabel.text? = model.rover.name
            self.cameraLabel.text? = model.camera.fullName
            self.dateLabel.text? = model.date
            

            
            if let avatarUrl = URL(string: model.imagePath) {
                imageCamera.kf.indicatorType = .activity
                imageCamera.kf.setImage(with: avatarUrl)
            }
            
        }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
