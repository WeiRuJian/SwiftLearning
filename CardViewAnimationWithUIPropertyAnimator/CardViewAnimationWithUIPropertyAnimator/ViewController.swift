//
//  ViewController.swift
//  CardViewAnimationWithUIPropertyAnimator
//
//  Created by WeiRuJian on 2020/11/19.
//

import UIKit

class ViewController: UIViewController {
    
    enum CardState {
        case expanded
        case collapsed
    }
    
    
    lazy var cardViewController = CardViewController()
    var visualEffectView = UIVisualEffectView()
    
    let cardHeight: CGFloat = 500
    let cardHandleAreaHeight: CGFloat = 65
    
    var cardVisible = false
    var nextState: CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    var runningAnimations: [UIViewPropertyAnimator] = []
    var animationProgressWhenInterrupted: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        setupCard()
    }
    
    func setupCard() {
        
        visualEffectView.frame = self.view.frame
        view.addSubview(visualEffectView)
        
        addChild(cardViewController)
        view.addSubview(cardViewController.view)
        
        cardViewController.view.frame = CGRect(x: 0, y: view.bounds.height - cardHandleAreaHeight,
                                               width: view.bounds.width, height: cardHeight)
        cardViewController.view.clipsToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleCardTap(recognzier:)))
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognzier:)))
        
        cardViewController.handleArea.addGestureRecognizer(tap)
        cardViewController.handleArea.addGestureRecognizer(pan)
        
    }
    
    @objc
    func handleCardTap(recognzier: UITapGestureRecognizer) {
//        switch recognzier.state {
//        case .ended:
//            animateTransitionIfNeeded(state: nextState, duration: 0.9)
//        default:
//            break
//        }
    }
    
    @objc
    func handleCardPan(recognzier: UIPanGestureRecognizer) {
        switch recognzier.state {
        case .began:
            /// startTransition
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            /// updateTransition
            let translation = recognzier.translation(in: self.cardViewController.handleArea)
            var fractionComplete = translation.y / cardHeight
            fractionComplete = cardVisible ? fractionComplete:-fractionComplete
            updateInteractiveTransistion(fractionCompleted: fractionComplete)
        case .ended:
            /// continueTransition
            let translation = recognzier.translation(in: self.cardViewController.handleArea)
            var fractionComplete = translation.y / cardHeight
            print("\(fractionComplete)")
            if (fractionComplete > -0.4 && fractionComplete < 0) || fractionComplete > 0.4 {
                print("下")
                self.cardViewController.view.frame.origin.y = self.view.bounds.height - self.cardHeight
            } else {
                print("上")
                self.cardViewController.view.frame.origin.y = self.view.bounds.height - self.cardHandleAreaHeight
            }
            continuInteractiveTransition()
        default:
            break
        }
    }
    
    func animateTransitionIfNeeded(state: CardState, duration: TimeInterval) {
        
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.cardViewController.view.frame.origin.y = self.view.bounds.height - self.cardHeight
                case .collapsed:
                    self.cardViewController.view.frame.origin.y = self.view.bounds.height - self.cardHandleAreaHeight
                }
            }
            
            frameAnimator.addCompletion { (_) in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                switch state {
                case .expanded:
                    self.cardViewController.view.layer.cornerRadius = 12
                case .collapsed:
                    self.cardViewController.view.layer.cornerRadius = 0
                }
            }
            
            cornerRadiusAnimator.startAnimation()
            runningAnimations.append(cornerRadiusAnimator)
            
            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.visualEffectView.effect = UIBlurEffect(style: .regular)
                case .collapsed:
                    self.visualEffectView.effect = nil
                }
            }
            
            blurAnimator.startAnimation()
            runningAnimations.append(blurAnimator)
        }
    }
    
    func startInteractiveTransition(state: CardState, duration: TimeInterval) {
        
        if runningAnimations.isEmpty {
            /// runing animations
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
        
    }
    
    func updateInteractiveTransistion(fractionCompleted: CGFloat) {
       
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    func continuInteractiveTransition() {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
    
}

