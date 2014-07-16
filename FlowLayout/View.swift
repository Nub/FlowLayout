//
//  View.swift
//  FlowLayout
//
//  Created by Zachry Thayer on 7/2/14.
//  Copyright (c) 2014 Zachry Thayer. All rights reserved.
//

import Foundation
import UIKit

extension CGRect {
	var left: CGFloat {
	set {
		self.origin.x = newValue
	}
	get {
		return self.origin.x
	}
	}
	
	var right: CGFloat {
	set {
		self.size.width = newValue - self.origin.x
	}
	get {
		return self.origin.x	+ self.width
	}
	}
	
	var top: CGFloat {
	set {
		self.origin.y = newValue
	}
	get {
		return self.origin.y
	}
	}
	
	var bottom: CGFloat {
	set {
		self.size.height = newValue - self.origin.y
	}
	get {
		return self.origin.y + self.height
	}
	}
}

@infix func -=(inout lhs: CGRect, rhs: UIEdgeInsets) {
	lhs.left += rhs.left
	lhs.right -= rhs.right
	lhs.top += rhs.top
	lhs.bottom -= rhs.bottom
}

@infix func +=(inout lhs: CGRect, rhs: UIEdgeInsets) {
	lhs.left -= rhs.left
	lhs.right += rhs.right
	lhs.top -= rhs.top
	lhs.bottom += rhs.bottom
}

class View: UIView {
	
	enum Defaults {
		static let Padding = UIEdgeInsetsZero
		static let Margin = UIEdgeInsetsZero
		static let Size = CGSizeZero
		static let MaxSize = CGSize(width: CGFloat.infinity, height: CGFloat.infinity)
		static let CenterContents = false
	}
	
	var padding: UIEdgeInsets
	var margin: UIEdgeInsets
	
	var size: CGSize
	var maxSize: CGSize

	var centerContents: Bool
	
	init(frame: CGRect) {
		padding = Defaults.Padding
		margin = Defaults.Margin
		size = Defaults.Size
		centerContents = Defaults.CenterContents
		
		maxSize = frame.size
		super.init(frame: frame)
	}
	
	override func layoutSubviews() {
		var innerFrame = self.bounds
		innerFrame -= self.padding
		
		var accumulation = UIEdgeInsetsZero
		
		var rows = NSMutableArray()
		var currentRow = NSMutableArray()
		
		for view: AnyObject in self.subviews {
			if let view = view as? View {
				var frame = view.frame
				
				// Try to set frame
				frame.left = innerFrame.left + view.margin.left + accumulation.left
				
				//Check for overflow
				if  frame.right + view.margin.right > innerFrame.right { // Go to new row
					frame.left = innerFrame.left + view.margin.left
					accumulation.top = accumulation.bottom
					accumulation.bottom = 0 // Reset tallest item in row
					
					rows.addObject(currentRow)
					currentRow = NSMutableArray()
				}
				
				// Set the top of the rect
				frame.top = accumulation.top
				
				// Stack from left to right
				accumulation.left = frame.right + view.margin.right
				
				// Find the tallest box in row
				accumulation.bottom = max(frame.bottom + view.margin.bottom, accumulation.bottom)
				accumulation.right = max(view.margin.left + frame.right + view.margin.right, accumulation.right)
				
				// Set frame
				view.frame = frame
				
				// Collect view
				currentRow.addObject(view)
			}
		}

		rows.addObject(currentRow)
		
		if centerContents {
			for row: AnyObject in rows {
				self.centerViews(row as NSArray)
			}
		}
	}
	
	func centerViews(views: NSArray) {
		var totalWidth: CGFloat = 0
		for view: AnyObject in views {
			totalWidth = max(view.frame.right + view.margin.right, totalWidth)
		}
		
		var innerFrame = self.bounds
		innerFrame -= self.padding
		let deltaX = (innerFrame.width - totalWidth) / 2.0
		
		for view: AnyObject in views {
			if let view = view as? View {
					view.frame.left += deltaX
			}
		}
	}
	
	override func addSubview(view: UIView!) {
		if let view = view as? View {
			view.maxSize = self.maxSize
		}
		super.addSubview(view)
	}
}

