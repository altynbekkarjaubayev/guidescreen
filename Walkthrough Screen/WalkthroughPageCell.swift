//
//  WalkthroughPageCell.swift
//  Walkthrough Screen
//
//  Created by Altynbek Karjaubayev on 1/16/17.
//  Copyright © 2017 Lementum. All rights reserved.
//

import UIKit

class WalkThroughPageCell: UICollectionViewCell {
    
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
        return tv
    }()
    
    func setupViews() {
        addSubview(imageView)
        addSubview(textView)
        
//        imageView.anchorTop(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        //changed bottom anchor from View bottom to textView.topAnchor
        imageView.anchorTop(topAnchor, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)

        
        textView.anchorTop(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        textView.heightAnchor.constraintEqualToAnchor(heightAnchor, multiplier: 0.3).active = true
        
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}




