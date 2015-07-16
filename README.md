# SFScrollView
SFScrollView is made to keep all subviews visible and let them go out of scrollview bounds.



#Customization
You can adjust scrolling orienation and cell size:

    Horizontal & Fixed Cell size
    Vertical & Fixed Cell size
    Horizontal & Custom size for each cell
    Vertical & Custom size for each cell


#Supported OS
It's made in Swift 2
It's tested on iOS 9 beta 3

#Installation
Simply drag SFScrollView.swift file in your project and add following lines to your code:

        let miniCellCount = 30
        let miniArray = NSMutableArray()
        for var i = 1; i < miniCellCount; ++i{
            let dictionary = NSDictionary(dictionary: ["title": "\(i)"])//"title" item must be in dictionary or it will crash
            miniArray.addObject(dictionary)
            
        }
        let sfScrollView = SFScrollView(frame: CGRect(x: 150, y: 20, width: view.bounds.width - 150, height: 50))
        sfScrollView.fixedCellSize = CGSize(width: 150, height: 80)
        sfScrollView.offsetGap = 10
        sfScrollView.setUp(SFCellSizeStyle.fixed, orien: SFOrienation.horizontal, cellContentArray: miniArray.mutableCopy() as! NSArray)
        addSubview(sfScrollView1)

#What it does looks like:

![alt tag](https://github.com/nealCeffrey/SFScrollView/blob/master/SFScrollView.gif)
