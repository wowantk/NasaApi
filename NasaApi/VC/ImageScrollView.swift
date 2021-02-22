//
//  ImageScrollView.swift
//  NasaApi
//
//  Created by macbook on 22.02.2021.
//

import UIKit

class ImageScrollView: UIScrollView,UIScrollViewDelegate {
    
    private var imageView: UIImageView!
    public var zoom: CGFloat?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
    
    func setUp(image: UIImage) {
        imageView?.removeFromSuperview()
        imageView = nil
        imageView = UIImageView(image: image)
        self.addSubview(imageView)
        self.contentSize = image.size
        self.minimumZoomScale = 0.1
        self.maximumZoomScale = 3
    }
    

    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let sub = scrollView.subviews.first
        let x = max(((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5), 0.0)
        let y = max(0.0, ((scrollView.bounds.height - scrollView.contentSize.height) * 0.5))
        sub?.center = CGPoint(x: scrollView.contentSize.width * 0.5 + x, y: scrollView.contentSize.height * 0.5 + y - 44)
    }
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        self.zoom = scale
    }
    
    
}
