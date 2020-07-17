//
//  ViewController.swift
//  panGestureDemo
//
//  Created by Victor Kachalov on 18/01/2018.
//  Copyright © 2018 Victor Kachalov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var fileImageView: UIImageView!
    @IBOutlet weak var trashImageView: UIImageView!
    var fileImageOrigin: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()
        addPanGesture(view: fileImageView)
        fileImageOrigin = fileImageView.frame.origin
        self.view.bringSubview(toFront: fileImageView)
    }

    func addPanGesture(view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(pan)
    }

    @objc func handlePan(sender: UIPanGestureRecognizer) {
        
        let fileView = sender.view!
        
        switch sender.state {
        case .began, .changed:
            moveViewWithPan(view: fileView, sender: sender)
        case .ended:
            if fileView.frame.intersects(trashImageView.frame) {
               deleteView(view: fileView)
            } else {
               returnViewToOrigin(view: fileView)
            }
        default: break
        }
    }

    func moveViewWithPan(view: UIView, sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: view)
    }

    func returnViewToOrigin(view: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            view.frame.origin = self.fileImageOrigin
        })
    }

    func deleteView(view: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            view.alpha = 0
        })
    }
}

