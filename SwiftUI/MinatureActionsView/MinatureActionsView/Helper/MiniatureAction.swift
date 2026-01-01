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
    /// Act's like a button tap to expend actions
      .overlay {
        if !isPresented {
          Capsule()
            .foregroundStyle(.clear)
            .frame(width: minimisedButtonSize.width, height: minimisedButtonSize.height)
            .contentShape(.capsule)
            .onTapGesture {
              isPresented = true
            }
            .transition(.identity)
        }
      }
      .background(
        background
          .frame(
            width: isPresented ? nil : minimisedButtonSize.width,
            height: isPresented ? nil : minimisedButtonSize.height
          )
          .compositingGroup()
        /// Fading out with blur
          .opacity(isPresented ? 0 : 1)
          .blur(radius: isPresented ? 30 : 0)
      )
      .fixedSize()
      .frame(
        width: isPresented ? nil : minimisedButtonSize.width,
        height: isPresented ? nil : minimisedButtonSize.height
      )
      .animation(animation, value: isPresented)
  }
}

#Preview {
  ContentView()
}
