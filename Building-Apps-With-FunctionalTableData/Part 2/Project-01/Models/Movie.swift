//
//  Movie.swift
//  Project-01
//
//  Created by Raul Riera on 24/06/2017.
//  Copyright © 2017 Raul Riera. All rights reserved.
//

import Foundation

struct Movie: Codable, Equatable {
	let title: String
	let summary: String
	let price: Double
	let url: URL
	
	// MARK: Equatable
	
	static func ==(lhs: Movie, rhs: Movie) -> Bool {
		return lhs.title == rhs.title &&
			lhs.summary == rhs.summary &&
			lhs.price == rhs.price &&
			lhs.url == rhs.url
	}
}
