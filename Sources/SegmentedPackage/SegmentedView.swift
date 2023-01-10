//
//  SegmentedView.swift
//  
//
//  Created by Volha Radziuk on 2023-01-09.
//

import SwiftUI

public struct SegmentedView<Item: SegmentItemProtocol>: View {

	@ObservedObject
	var contextProvider: SegmentContext<Item>

	public var body: some View {
		VStack(spacing: 10) {
			Picker(contextProvider.title, selection: $contextProvider.selected) {
				ForEach(contextProvider.total, id: \.index) {
					Text("\($0.name)")
						.tag($0)
				}
			}
			.pickerStyle(SegmentedPickerStyle())

			ForEach(contextProvider.total, id: \.index) { item in
				if item == contextProvider.triggered {
					item.viewContent
						.transition(
							.asymmetric(insertion: contextProvider.insertion, removal: contextProvider.removal)
						)
				}
			}
		}
	}
}

struct SegmentedView_Previews: PreviewProvider {

	enum PreviewItem: Int, SegmentItemProtocol {

		var index: Int { rawValue }
		var name: String { "Index--\(rawValue)" }
		var viewContent: some View {
			Text("Content View for index \(rawValue)")
				.frame(height: 150)
		}

		func makeMove(
			to item: any SegmentItemProtocol,
			trailingAnimation: AnyTransition,
			leadingAnimation: AnyTransition
		) -> AnyTransition {
			item.index > self.index ? leadingAnimation : trailingAnimation
		}

		case first
		case second
		case third
	}

    static var previews: some View {
		SegmentedView(
			contextProvider: SegmentContext(
				first: PreviewItem.first,
				nextItems: [.second, .third]
			)
		)
    }
}
