//
//  Extensions.swift
//  WKWebView
//
//  Created by MACUSER on 18/01/22.
//

import UIKit


extension UIView {
    
    func containerWebView(view: UIView, backButton: UIButton, nextButton: UIButton, closeButton: UIButton, label: UILabel) -> UIView {
        
        let imgRect: CGFloat = 20.0
        
        closeButton.setImage(UIImage(named: "close"), for: .normal)
        view.addSubview(closeButton)
        closeButton.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRigth: 0, width: 50, height: 50)
        closeButton.imageView?.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRigth: 0, width: imgRect, height: imgRect)
        closeButton.imageView?.contentMode = .scaleAspectFill
        closeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        backButton.setImage(UIImage(named: "back"), for: .normal)
        view.addSubview(backButton)
        backButton.anchor(top: nil, left: closeButton.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 50, paddingBottom: 0, paddingRigth: 0, width: 50, height: 50)
        backButton.imageView?.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRigth: 0, width: imgRect, height: imgRect)
        backButton.imageView?.contentMode = .scaleAspectFill
        backButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
      
        nextButton.setImage(UIImage(named: "forward"), for: .normal)
        view.addSubview(nextButton)
        nextButton.anchor(top: nil, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRigth: 16, width: 50, height: 50)
        nextButton.imageView?.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRigth: 0, width: imgRect, height: imgRect)
        nextButton.imageView?.contentMode = .scaleAspectFill
        nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(label)
        label.anchor(top: nil, left: backButton.rightAnchor, bottom: nil, right: nextButton.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRigth: 0, width: 0, height: 30)
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        
        return view
    }
    
    
    
    
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRigth: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRigth).isActive = true
        }
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
    }
    
    
}
