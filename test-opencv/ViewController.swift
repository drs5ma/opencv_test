//
//  ViewController.swift
//  test-opencv
//
//  Created by Daniel Saha on 7/21/16.
//  Copyright © 2016 Daniel Saha. All rights reserved.
//


import UIKit
import MobileCoreServices


class ViewController: UIViewController {
    
    var drewSomething:Bool!;
    var lastPoint:CGPoint!
    var isSwiping:Bool!
    var red:CGFloat!
    var green:CGFloat!
    var blue:CGFloat!
    
    var temp:UIImage!
    var temp2:UIImage!
    
    @IBOutlet weak var Mask: UIImageView!
    
    @IBOutlet weak var Difference: UIImageView!
    
    @IBOutlet weak var Touch: UIImageView!
    
    @IBOutlet weak var Spiral: UIImageView!
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        red   = 1.0;
        green = 1.0;
        blue  = 1.0;
        drewSomething = false;
        
        Mask.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).CGColor
        Mask.layer.cornerRadius = 5.0
        Mask.layer.borderWidth = 2 // as you wish
        Mask.alpha = 1.0;
        Mask.backgroundColor = UIColor.clearColor();

        Spiral.image = UIImage(named: "spiral");
        Spiral.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).CGColor
        Spiral.layer.cornerRadius = 5.0
        Spiral.layer.borderWidth = 2 // as you wish
        Spiral.alpha = 1.0;
        //Spiral.backgroundColor = UIColor.whiteColor();
        Spiral.layer.zPosition = -24;

        Difference.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).CGColor
        Difference.layer.cornerRadius = 5.0
        Difference.layer.borderWidth = 2 // as you wish
        Difference.alpha = 1.0;
        Difference.backgroundColor = UIColor.clearColor();
        
        Touch.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).CGColor
        Touch.layer.cornerRadius = 5.0
        Touch.layer.borderWidth = 2 // as you wish
        Touch.alpha = 1.0;
        Touch.layer.zPosition = 24;
        Touch.backgroundColor = UIColor.clearColor();
        
        
    }
    
    @IBAction func Click(sender: AnyObject) {
        
        if(drewSomething == true ){
            temp = Touch.image;// UIImage(data: (UIImagePNGRepresentation(Touch.image!))!);
            
            Touch.image = nil;
            Touch.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).CGColor
            Touch.layer.cornerRadius = 5.0
            Touch.layer.borderWidth = 2 // as you wish
            Touch.alpha = 1.0;
            Touch.layer.zPosition = 24;
            Touch.backgroundColor = UIColor.clearColor();
            Touch.image = OpenCVWrapper.cleanse(Touch.image);
            
            Mask.image = nil;
            Mask.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).CGColor
            Mask.layer.cornerRadius = 5.0
            Mask.layer.borderWidth = 2 // as you wish
            Mask.alpha = 1.0;
            Mask.backgroundColor = UIColor.clearColor();
            Mask.image = OpenCVWrapper.processImageWithOpenCV(temp);
            
            
            Difference.image = nil;
            Difference.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).CGColor
            Difference.layer.cornerRadius = 5.0
            Difference.layer.borderWidth = 2 // as you wish
            Difference.alpha = 1.0;
            Difference.backgroundColor = UIColor.clearColor();
            
            Difference.image = OpenCVWrapper.subtractImages( Mask.image , Spiral.image );

            drewSomething = false;
        }
        

        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan( touches: Set<UITouch>,
                                withEvent event: UIEvent?){
        drewSomething = true;
        isSwiping    = false
        if let touch = touches.first{
            lastPoint = touch.locationInView(Touch)
        }
    }
    
    
    
    override func touchesMoved(touches: Set<UITouch>,
                               withEvent event: UIEvent?){
        
        isSwiping = true;
        if let touch = touches.first{
            let currentPoint = touch.locationInView(Touch)
            print(currentPoint);
            UIGraphicsBeginImageContext(self.Touch.frame.size)
            self.Touch.image?.drawInRect(CGRectMake(0, 0, self.Touch.frame.size.width, self.Touch.frame.size.height))
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y)
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y)
            CGContextSetLineCap(UIGraphicsGetCurrentContext(),CGLineCap.Round)
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 9.0)
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(),red, green, blue, 1.0)
            CGContextStrokePath(UIGraphicsGetCurrentContext())
            self.Touch.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            lastPoint = currentPoint
        }
    }
    

}

