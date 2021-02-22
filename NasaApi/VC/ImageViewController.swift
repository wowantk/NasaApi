//
//  ImageViewController.swift
//  NasaApi
//
//  Created by macbook on 22.02.2021.
//

import UIKit

class ImageViewController: UIViewController , Init {
    private var  scrollView: ImageScrollView?
    public var selectedImageURL: String?
    private var photo = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView = ImageScrollView(frame: self.view.bounds)
        self.view.addSubview( scrollView!)
        
        if let photoURL = URL(string: selectedImageURL ?? "") {
            photo.kf.indicatorType = .activity
            photo.kf.setImage(with: photoURL)
        }
         scrollView?.setUp(image: photo.image ?? UIImage())
        self.addConstrains()
        
        self.scrollView?.zoom(
            to: CGRect(
                origin: CGPoint(
                    x: self.scrollView!.contentSize.width / 2 - self.view.frame.size.width / 2,
                    y: self.scrollView!.contentSize.height / 2 - self.view.frame.size.height / 2 ),
                size: CGSize(width: 200, height: 200)), animated: false)
        self.scrollView?.setZoomScale(1, animated: true)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
            tap.numberOfTapsRequired = 2
            view.addGestureRecognizer(tap)
    }
    
    @objc func doubleTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
     func addConstrains() {
         scrollView?.translatesAutoresizingMaskIntoConstraints = false
         scrollView?.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
         scrollView?.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
         scrollView?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
         scrollView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
         scrollView?.center = self.view.center
         scrollView?.contentMode = .redraw
    }
    
    
}
