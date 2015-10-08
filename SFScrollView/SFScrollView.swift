//
//  SFScrollView.swift
//  SFScrollView
//
//  Created by Arturs Derkintis on 7/14/15.
//  Copyright © 2015 Neal Ceffrey. All rights reserved.
//
/*

*/
import UIKit

//Scrolling orientation
enum SFOrienation{
    case horizontal; //Default
    case vertical;
}

enum SFCellSizeStyle{
    case fixed;     //Fixed size to all cells
    case custom;      //Set costom size for each cell
   
}

let cellColor = UIColor.orangeColor()
let cellBorderColor = UIColor.whiteColor()



@IBDesignable
class SFScrollView : UIView, UIScrollViewDelegate {
    
    //Array of Cells
    var cells = NSMutableArray()
    
    @IBInspectable var offsetGap : CGFloat? = 5.0
    
    @IBInspectable var fixedCellSize : CGSize? = CGSize(width: 100, height: 50)
    
    
    var orienation = SFOrienation.horizontal
    var cellSizeStyle = SFCellSizeStyle.fixed

    
    var scrollView : UIScrollView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clearColor()
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        scrollView?.autoresizingMask = sfMaskBoth
        
        ///Delete this if you don't need it
        scrollView?.showsHorizontalScrollIndicator = false
        scrollView?.showsVerticalScrollIndicator = false
        ////
        
        addSubview(scrollView!)
        scrollView?.delegate = self
       
    }

    func setUp(cellSizeStyle : SFCellSizeStyle, orien : SFOrienation, cellContentArray : NSArray){
        self.cellSizeStyle = cellSizeStyle
        self.orienation = orien
        
        for dictionary in cellContentArray as! [NSDictionary]{
            let text = dictionary.valueForKey("title") as! String
            let newCell = SFCell(frame: CGRect(x: 0, y: 0, width: scrollView!.frame.width, height: scrollView!.frame.height))
            
            var origin : CGPoint?
            var size : CGSize?
            if cellSizeStyle == SFCellSizeStyle.fixed && orienation == SFOrienation.horizontal{
                ///Horizontal && Fixed Size
                if cells.count != 0{
                    origin = CGPoint(x: CGRectGetMaxX((cells.lastObject as! SFCell).frame), y: 0)
                }else{
                    origin = CGPoint(x: 0, y: 0)
                }

                size = fixedCellSize
                
                
                
            }else if cellSizeStyle == SFCellSizeStyle.fixed && orienation == SFOrienation.vertical{
                ///Vertical && Fixed Size
                if cells.count != 0{
                    origin = CGPoint(x: 0, y: CGRectGetMaxY((cells.lastObject as! SFCell).frame))
                }else{
                    origin = CGPoint(x: 0, y: 0)
                }
                size = fixedCellSize
                
            }else if cellSizeStyle == SFCellSizeStyle.custom && orienation == SFOrienation.horizontal{
                ///Horizontal && Change next lines to desired size
                newCell.setUpSize(true)
                if cells.count != 0{
                    origin = CGPoint(x: CGRectGetMaxX((cells.lastObject as! SFCell).frame), y: 0)
                }else{
                    origin = CGPoint(x: 0, y: 0)
                }
                
                size = newCell.bounds.size
                
            }else if cellSizeStyle == SFCellSizeStyle.custom && orienation == SFOrienation.vertical{
                ///Vertical && Change next lines to desired size
                newCell.setUpSize(false)
                if cells.count != 0{
                    origin = CGPoint(x: 0, y: CGRectGetMaxY((cells.lastObject as! SFCell).frame))
                }else{
                    origin = CGPoint(x: 0, y: 0)
                }
                
                size = newCell.bounds.size
                
            }
            newCell.frame = CGRect(origin: origin!, size: size!)
            newCell.label!.text = text
            cells.addObject(newCell)
            scrollView!.addSubview(newCell)
            
            
        }
        var y : CGFloat = 0.0
        var x : CGFloat = 0.0

        for viewA in scrollView!.subviews{
            if viewA.isKindOfClass(SFCell){
                if y < CGRectGetMaxY(viewA.frame){
                    y += viewA.frame.height
                }
                if x < CGRectGetMaxX(viewA.frame){
                    x += viewA.frame.width
                }
                
            }
        }
        scrollView!.contentSize = CGSize(width: x, height: y)
        repositionEachCell(scrollView!)
    }
    
    override func layoutSubviews() {
        //if bounds changes, reposiotion each cell
        repositionEachCell(scrollView!)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //reposiotion each cell while scrolling
        repositionEachCell(scrollView)
    }
    
    func repositionEachCell(scrollView : UIScrollView){
        for var cell : SFCell in cells.mutableCopy() as! [SFCell]{
            
            //next the magic happens, well, not really magic, but this is main thing!
            
            
            let point = scrollView.convertPoint(cell.center, toView: self)
            let offset = CGFloat(cells.indexOfObject(cell)) * offsetGap!
            let reversedOffset = CGFloat((cells.count - 1) - cells.indexOfObject(cell)) * offsetGap!
            let y = (orienation == SFOrienation.horizontal ? point.x : point.y)
            let half = cell.frame.width * 0.5
            if y < (orienation == SFOrienation.horizontal ? (cell.frame.width * 0.5) + offset : (cell.frame.height * 0.5) + offset){
                // if cell is touched to the left side or top (depends on orientaion)
                let translationX = ((cell.frame.width * 0.5) - point.x) + offset
                let translationY = ((cell.frame.height * 0.5) - point.y) + offset
               
                (orienation == SFOrienation.horizontal) ? (cell.transform = CGAffineTransformMakeTranslation(translationX, 0)) : (cell.transform = CGAffineTransformMakeTranslation(0, translationY))
                
                
                
                scrollView.bringSubviewToFront(cell)
        
                
                
            }else if y > (orienation == SFOrienation.horizontal ? scrollView.frame.width - (half + reversedOffset) : scrollView.frame.height - (half + reversedOffset)){
                // if cell is touched to the rigth side or buttom (depends on orientaion)
                
                let translationX = (point.x - (scrollView.frame.width - (cell.frame.width * 0.5)) + reversedOffset)
                let translationY = (point.y - (scrollView.frame.height - (cell.frame.height * 0.5)) + reversedOffset)
                
                (orienation == SFOrienation.horizontal) ? (cell.transform = CGAffineTransformMakeTranslation(-translationX, 0)) : (cell.transform = CGAffineTransformMakeTranslation(0, -translationY))
                
                scrollView.sendSubviewToBack(cell)
            }else{
                //if cell is in the middle
                cell.transform = CGAffineTransformIdentity
                scrollView.bringSubviewToFront(cell)
                }
            }
            
            
        }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// Some extensions

public func randomInRange (lower: Int , upper: Int) -> Int {
    return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
}
public func randomString(len : Int) -> NSString {
    let s : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let mut : NSMutableString = NSMutableString(capacity: len)
    for var inde = 0; inde < len; ++inde {
        mut.appendFormat("%C", s.characterAtIndex(Int(arc4random_uniform(UInt32(s.length)))))
    }
    return mut.mutableCopy() as! NSString
}

public let sfMaskBoth : UIViewAutoresizing = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]


class SFCell: UIView {
    
    var line = 0
    var row = 0
    ///Put your stuff in contentView
    var contentView : UIView?
    var label : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        contentView?.autoresizingMask = sfMaskBoth
        addSubview(contentView!)
        label = UILabel(frame: contentView!.bounds)
        label?.clipsToBounds = true
        label?.autoresizingMask = sfMaskBoth
        contentView!.addSubview(label!)
        label?.textAlignment = NSTextAlignment.Center
        label!.textColor = UIColor.whiteColor()
        contentView?.backgroundColor = cellColor
        contentView?.layer.borderColor = cellBorderColor.CGColor
        contentView?.layer.borderWidth = 1
        
    }
    func setUpSize(horizotal : Bool){
        //Autogenerates random size
        ///Change size to the one you need
        
        self.bounds = CGRect(x: 0, y: 0, width: horizotal ? CGFloat(randomInRange(50, upper: 200)) : frame.width, height: horizotal ? frame.height : CGFloat(randomInRange(50, upper: 200)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}