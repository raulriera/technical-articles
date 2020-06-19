import UIKit

extension CGRect {
	init(startPoint: CGPoint, endPoint: CGPoint) {
		self = CGRect(x: min(startPoint.x, endPoint.x),
					  y: min(startPoint.y, endPoint.y),
					  width: abs(startPoint.x - endPoint.x),
					  height: abs(startPoint.y - endPoint.y))
	}
}

func attachDebugShapes(to canvas: UIView, from emojiView: UIView) {
	let rectBetweenPoints = CGRect(startPoint: emojiView.center, endPoint: canvas.center)
			let controlPoint = CGPoint(x: rectBetweenPoints.midX, y: rectBetweenPoints.minY)
			let path = UIBezierPath()
			path.move(to: emojiView.center)
			path.addQuadCurve(to: canvas.center, controlPoint: controlPoint)
	
			let debug1 = UIView(frame: rectBetweenPoints)
			debug1.layer.borderColor = UIColor.blue.cgColor
			debug1.layer.borderWidth = 1
	
			canvas.addSubview(debug1)
	
			let asLayer = CAShapeLayer()
			asLayer.strokeColor = UIColor.green.cgColor
			asLayer.fillColor = UIColor.clear.cgColor
			asLayer.path = path.cgPath
			canvas.layer.addSublayer(asLayer)
}
