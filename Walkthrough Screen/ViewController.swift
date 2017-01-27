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
    let loginCellId = "loginCellId"
    
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
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = UIColor.lightGrayColor()
        pc.currentPageIndicatorTintColor = UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1)
        pc.numberOfPages = self.pages.count + 1
        return pc
    }()
    
    lazy var skipButton: UIButton = {
        let sButton = UIButton(type: UIButtonType.System)
        sButton.setTitle("Skip", forState: UIControlState.Normal)
        sButton.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), forState: .Normal)
        sButton.addTarget(self, action: #selector(skipPage), forControlEvents: UIControlEvents.TouchUpInside)
        return sButton
    }()
    
    lazy var nextButton: UIButton = {
        let nButton = UIButton(type: UIButtonType.System)
        nButton.setTitle("Next", forState: UIControlState.Normal)
        nButton.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), forState: .Normal)
        nButton.addTarget(self, action: #selector(nextPage), forControlEvents: UIControlEvents.TouchUpInside)
        return nButton
    }()
    
    func nextPage() {
        if pageControl.currentPage == pages.count {
            return
        }
        
        if pageControl.currentPage == pages.count - 1 {
            moveContraintsOffScreen()
            
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.view.layoutIfNeeded()
                }, completion: nil)
        }
        
        let indexPath = NSIndexPath(forItem: pageControl.currentPage + 1, inSection: 0)
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
        pageControl.currentPage += 1
    }
    
    func skipPage() {
        pageControl.currentPage = pages.count - 1
        nextPage()
        
    }
    
    //creates an empty array and sets pages into the array
    let pages: [WalkthrouhPage] = {
        let firstPage = WalkthrouhPage(title: "Share a great listen", message: "It's free to send your books to your lovely friends and classmated", imageName: "page1")
        
        let secondPage = WalkthrouhPage(title: "Send from your library", message: "It's easy and quick to send libraries to your lovers \"Send this book\"", imageName: "page2")
        
        let thirdPage = WalkthrouhPage(title: "Send from player", message: "Tap the menu button from upper corner", imageName: "page3")
        
        return [firstPage, secondPage, thirdPage]
    }()
    
    var pageControlBottomAnchor: NSLayoutConstraint?
    var skipButtonTopAnchor: NSLayoutConstraint?
    var nextButtonTopAnchor: NSLayoutConstraint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeKeyboardNotifiations()
        
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        
        collectionView.anchorTop(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        pageControlBottomAnchor = pageControl.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)[1]
        
        skipButtonTopAnchor = skipButton.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 24, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 44).first
        
        nextButtonTopAnchor = nextButton.anchor(view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 24, leftConstant: 0, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 44).first
        
        registerCells()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if indexPath.item == pages.count {
            let loginCell = collectionView.dequeueReusableCellWithReuseIdentifier(loginCellId, forIndexPath: indexPath)
            return loginCell
        }
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! WalkThroughPageCell
        // page degen let sozdovat etp ony pages degen dictionary ten kylyp koid. Sosn WalkthroughPage ga dostup alu uwin WalkThroughPageCell da "page" degen var sozdovat etp sony let pen sozdovat etken page.ben tenestirip koidy
        let page = pages[indexPath.item]
        cell.page = page
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.memory.x / view.frame.width)
        pageControl.currentPage = pageNumber
        
        if pageNumber == pages.count {
            moveContraintsOffScreen()
            
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.view.layoutIfNeeded()
                }, completion: nil)
        } else {
            pageControlBottomAnchor?.constant = 0
            skipButtonTopAnchor?.constant = 16
            nextButtonTopAnchor?.constant = 16
            
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.view.layoutIfNeeded()
                }, completion: nil)
        }
    }
    
    private func moveContraintsOffScreen() {
        pageControlBottomAnchor?.constant = 40
        skipButtonTopAnchor?.constant = -40
        nextButtonTopAnchor?.constant = -40
    }
    
    private func registerCells() {
        collectionView.registerClass(WalkThroughPageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.registerClass(LoginCell.self, forCellWithReuseIdentifier: loginCellId)
        
    }
    
    private func observeKeyboardNotifiations() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardShow), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardHide), name: UIKeyboardWillHideNotification, object: nil)
        
    }
    func keyboardShow() {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            let y: CGFloat = UIDevice.currentDevice().orientation.isLandscape ? -100 : -60
            self.view.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height)
            }, completion: nil)
    }
    
    func keyboardHide() {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            }, completion: nil)
    }
    
    
    
    override func willTransitionToTraitCollection(newCollection: UITraitCollection, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
        
        let indexPath = NSIndexPath(forItem: pageControl.currentPage, inSection: 0)
        //scroll to indexPath after rotation is going
        dispatch_async(dispatch_get_main_queue()) { 
            self.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
            self.collectionView.reloadData()

        }
    
    }
    
    
}

