//
//  ViewController.swift
//  SFScrollView
//
//  Created by Arturs Derkintis on 7/14/15.
//  Copyright © 2015 Neal Ceffrey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let miniCellCount = 30
        let miniArray = NSMutableArray()
        for var i = 1; i < miniCellCount; ++i{
            let dictionary = NSDictionary(dictionary: ["title": "\(i)"])
            miniArray.addObject(dictionary)
            
        }
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            
            
            //Vertical & Fixed
            let sfScrollView1 = SFScrollView(frame: CGRect(x: 0, y: 20, width: 150, height: view.bounds.height - 20))
            ///All adjustments do before call setUp()
            sfScrollView1.fixedCellSize = CGSize(width: 150, height: 80)
            sfScrollView1.setUp(SFCellSizeStyle.fixed, orien: SFOrienation.vertical, cellContentArray: miniArray.mutableCopy() as! NSArray)
            sfScrollView1.autoresizingMask = UIViewAutoresizing.FlexibleHeight
            view.addSubview(sfScrollView1)
            
            
            //Vertical & Cell tells size
            let sfScrollView2 = SFScrollView(frame: CGRect(x: view.bounds.width - 100, y: 20, width: 100, height: view.bounds.height - 20))
            ///All adjustments do before call setUp()
            sfScrollView2.offsetGap = 2
            sfScrollView2.setUp(SFCellSizeStyle.custom, orien: SFOrienation.vertical, cellContentArray: miniArray.mutableCopy() as! NSArray)
            sfScrollView2.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleLeftMargin]
            
            
            view.addSubview(sfScrollView2)

        }else{
            //Horizontal & Fixed
            let sfScrollView1 = SFScrollView(frame: CGRect(x: 150, y: 20, width: view.bounds.width - 150, height: 50))
            ///All adjustments do before call setUp()
            sfScrollView1.offsetGap = 10
            sfScrollView1.autoresizingMask = UIViewAutoresizing.FlexibleWidth
            sfScrollView1.setUp(SFCellSizeStyle.fixed, orien: SFOrienation.horizontal, cellContentArray: miniArray.mutableCopy() as! NSArray)
            view.addSubview(sfScrollView1)
            
            //Vertical & Fixed
            let sfScrollView2 = SFScrollView(frame: CGRect(x: 0, y: 20, width: 150, height: view.bounds.height - 20))
            ///All adjustments do before call setUp()
            sfScrollView2.fixedCellSize = CGSize(width: 150, height: 80)
            sfScrollView2.setUp(SFCellSizeStyle.fixed, orien: SFOrienation.vertical, cellContentArray: miniArray.mutableCopy() as! NSArray)
            sfScrollView2.autoresizingMask = UIViewAutoresizing.FlexibleHeight
            view.addSubview(sfScrollView2)
            
            //Horizontal & Cell tells size
            let sfScrollView3 = SFScrollView(frame: CGRect(x: 150, y: view.bounds.height - 250, width: view.bounds.width - 250, height: 250))
            ///All adjustments do before call setUp()
            sfScrollView3.offsetGap = 3
            sfScrollView3.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleTopMargin]
            sfScrollView3.setUp(SFCellSizeStyle.custom, orien: SFOrienation.horizontal, cellContentArray: miniArray.mutableCopy() as! NSArray)
            view.addSubview(sfScrollView3)
            
            //Vertical & Cell tells size
            let sfScrollView4 = SFScrollView(frame: CGRect(x: view.bounds.width - 100, y: 70, width: 100, height: view.bounds.height - 70))
            ///All adjustments do before call setUp()
            sfScrollView4.offsetGap = 2
            sfScrollView4.setUp(SFCellSizeStyle.custom, orien: SFOrienation.vertical, cellContentArray: miniArray.mutableCopy() as! NSArray)
            sfScrollView4.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleLeftMargin]
            
            
            view.addSubview(sfScrollView4)

        }
        

    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

