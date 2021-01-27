//
//  StrechyHeaderView.swift
//  StretchyHeader
//
//  Created by WeiRuJian on 2021/1/27.
//

import UIKit



class StrechyHeaderView: UICollectionReusableView {

    var animatior: UIViewPropertyAnimator!
    
    let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "header"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupImageView()
        setupBlur()
        setupGradient()
    }
    
    fileprivate func setupImageView() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    fileprivate func setupGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.5,1]
        
        let gradientView = UIView()
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(gradientView)
        NSLayoutConstraint.activate([
            gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        gradientView.layer.addSublayer(gradient)
        gradient.frame = self.bounds
        gradient.frame.origin.y -= bounds.height
    }
    
    func setupBlur() {
        
        let blur = UIVisualEffectView()
        blur.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(blur)
        NSLayoutConstraint.activate([
            blur.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blur.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            blur.topAnchor.constraint(equalTo: self.topAnchor),
            blur.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        
        animatior = UIViewPropertyAnimator(duration: 2.0, curve: .linear, animations: {
            blur.effect = UIBlurEffect(style: .regular)
        })
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
