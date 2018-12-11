//
//  JumpPResentation.swift
//  HikkosiChecker
//
//  Created by Kota Nakamura on 2018/12/07.
//  Copyright © 2018年 Kota Nakamura. All rights reserved.
//

import UIKit

class JumpPresentation: UIPresentationController {  //画面中央に高さ半分のViewを表示する
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
        return CGSize(width: parentSize.width-20, height: parentSize.height-20)
    }
    override var frameOfPresentedViewInContainerView: CGRect{
        let containerBounds = containerView!.bounds
        let x = containerBounds.size.width
        let y = containerBounds.size.height
        let rect = CGRect(origin: CGPoint(x: 10, y: y/4), size: CGSize(width:x-20 , height: y/2))
        rect.inset(by:UIEdgeInsets(top: y/4, left: 10, bottom: y/4*3, right: x-10))
        return rect
    }
    
    override func containerViewWillLayoutSubviews() {
        overlay.frame = containerView!.bounds
        self.presentedView?.frame = self.frameOfPresentedViewInContainerView
    }
}
