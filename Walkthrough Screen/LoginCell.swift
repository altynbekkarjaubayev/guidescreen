//
//  LoginCell.swift
//  Walkthrough Screen
//
//  Created by Altynbek Karjaubayev on 1/26/17.
//  Copyright © 2017 Lementum. All rights reserved.
//

import UIKit

class LoginCell: UICollectionViewCell {
    
    let logoImageView: UIImageView = {
        let lIV = UIImageView()
        lIV.image = UIImage(named: "logo")
        return lIV
    }()
    
    let emailTextField: LeftPaddedTextField = {
        let eTextField = LeftPaddedTextField()
        eTextField.placeholder = "Enter email"
        eTextField.layer.borderWidth = 1
        eTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        eTextField.keyboardType = .EmailAddress
        return eTextField
    }()
    
    let passwordTextField: LeftPaddedTextField = {
        let pTextField = LeftPaddedTextField()
        pTextField.layer.borderWidth = 1
        pTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        pTextField.placeholder = "Enter password"
        pTextField.secureTextEntry = true
        return pTextField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: UIButtonType.System)
        button.backgroundColor = UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1)
        button.setTitle("LOGIN", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(logoImageView)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        
        logoImageView.anchor(centerYAnchor, left: nil, bottom: nil, right: nil, topConstant: -230, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 160, heightConstant: 160)
        logoImageView.centerXAnchor.constraintEqualToAnchor(centerXAnchor).active = true
        
        emailTextField.anchor(logoImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 24, bottomConstant: 0, rightConstant: 24, widthConstant: 0, heightConstant: 50)
        passwordTextField.anchor(emailTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 24, bottomConstant: 0, rightConstant: 24, widthConstant: 0, heightConstant: 50)
        loginButton.anchor(passwordTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 24, leftConstant: 24, bottomConstant: 0, rightConstant: 24, widthConstant: 0, heightConstant: 50)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// Name Says for itself
class LeftPaddedTextField: UITextField {
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)

    }
}
