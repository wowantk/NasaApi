//
//  InfoPicker.swift
//  NasaApi
//
//  Created by macbook on 18.02.2021.
//

import Foundation

class InfoPicker {
    static func setValue(raw:String) -> [String]{
        switch raw {
        case "Curiosity":
            return Curiosity().camera
        case "Opportunity":
            return Opportunity().camera
        case "Spirit":
            return Spirit().camera
        default:
            return [String]()
        }
        
    }
}


class Curiosity:InfoPicker {
    var name  = "Curiosity"
    var camera = ["All",
                  "FHAZ",
                  "RHAZ",
                  "MAST",
                  "CHEMCAM",
                  "MAHLI",
                  "MARDI",
                  "NAVCAM"]
    
}

class Opportunity:InfoPicker {
    var name = "Opportunity"
    var camera = ["All",
                  "FHAZ",
                  "RHAZ",
                  "NAVCAM",
                  "PANCAM",
                  "MINITES"]
}

class Spirit:InfoPicker {
    var name = "Spirit"
    var camera = ["All",
                  "FHAZ",
                  "RHAZ",
                  "NAVCAM",
                  "PANCAM",
                  "MINITES"]
}
