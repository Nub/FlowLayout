//
//  ViewController.swift
//  FlowLayout
//
//  Created by Zachry Thayer on 7/2/14.
//  Copyright (c) 2014 Zachry Thayer. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
	
	var layoutView = View(frame: CGRectZero)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(layoutView);
		
		style()
		build()
	}
	
	func style() {
		layoutView.backgroundColor = UIColor.blackColor()
		layoutView.frame = self.view.bounds
//		layoutView.centerContents = true
	}
	
	func build() {
		
		let a = View(frame: CGRect(x: 0, y: 0, width: 170, height: 20))
		a.backgroundColor = UIColor.yellowColor()
		
		self.layoutView.addSubview(a)
		
		for i in 0..<50 {
			let a = View(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
			a.backgroundColor = UIColor.blueColor()
			a.margin.bottom = 1
			a.margin.right = 1
			self.layoutView.addSubview(a)
		}
		
		dispatch_async(dispatch_get_main_queue()){
			UIView.animateWithDuration(5.0, delay: 1.0, options: UIViewAnimationOptions.LayoutSubviews, animations: {
				self.layoutView.frame = CGRect(x: 0, y: 0, width: 200, height: self.view.bounds.size.height)
				}, completion: nil)
		}
	}
}

