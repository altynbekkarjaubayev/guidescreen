//
//  WalkthroughPageCell.swift
//  Walkthrough Screen
//
//  Created by Altynbek Karjaubayev on 1/16/17.
//  Copyright © 2017 Lementum. All rights reserved.
//

import UIKit

class WalkThroughPageCell: UICollectionViewCell {
    
    var page: WalkthrouhPage? {
        didSet{
            
            guard let page = page else {
                return
            }
            
            imageView.image = UIImage(named: page.imageName)
            
            let color = UIColor(white: 0.2, alpha: 1)
            
            let attributedText = NSMutableAttributedString(string: page.title, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(18, weight: UIFontWeightMedium), NSForegroundColorAttributeName: color])
            
            attributedText.appendAttributedString(NSAttributedString(string: "\n\n\(page.message)", attributes: [NSFontAttributeName: UIFont.systemFontOfSize(14, weight: UIFontWeightMedium), NSForegroundColorAttributeName: color]))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .Center
            
            let stringLength = attributedText.string.characters.count
            
            attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: stringLength))
            
            textView.attributedText = attributedText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .ScaleAspectFill
        iv.image = UIImage(named: "page1")
        //helps to get rid of effect that stacks images onto another
        iv.clipsToBounds = true
        return iv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "Sample text"
        tv.editable = false
        tv.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        return tv
    }()
    
    let dividerLineView: UIView = {
        let dl = UIView()
        dl.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return dl
    }()
    
    func setupViews() {
        addSubview(imageView)
        addSubview(textView)
        addSubview(dividerLineView)
        
//        imageView.anchorTop(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        
        //changed bottom anchor from View bottom to textView.topAnchor
        imageView.anchorTop(topAnchor, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)

        
        
//        textView.anchorTop(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        
        textView.anchorWithConstantsToTop(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        
        
        textView.heightAnchor.constraintEqualToAnchor(heightAnchor, multiplier: 0.3).active = true
        
        dividerLineView.anchorTop(nil, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)
        dividerLineView.heightAnchor.constraintEqualToConstant(1).active = true
        
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}




