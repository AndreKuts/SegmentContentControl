//
//  File.swift
//  
//
//  Created by Volha Radziuk on 2023-01-09.
//

import SwiftUI

public final class SegmentContext<Item: SegmentItemProtocol>: ObservableObject {

	public let total: [Item]
	public let title: String

	@Published var triggered: Item
	@Published var selected: Item {
		didSet {

			if oldValue != selected {

				insertion = selected.makeMove(
					to: oldValue,
					trailingAnimation: trailing,
					leadingAnimation: leading
				)

				removal = oldValue.makeMove(
					to: selected,
					trailingAnimation: trailing,
					leadingAnimation: leading
				)

				withAnimation {
					triggered = selected
				}
			}
		}
	}

	private let leading: AnyTransition
	private let trailing: AnyTransition
	public private (set) var insertion: AnyTransition
	public private (set) var removal: AnyTransition

	public init(
		first: Item,
		nextItems: [Item],
		title: String = "",
		leading: AnyTransition = .move(edge: .leading).combined(with: .opacity),
		trailing: AnyTransition = .move(edge: .trailing).combined(with: .opacity)
	) {
		self.total = [first] + nextItems
		self.triggered = first
		self.selected = first
		self.title = title
		self.insertion = trailing
		self.removal = leading
		self.leading = leading
		self.trailing = trailing
	}
}

public struct NotEmpty<Item> {
	public let head: Item
	public let tail: [Item]
	public var total: [Item] { [head] + tail }
}
