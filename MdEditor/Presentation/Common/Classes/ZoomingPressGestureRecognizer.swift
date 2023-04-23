//
//  ZoomingPressGestureRecognizer.swift
//  MdEditor
//
//  Created by Evgeniy Novgorodov on 23.04.2023.
//

import UIKit

private extension CGFloat {
	static let distanceToScroll: CGFloat = 10
}

private extension CATransform3D {
	static let minScale = CATransform3DMakeScale(0.97, 0.97, 1)
	static let maxScale = CATransform3DMakeScale(1, 1, 1)
}

private extension TimeInterval {
	static let animation100ms: TimeInterval = 0.1
}

/// UIGestureRecognizer, добавляющий анимированное масштабирование при нажатии на вью.
final class ZoomingPressGestureRecognizer: UIGestureRecognizer {

	// MARK: - Private properties

	private var initialTouchPoint: CGPoint?
	private var animator: UIViewPropertyAnimator?
	private var tapAction: (() -> Void)?

	// MARK: - Lifecycle

	convenience init(tapAction: (() -> Void)? = nil) {
		self.init()
		self.tapAction = tapAction

		addTarget(self, action: #selector(handleTouch(_:)))
		cancelsTouchesInView = false
	}

	override func canPrevent(_ preventedGestureRecognizer: UIGestureRecognizer) -> Bool {
		return false
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
		super.touchesBegan(touches, with: event)
		self.state = .began
		self.initialTouchPoint = touches.first?.location(in: view)
	}

	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
		super.touchesMoved(touches, with: event)

		guard let touchPoint = touches.first?.location(in: view), let initialTouchPoint = self.initialTouchPoint else {
			self.state = .cancelled
			return
		}

		if abs(touchPoint.y - initialTouchPoint.y) > .distanceToScroll {
			self.state = .cancelled
		} else {
			self.state = .changed
		}
	}

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
		super.touchesEnded(touches, with: event)
		self.state = .ended
	}

	override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
		super.touchesCancelled(touches, with: event)
		self.state = .cancelled
	}

	override func reset() {
		super.reset()
		initialTouchPoint = nil
	}
}

// MARK: - Private methods

extension ZoomingPressGestureRecognizer {

	private func startPressAnimation() {
		view?.isUserInteractionEnabled = false
		animator = UIViewPropertyAnimator(duration: .animation100ms, curve: .linear) {
			self.view?.layer.transform = .minScale
		}
		animator?.startAnimation()
	}

	private func startRetrievalAnimation(canceled: Bool) {
		animator = UIViewPropertyAnimator(duration: .animation100ms, curve: .linear) {
			self.view?.layer.transform = .maxScale
		}
		animator?.addCompletion { _ in
			self.view?.isUserInteractionEnabled = true
		}
		if !canceled {
			animator?.addCompletion { _ in
				self.tapAction?()
			}
		}
		animator?.startAnimation()
	}

	@objc private func handleTouch(_ gestureRecognizer: UIGestureRecognizer) {
		var canceled = true
		switch gestureRecognizer.state {
		case .possible, .changed:
			break
		case .began:
			startPressAnimation()
		case .ended:
			canceled = false
			fallthrough
		case .cancelled, .failed:
			if animator?.isRunning == true {
				animator?.addCompletion { _ in
					self.startRetrievalAnimation(canceled: canceled)
				}
			} else {
				startRetrievalAnimation(canceled: canceled)
			}
		@unknown default:
			break
		}
	}
}
