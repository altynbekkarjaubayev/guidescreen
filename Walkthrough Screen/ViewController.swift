//
//  ViewController.swift
//  Walkthrough Screen
//
//  Created by Altynbek Karjaubayev on 1/16/17.
//  Copyright © 2017 Lementum. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    //Creating CollectionView with Closure
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        //default space between cells
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.whiteColor()
        cv.dataSource = self
        cv.delegate = self
        //creates animation like each cell snap to screen
        cv.pagingEnabled = true
        return cv
    }()
    
    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = UIColor.lightGrayColor()
        pc.currentPageIndicatorTintColor = UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1)
        pc.numberOfPages = 3
        return pc
    }()
    
    let skipButton: UIButton = {
        let sButton = UIButton(type: UIButtonType.System)
        sButton.setTitle("Skip", forState: UIControlState.Normal)
        sButton.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), forState: .Normal)
        return sButton
    }()
    
    let nextButton: UIButton = {
        let nButton = UIButton(type: UIButtonType.System)
        nButton.setTitle("Next", forState: UIControlState.Normal)
        nButton.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), forState: .Normal)
        return nButton
    }()
    
    //creates an empty array and sets pages into the array
    let pages: [WalkthrouhPage] = {
        let firstPage = WalkthrouhPage(title: "Share a great listen", message: "It's free to send your books to your lovely friends and classmated", imageName: "page1")
        
        let secondPage = WalkthrouhPage(title: "Send from your library", message: "It's easy and quick to send libraries to your lovers \"Send this book\"", imageName: "page2")
        
        let thirdPage = WalkthrouhPage(title: "Send from player", message: "Tap the menu button from upper corner", imageName: "page3")
        
        return [firstPage, secondPage, thirdPage]
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        
        collectionView.anchorTop(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        pageControl.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        
        skipButton.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 24, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 44)
        
        nextButton.anchor(view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 24, leftConstant: 0, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 44)
        
        collectionView.registerClass(WalkThroughPageCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! WalkThroughPageCell
        // page degen let sozdovat etp ony pages degen dictionary ten kylyp koid. Sosn WalkthroughPage ga dostup alu uwin WalkThroughPageCell da "page" degen var sozdovat etp sony let pen sozdovat etken page.ben tenestirip koidy
        let page = pages[indexPath.item]
        cell.page = page
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func registerCells() {
        
    }
    
}

