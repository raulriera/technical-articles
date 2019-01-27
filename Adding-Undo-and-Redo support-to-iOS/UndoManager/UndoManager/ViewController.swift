//
//  ViewController.swift
//  UndoManager
//
//  Created by Raul Riera on 2019-01-27.
//  Copyright © 2019 Raul Riera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	var state: State {
		didSet {
			label.text = state.debugDescription
			
			//	While the code is running on the main thread, the undo manager doesn’t update its state until after `registerUndo` returns. Using the DispatchQueue block allows the UI update to wait until this undo/redo operation completes.
			DispatchQueue.main.async {
				self.undoButton?.isEnabled = self.undoManager?.canUndo == true
				self.redoButton?.isEnabled = self.undoManager?.canRedo == true
			}
		}
	}
	
	@IBOutlet weak var label: UILabel!
	
	private var count: Int = 0
	private var undoButton: UIBarButtonItem?
	private var redoButton: UIBarButtonItem?
	
	private let _um = UndoManager()
	override var undoManager: UndoManager? {
		return _um
	}
	
	// By overwriting undoManager and this property, our view controller
	// will prompt you to undo and redo after you shake the device.
	// Give it a try :)
	override var canBecomeFirstResponder: Bool {
		return true
	}
	
	required init?(coder aDecoder: NSCoder) {
		self.state = State(person: Person(name: "Initial state"))
		super.init(coder: aDecoder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		
		undoButton = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(didTapUndo))
		redoButton = UIBarButtonItem(barButtonSystemItem: .redo, target: self, action: #selector(didTapRedo))
		
		undoButton?.isEnabled = false
		redoButton?.isEnabled = false
		
		navigationItem.leftBarButtonItems = [undoButton!, redoButton!]
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
		
		title = "Undo manager"
		
		label.text = state.debugDescription
	}
	
	@objc func didTapAdd(_ button: UIBarButtonItem) {
		// You can spam `appendState` and the undo operation will revert all of them
		// in a single group.
		appendState()
	}
	
	func appendState() {
		let newState = State(person: Person(name: "Name \(count)"))
		
		undoManager?.replace(item: self.state, with: newState, handler: { stateFromStack in
			print("Undoing: \(self.state) for \(stateFromStack)")
			self.state = stateFromStack
		})
		
		self.state = newState
		count = count + 1
	}
	
	@objc func didTapUndo(_ button: UIBarButtonItem) {
		undoManager?.undo()
	}
	
	@objc func didTapRedo(_ button: UIBarButtonItem) {
		undoManager?.redo()
	}
}

// Undo Manager

extension UndoManager {
	func replace<T: Codable>(item oldItem: T, with newItem: T, title: String? = nil, handler: ((T) -> Void)?) {
		guard let oldItem = copy(item: oldItem) else { return }
		guard let newItem = copy(item: newItem) else { return }
		
		registerUndo(withTarget: self) {
			handler?(oldItem)
			$0.replace(item: newItem, with: oldItem, title: title, handler: handler)
		}
		
		guard let title = title else { return }
		setActionName(title)
	}
	
	private func copy<T: Codable>(item: T) -> T? {
		guard let data = try? JSONEncoder().encode(item) else {
			return nil
		}
		
		return try? JSONDecoder().decode(T.self, from: data)
	}
}

// Files for quickly debugging the copy function

struct State: CustomDebugStringConvertible, Codable, Equatable {
	let person: Person
	var debugDescription: String {
		return "\(person.name)"
	}
}

class Person: Codable, Equatable {
	let name: String
	
	init(name: String) {
		self.name = name
	}
	
	static func == (lhs: Person, rhs: Person) -> Bool {
		return lhs.name == rhs.name
	}
}
