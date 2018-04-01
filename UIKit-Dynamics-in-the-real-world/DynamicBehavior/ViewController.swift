//
//  ViewController.swift
//  DynamicBehavior
//
//  Created by Raul Riera on 2018-03-31.
//  Copyright © 2018 Raul Riera. All rights reserved.
//

import UIKit

    class ViewController: UIViewController {
        @IBOutlet private weak var cardView: UIView!
        private var animator: UIDynamicAnimator!
        private var snapping: UISnapBehavior!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            animator = UIDynamicAnimator(referenceView: view)
            snapping = UISnapBehavior(item: cardView, snapTo: view.center)
            animator.addBehavior(snapping)
            
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(pannedView))
            cardView.addGestureRecognizer(panGesture)
            cardView.isUserInteractionEnabled = true
        }
        
        @objc func pannedView(recognizer: UIPanGestureRecognizer) {
            switch recognizer.state {
            case .began:
                animator.removeBehavior(snapping)
            case .changed:
                let translation = recognizer.translation(in: view)
                cardView.center = CGPoint(x: cardView.center.x + translation.x,
                                          y: cardView.center.y + translation.y)
                recognizer.setTranslation(.zero, in: view)
            case .ended, .cancelled, .failed:
                animator.addBehavior(snapping)
            case .possible:
                break
            }
        }
    }

