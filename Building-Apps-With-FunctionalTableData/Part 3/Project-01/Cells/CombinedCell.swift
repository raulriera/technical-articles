//
//  CombinedCell.swift
//  Project-01
//
//  Created by Geoff Foster on 2017-12-08.
//  Copyright © 2017 Raul Riera. All rights reserved.
//

import UIKit
import FunctionalTableData

/** `CombinedCell` while very daunting to look at, is actually very simple once
we go over through all the generics.

`View1` and `View2` needs to be an instance of `UIView`, which are the two views displayed side
by side in our instances of `CombinedCell`.

`State1` and `State2` needs to conform to `Equatable`, and are used to update the contents of the previously
defined view pairs.

Lastly, `Layout` needs to conform to `TableItemLayout` and defines how our cell is layout in our container.
*/
public typealias CombinedCell<View1: UIView, State1: Equatable, View2: UIView, State2: Equatable, Layout: TableItemLayout> = HostCell<CombinedView<View1, View2>, CombinedState<State1, State2>, Layout>

public struct CombinedState<S1: Equatable, S2: Equatable>: Equatable {
	public let state1: S1
	public let state2: S2
	public init(state1: S1, state2: S2) {
		self.state1 = state1
		self.state2 = state2
	}
	
	public static func ==(lhs: CombinedState, rhs: CombinedState) -> Bool {
		return lhs.state1 == rhs.state1 && lhs.state2 == rhs.state2
	}
}

public class CombinedView<View1: UIView, View2: UIView>: UIView {
	public let view1 = View1()
	public let view2 = View2()
	public let stackView: UIStackView
	
	public override init(frame: CGRect) {
		stackView = UIStackView(frame: frame)
		super.init(frame: frame)
		stackView.addArrangedSubview(view1)
		stackView.addArrangedSubview(view2)
		
		stackView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(stackView)
		
		NSLayoutConstraint.activate([
			stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
			stackView.topAnchor.constraint(equalTo: topAnchor),
			stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
	
	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
