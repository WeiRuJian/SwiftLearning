//
//  CardViewController.swift
//  CardViewAnimationWithUIPropertyAnimator
//
//  Created by WeiRuJian on 2020/11/19.
//

import UIKit

class CardViewController: UIViewController {

    lazy var handleArea: UIView = {
        let v = UIView()
        v.backgroundColor = .systemBackground
        return v
    }()
    
    private lazy var contentView: UIView = {
        let v = UIView()
        v.backgroundColor = .orange
        return v
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        handleArea.frame = CGRect(x: 0, y: 0,
                                  width: view.bounds.size.width,
                                  height: 65)
        view.addSubview(handleArea)
        
        contentView.frame = CGRect(x: 0,
                                   y: handleArea.bounds.size.height,
                                   width: view.bounds.size.width,
                                   height: view.bounds.size.height - handleArea.bounds.size.height)
        view.addSubview(contentView)
        
    }
    
}
