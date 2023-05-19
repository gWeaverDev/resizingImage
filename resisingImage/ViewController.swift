//
//  ViewController.swift
//  resisingImage
//
//  Created by George Weaver on 19.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private var heightBannerConstraint: NSLayoutConstraint?
    
    private let bannerImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "blackLord"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .white
        scroll.showsVerticalScrollIndicator = true
        scroll.indicatorStyle = .black
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.contentSize = CGSize(width: scroll.contentSize.width, height: 1000)
        scroll.automaticallyAdjustsScrollIndicatorInsets = true
        return scroll
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupLayout()
        navigationController?.setNavigationBarHidden(true, animated: false)
        scrollView.delegate = self
    }
    
    private func setupAppearance() {
        view.backgroundColor = .white
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        view.addSubview(bannerImage)
        
        heightBannerConstraint = bannerImage.heightAnchor.constraint(equalToConstant: 400)
        
        NSLayoutConstraint.activate([
            
            bannerImage.topAnchor.constraint(equalTo: view.topAnchor),
            bannerImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            heightBannerConstraint!,
            
            scrollView.topAnchor.constraint(equalTo: bannerImage.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 400 + (scrollView.contentOffset.y - 400)
        heightBannerConstraint?.constant = 400 - y
        scrollView.verticalScrollIndicatorInsets.top = 400 - y
        scrollView.verticalScrollIndicatorInsets.bottom = y / 2
    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        if heightBannerConstraint!.constant < 65 {
//            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5) {
//                self.heightBannerConstraint?.constant = 300
//            }
//        }
//    }
}

