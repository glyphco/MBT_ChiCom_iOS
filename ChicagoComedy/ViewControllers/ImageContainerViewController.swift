//
//  ImageContainerViewController.swift
//  ChicagoComedy
//
//  Created by ARO on 10/19/17.
//  Copyright © 2017 MBT. All rights reserved.
//

import Foundation
import UIKit

class ImageContainerViewController: UIViewController {
    var event: NSDictionary?
    @IBOutlet var containerView: UIView!
    var panGestureRecognizer: UIPanGestureRecognizer?
    var originalPosition: CGPoint?
    var currentPositionTouched: CGPoint?
    var dismissRadius:CGFloat?
    
    override func viewDidLoad() {
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:)))
        view.addGestureRecognizer(panGestureRecognizer!)
        //1. total width of device from center
        let deviceWidth = view.frame.size.width / 2
        //let deviceHeight = view.frame.size.height / 2
        //2. calculate dismiss area
        dismissRadius = pow(deviceWidth * 0.7, 2)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ImageViewerViewController {
            controller.event = event
        }
    }
    
    @objc func panGestureAction(_ panGesture: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: view)
        
        if panGesture.state == .began {
            originalPosition = view.center
            currentPositionTouched = panGesture.location(in: view)
        } else if panGesture.state == .changed {
            view.frame.origin = CGPoint(
                x: translation.x,
                y: translation.y
            )
            //change opacity on move
            //3. get current radius
            let radiusSq = pow(abs(translation.x), 2) + pow(abs(translation.y), 2)
            
            //4 calculate opacity
            let radiusPercent = radiusSq / dismissRadius!
            view.alpha = radiusPercent > 1 ? 0 : 1 - radiusPercent
        } else if panGesture.state == .ended {
            if translation.x > 90 || translation.x < -90 || translation.y > 90 || translation.y < -90 {
                UIView.animate(withDuration: 0.2
                    , animations: {
                        self.view.alpha = 0
                }, completion: { (isCompleted) in
                    if isCompleted {
                        self.dismiss(animated: false, completion: nil)
                    }
                })
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.center = self.originalPosition!
                    self.view.alpha = 1
                })
            }
            //            let velocity = panGesture.velocity(in: view)
            //
            //            if velocity.y >= 1500 {
            //                UIView.animate(withDuration: 0.2
            //                    , animations: {
            //                        self.view.frame.origin = CGPoint(
            //                            x: self.view.frame.origin.x,
            //                            y: self.view.frame.size.height
            //                        )
            //                }, completion: { (isCompleted) in
            //                    if isCompleted {
            //                        self.dismiss(animated: false, completion: nil)
            //                    }
            //                })
            //            } else {
            //                UIView.animate(withDuration: 0.2, animations: {
            //                    self.view.center = self.originalPosition!
            //                })
            //            }
        }
    }
}
