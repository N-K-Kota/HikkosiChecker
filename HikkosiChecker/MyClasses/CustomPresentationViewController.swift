//
//  CustomPresentationViewController.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/11/13.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit

class CustomPresentationViewController: UIPresentationController {
    var overlay:UIView!
    override func presentationTransitionWillBegin(){
        let containerView = self.containerView!
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.tapaction(_:)))
        self.overlay = UIView(frame:containerView.bounds)
        self.overlay.backgroundColor = UIColor.black
        self.overlay.addGestureRecognizer(gesture)
        self.overlay.alpha = 0.0
        containerView.insertSubview(self.overlay, at: 0)
        presentedViewController.transitionCoordinator?.animateAlongsideTransition(in: self.overlay, animation:{(UIViewControllerTransitionCoordinatorContext) -> Void in
            self.overlay.alpha = 0.5}, completion: nil
        )
    }
    override func dismissalTransitionWillBegin(){
        self.presentedViewController.transitionCoordinator?.animateAlongsideTransition(in: self.overlay, animation: { [unowned self] context in
            self.overlay.alpha = 0.0
            }, completion: nil)
    }
    @objc func tapaction(_ sender:UITapGestureRecognizer){
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed{
            self.overlay.removeFromSuperview()
        }
    }
    override func  size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width, height: parentSize.height/2)
    }
    override var frameOfPresentedViewInContainerView: CGRect{
        let containerBounds = containerView!.bounds
        let x = containerBounds.size.width
        let y = containerBounds.size.height
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width:x , height: y/2))
        rect.inset(by:UIEdgeInsets(top: 0, left: 0, bottom: y, right: x))
        return rect
    }
    
    override func containerViewWillLayoutSubviews() {
        overlay.frame = containerView!.bounds
        self.presentedView?.frame = self.frameOfPresentedViewInContainerView
    }
}
