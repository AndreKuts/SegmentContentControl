//
//  File.swift
//  
//
//  Created by Volha Radziuk on 2023-01-09.
//

import SwiftUI

public protocol ViewContentProvider {

	associatedtype ViewContent: View

	/// View content for selected segment
	var viewContent: ViewContent { get }

}

public protocol SegmentMoveDeciderProtocol {

	/// Decide which animation will be used for the selected segment item.
	func makeMove(to item: any SegmentItemProtocol, trailingAnimation: AnyTransition, leadingAnimation: AnyTransition) -> AnyTransition
}

public protocol SegmentItemProtocol: Hashable, ViewContentProvider, SegmentMoveDeciderProtocol {

	/// Order index to determine the current position and future animation.
	var index: Int { get }

	/// String value for displaying in segment control
	var name: String { get }

}
