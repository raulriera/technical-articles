import UIKit

public struct AdaptiveColor {
	/// See [UserInterfaceLevel](https://developer.apple.com/documentation/uikit/uiuserinterfacelevel) for more info.
	private(set) var base: (light: UIColor, dark: UIColor)
	/// The color used for content visually above your window's main content. If none is specified, the `base` color is used instead.
	///
	/// See [UserInterfaceLevel](https://developer.apple.com/documentation/uikit/uiuserinterfacelevel) for more info.
	private(set) var elevated: (light: UIColor, dark: UIColor)
	
	public init(light: UIColor, dark: UIColor) {
		base = (light: light, dark: dark)
		elevated = base
	}
	
	public init(base: (light: UIColor, dark: UIColor), elevated: (light: UIColor, dark: UIColor)) {
		self.base = base
		self.elevated = elevated
	}
	
	public var value: UIColor {
		if #available(iOSApplicationExtension 13.0, *) {
			return UIColor { traitCollection in
				let isElevated = traitCollection.userInterfaceLevel == .elevated
				if traitCollection.userInterfaceStyle == .dark {
					return isElevated ? self.elevated.dark : self.base.dark
				} else {
					return isElevated ? self.elevated.light : self.base.light
				}
			}
		} else {
			return base.light
		}
	}
}
