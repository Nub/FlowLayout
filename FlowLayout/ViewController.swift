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
	
	var layoutView = View(frame: CGRect(x: 150, y: 150, width: 50, height: 50))
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(layoutView);
		
		style()
		build()
	}
	
	func style() {
		layoutView.backgroundColor = UIColor.blackColor()
//		layoutView.centerContents = true
	}
	
	func build() {
		
		let a = View(frame: CGRect(x: 0, y: 0, width: 170, height: 20))
		a.backgroundColor = UIColor.yellowColor()
		
		let a1 = View(frame: CGRect(x: 0, y: 0, width: 20, height: 50))
		a1.backgroundColor = UIColor.yellowColor()

		let b = View(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
		b.backgroundColor = UIColor.blueColor()
//		b.margin.right = 10
		
		let c = View(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
		c.backgroundColor = UIColor.greenColor()
//		c.margin.left = 20
		
		self.layoutView.addSubview(a)
		self.layoutView.addSubview(a1)

		self.layoutView.addSubview(b)
		self.layoutView.addSubview(c)
		
		for i in 0..<50 {
			let a = View(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
			a.backgroundColor = UIColor.blueColor()
			a.margin.bottom = 1
			self.layoutView.addSubview(a)
		}
		
		dispatch_async(dispatch_get_main_queue()){
			UIView.animateWithDuration(5.0, delay: 0, options: UIViewAnimationOptions.LayoutSubviews, animations: {
				self.layoutView.frame.inset(dx: -100, dy: -100)
				}, completion: nil)
		}
	}
}

