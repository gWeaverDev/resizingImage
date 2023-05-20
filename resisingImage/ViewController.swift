//
//  ViewController.swift
//  resisingImage
//
//  Created by George Weaver on 19.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    enum Constants {
        static var imageViewHeight: CGFloat = 270
    }
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "poster1")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.contentInset = UIEdgeInsets(
            top: Constants.imageViewHeight,
            left: 0,
            bottom: scrollView.safeAreaInsets.bottom,
            right: 0
        )
        scrollView.contentOffset = CGPoint(x: 0, y: -scrollView.contentInset.top)
        scrollView.contentSize = CGSize(width: view.frame.width, height: 1000)
        
        imageView.frame = CGRect(
            x: 0,
            y: -Constants.imageViewHeight,
            width: scrollView.bounds.width,
            height: Constants.imageViewHeight
        )
            
    }
    
    private func setupAppearance() {
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupViews() {
           
       scrollView.frame = view.bounds
       scrollView.delegate = self
       
       scrollView.addSubview(imageView)
       view.addSubview(scrollView)
   }

}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        if offsetY < -Constants.imageViewHeight {
            var frame = imageView.frame
            frame.origin.y = offsetY
            frame.size.height = -offsetY
            imageView.frame = frame
            scrollView.verticalScrollIndicatorInsets.top = -offsetY
        }
    }
}
