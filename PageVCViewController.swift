//
//  PageVCViewController.swift
//  MyRadian Valuations
//
//  Created by Sagar Kalathil on 17/05/21.
//  Copyright © 2021 Disha Patel. All rights reserved.
//

import UIKit

class PageVCViewController: UIPageViewController {
    var tempViewControllers = [UIViewController]()
    var orderedViewControllers = [UIViewController]()
    var arrTemporary = [String]()
    var arrString = [String]()
    //var currentIndex = Int()
    var del: pageControlDelete?
    var currentIndex = 0 {
        didSet {
            del?.pageChanged(intValue: currentIndex)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        arrString = arrTemporary.reversed()
        for i in arrString {
            orderedViewControllers.append(newColoredViewController(color: i))
        }
        tempViewControllers = orderedViewControllers.reversed()
        dataSource = self
        delegate = self
        if let firstViewController = orderedViewControllers.last {
                setViewControllers([firstViewController],
                                   direction: .forward,
                    animated: true,
                    completion: nil)
            }
        currentIndex = 0
        
        
        
        
    }
    
    func slideToPage(index: Int) {
        if currentIndex < index {
              //Forward direction
          for i in currentIndex + 1 ... index {
              let currenObj = orderedViewControllers.index(of: tempViewControllers[i]) as! Int
              self.setViewControllers([orderedViewControllers[currenObj]], direction: .forward, animated: true) { (done) in
                  self.currentIndex = self.currentIndex + 1
              }
          }
        }
        else {
          for i in stride(from: currentIndex - 1, through: index, by: -1) {
              let currenObj = orderedViewControllers.index(of: tempViewControllers[i]) as! Int
              self.setViewControllers([orderedViewControllers[currenObj]], direction: .reverse, animated: true) { (done) in
                  self.currentIndex = self.currentIndex - 1
              }
          }
        }
    }
    
    
    private func newColoredViewController(color: String) -> UIViewController {
        var vcFinal = UIViewController()
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if color == "SubjectHistoryVC" {
            let vc = sb.instantiateViewController(withIdentifier: "\(color)") as! SubjectHistoryVC
            vcFinal = vc
        }
        else if color == "CurrentListingVC" {
            let vc  = sb.instantiateViewController(withIdentifier: "\(color)") as! CurrentListingVC
            vcFinal = vc
        }
        else if color == "LatestSoldInfoVC"{
            let vc  = sb.instantiateViewController(withIdentifier: "\(color)") as! LatestSoldInfoVC
            vcFinal = vc
        }
        
        else if color == "PropertyInfoVC"{
            let vc  = sb.instantiateViewController(withIdentifier: "\(color)") as! PropertyInfoVC
            vcFinal = vc
        }
        else if color == "CondoInformationVC" {
            let vc  = sb.instantiateViewController(withIdentifier: "\(color)") as! CondoInformationVC
            vcFinal = vc
        }
        return vcFinal
    }
}

extension PageVCViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        return orderedViewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        return orderedViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        let final = orderedViewControllers.firstIndex(of: pageContentViewController)!
        let finalValue = abs(final - arrTemporary.count) - 1
        currentIndex = finalValue
    }
}
