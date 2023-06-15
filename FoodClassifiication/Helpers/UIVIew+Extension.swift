//
//  UIVIew+Extension.swift
//  FoodClassifiication
//
//  Created by Тимофей Борисов on 02.06.2023.
//

import UIKit

// MARK: - Frame extension UIView
extension UIView {
	public var width: CGFloat {
		return self.frame.size.width
	}
	
	public var height: CGFloat {
		return self.frame.size.height
	}
	
	public var top: CGFloat {
		return self.frame.origin.y
	}
	
	public var bottom: CGFloat {
		return self.height + self.top
	}
	
	public var left: CGFloat {
		return self.frame.origin.x
	}
	
	public var right: CGFloat {
		return self.width + self.left
	}

	func showAnimation(_ completionBlock: @escaping () -> Void) {
	  isUserInteractionEnabled = false
		UIView.animate(withDuration: 0.1,
					   delay: 0,
					   options: .curveLinear,
					   animations: { [weak self] in
							self?.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
		}) {  (done) in
			UIView.animate(withDuration: 0.1,
						   delay: 0,
						   options: .curveLinear,
						   animations: { [weak self] in
								self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
			}) { [weak self] (_) in
				self?.isUserInteractionEnabled = true
				completionBlock()
			}
		}
	}
}
