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
		layoutView.padding.left = 5
//		layoutView.centerContents = true
	}
	
	func build() {
		for i in 0..<200 {
			let a = View(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
			a.backgroundColor = UIColor.blueColor()
			a.margin.bottom = 1
			a.margin.right = 1
			self.layoutView.addSubview(a)
		}
		
		let delay = 4.5 * Double(NSEC_PER_SEC)
		let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
		dispatch_after(time, dispatch_get_main_queue()){
			UIView.animateWithDuration(1.0){
				self.layoutView.frame = CGRect(x: 0, y: 0, width: 200, height: self.view.bounds.size.height)
			}
		}
	}
}

