//
//  MiniatureAction.swift
//  MinatureActionsView
//
//  Created by 이승진 on 12/31/25.
//

import SwiftUI

struct MiniatureAction<Actions: View, Background: View>: View {
  var innerScaling: CGFloat = 1
  var minimisedButtonSize: CGSize = .init(width: 50, height: 50)
  var animation: Animation
  @Binding var isPresented: Bool
  @ViewBuilder var actions: Actions
  @ViewBuilder var background: Background
  var body: some View {
    actions
    /// Disabling interaction when minimised
      .allowsHitTesting(isPresented)
      .contentShape(.rect)
      .compositingGroup()
      /// Scaling the actions to fit into the button size using the visual effect modifier
      .visualEffect({ [innerScaling, minimisedButtonSize, isPresented] content, proxy in
        let maxValue = max(proxy.size.width, proxy.size.height)
        let minButtonValue = min(minimisedButtonSize.width, minimisedButtonSize.height)
        let fitScale = minButtonValue / maxValue
        let modifiedInnerScale = 0.55 * innerScaling
        return content
          .scaleEffect(isPresented ? 1 : modifiedInnerScale)
          .scaleEffect(isPresented ? 1 : fitScale)
      })
      .background(
        background
          .frame(
            width: minimisedButtonSize.width,
            height: minimisedButtonSize.height
          )
      )
  }
}

#Preview {
  ContentView()
}
