//
//  ViewController.swift
//  UIViewPropertyAnimatorDemo
//
//  Created by WeiRuJian on 2020/11/23.
//

import UIKit

class ViewController: UIViewController {

    let imageView = UIImageView(image: #imageLiteral(resourceName: "avatar"))
    
    let animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear)
    let visualEffectView = UIVisualEffectView(effect: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
       
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(visualEffectView)
        
        NSLayoutConstraint.activate([
            visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            visualEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(sliderChange(_ :)), for: .valueChanged)
        view.addSubview(slider)
        NSLayoutConstraint.activate([
            slider.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            slider.topAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
        
//        view.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(handleTap)))
        
        
        
        animator.addAnimations {
            self.imageView.transform = CGAffineTransform(scaleX: 4, y: 4)
            self.visualEffectView.effect = UIBlurEffect(style: .regular)
        }
        
        
    }
    
    @objc private func handleTap() {
//        UIView.animate(withDuration: 1.0) {
//            self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
//        }
    }
    
    @objc private func sliderChange(_ slider: UISlider) {
        print(slider.value)
        animator.fractionComplete = CGFloat(slider.value)
    }
}

