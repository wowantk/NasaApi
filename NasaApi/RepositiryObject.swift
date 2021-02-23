//
//  RepositiryObject.swift
//  NasaApi
//
//  Created by macbook on 17.02.2021.
//

import Foundation
var repArr = [String]()

struct ReposisotiryObject: Codable {
    var photos: [Photo]
    
    
    static func performRequest(rover:String,camera:String,date:String,url:String?,page: Int = 1,completion: @escaping (_ isSuccess: Bool, _ response: [Photo]) -> ()) {
        var repStringURL = ""
        if camera != "All"{
            repStringURL = "https://api.nasa.gov/mars-photos/api/v1/rovers/\(rover)/photos?api_key=KHRJbKdXYnP7bqpiVGHl3u190QVlF07JuqPlJs56&camera=\(camera)&page=\(page)&earth_date=\(date)"
            
            if repArr.contains(repStringURL) == false {
                repArr.append(repStringURL)
            }
            
        }else{
            repStringURL = "https://api.nasa.gov/mars-photos/api/v1/rovers/\(rover)/photos?api_key=KHRJbKdXYnP7bqpiVGHl3u190QVlF07JuqPlJs56&page=\(page)&earth_date=\(date)"
            
            if repArr.contains(repStringURL) == false {
                repArr.append(repStringURL)
            }
            
        }
        if url != nil {
            repStringURL = url!
        }
        
        
        guard let repURL = URL(string: repStringURL) else {return}
        
        
        URLSession.shared.dataTask(with: repURL) { (data, response, error) in
            var result = [Photo]()
            guard data != nil else {
                print("NO DATA")
                completion(false, result)
                return
            }
            
            guard error == nil else {
                print(error!.localizedDescription)
                completion(false, result)
                return
            }
            
            do {
                
                result =  try JSONDecoder().decode(ReposisotiryObject.self, from: data!).photos
                
                completion(true, result)
            } catch {
                print(error.localizedDescription)
                completion(false, result)
            }
        }.resume()
    }
    
    
    
    
}

struct Photo: Codable {
    var imagePath: String
    var date: String
    var camera: Camera
    var rover: Rover
    
    func putObjectToUserDefaults() -> Bool{
        if let storedData =  UserDefaults.standard.object(forKey: "saved") as? Data {
            if var fav  = try? PropertyListDecoder().decode([Photo].self, from: storedData) {
                fav.append(self)
                self.putObjArrayToUserDefaults(fav)
                return true
            }
        }
        self.putObjArrayToUserDefaults([self])
        return true
    }
    
    private func putObjArrayToUserDefaults(_ array: [Photo]) {
        UserDefaults.standard.setValue(try? PropertyListEncoder().encode(array), forKey: "favorites")
    }
    
    enum CodingKeys: String, CodingKey {
        case camera,rover
        case imagePath = "img_src"
        case date = "earth_date"
    }
    
    
}

struct Camera: Codable {
    var name: String
    var fullName: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
    }
}

struct Rover: Codable {
    var name: String
}

enum choosenPicker {
    case rower
    case camera
    case date
}
