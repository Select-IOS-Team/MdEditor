//
//  ZoomingPressStateAnimatable.swift
//  MdEditor
//
//  Created by Evgeniy Novgorodov on 23.04.2023.
//

import UIKit

/// Протокол, добавляющий вью возможность включения анимированного масштабирования при нажатии.
public protocol IZoomingPressStateAnimatable: AnyObject {
	/// Включение зуммирования при нажатии на UIView.
	@discardableResult
	func enableZoomingPressStateAnimation(tapAction: (() -> Void)?) -> UIGestureRecognizer
	/// Выключение зуммирования при нажатии на UIView.
	func disableZoomingPressStateAnimation()
}

extension IZoomingPressStateAnimatable where Self: UIView {

	@discardableResult
	func enableZoomingPressStateAnimation(tapAction: (() -> Void)?) -> UIGestureRecognizer {
		let gestureRecognizer = ZoomingPressGestureRecognizer(tapAction: tapAction)
		disableZoomingPressStateAnimation()
		addGestureRecognizer(gestureRecognizer)
		return gestureRecognizer
	}

	func disableZoomingPressStateAnimation() {
		gestureRecognizers?.lazy
			.filter { $0 is ZoomingPressGestureRecognizer }
			.forEach(removeGestureRecognizer(_:))
	}
}
