//
//  TickPicker.swift
//  TickPickerView
//
//  Created by 이승진 on 1/4/26.
//

import SwiftUI

struct TickConfig {
  var tickWidth: CGFloat = 3
  var tickHeight: CGFloat = 30
  var tickPadding: CGFloat = 3
  var inActiveHeightProgress: CGFloat = 0.55
  var interactionHeight: CGFloat = 60
  var activeTint: Color = .yellow
  var inActiveTint: Color = .primary
  var alignment: Alignment = .bottom
  var animation: Animation = .interpolatingSpring(duration: 0.3, bounce: 0, initialVelocity: 0)
  
  enum Alignment: String, CaseIterable {
    case top = "Top"
    case bottom = "Bottom"
    case center = "Center"
    
    var value: SwiftUI.Alignment {
      switch self {
      case .top: return .top
      case .bottom: return .bottom
      case .center: return .center
      }
    }
  }
}

struct TickPicker: View {
  var count: Int
  var config: TickConfig = .init()
  
  @Binding var selection: Int
  
  /// View Properties
  @State private var scrollIndex: Int = 0
  @State private var scrollPosition: Int?
  @State private var scrollPhase: ScrollPhase = .idle
  @State private var animationRange: ClosedRange<Int> = 0...0
  @State private var isInitialSetupDone: Bool = false
  
  var body: some View {
    GeometryReader {
      let size = $0.size
      
      ScrollView(.horizontal) {
        LazyHStack(spacing: 0) {
          ForEach(0...count, id: \.self) { index in
            TickView(index)
          }
        }
        .frame(height: config.tickHeight)
        .frame(maxHeight: .infinity)
        .contentShape(.rect)
      }
      .scrollIndicators(.hidden)
      .scrollTargetBehavior(.viewAligned(limitBehavior: .alwaysByOne))
      .scrollPosition(id: $scrollPosition, anchor: .center)
      
      /// 중심 맞추기
      .safeAreaPadding(.horizontal, (size.width - width) / 2)
      .onScrollGeometryChange(for: CGFloat.self) {
        $0.contentOffset.x + $0.contentInsets.leading
      } action: { oldValue, newValue in
        guard scrollPhase != .idle else { return }
        let index = max(min(Int((newValue / width).rounded()), count), 0)
        let previousScrollIndex = scrollIndex
        scrollIndex = index
        
        let isGreater = scrollIndex > previousScrollIndex
        let leadingBound = isGreater ? previousScrollIndex : scrollIndex
        let trailingBound = !isGreater ? previousScrollIndex : scrollIndex
        
        animationRange = leadingBound...trailingBound
      }
      .onScrollPhaseChange { oldPhase, newPhase in
        scrollPhase = newPhase
        animationRange = scrollIndex...scrollIndex
        
        /// 일부 희귀한 경우에는 보기 정렬된 대상 동작이 항목의 중심이 되지 않을 수 있음
        if newPhase == .idle && scrollPosition != scrollIndex {
          withAnimation(config.animation) {
            scrollPosition = scrollIndex
          }
        }
      }
    }
    .frame(height: config.interactionHeight)
    .task {
      guard !isInitialSetupDone else { return }
      
      /// 초기 스크롤 설정
      updateScrollPosition(selection: selection)
      
      /// 옵셔널
      try? await Task.sleep(for: .seconds(0.05))
      
      isInitialSetupDone = true
    }
    /// 초기 설정이 완료된 후에만 상호작용 활성화
    .onChange(of: scrollIndex) { oldValue, newValue in
      selection = newValue
    }
    .onChange(of: selection) { oldValue, newValue in
      guard scrollIndex != newValue else { return }
      updateScrollPosition(selection: newValue)
    }
  }
  
  /// Tick View
  @ViewBuilder
  func TickView(_ index: Int) -> some View {
    let height = config.tickHeight
    let isInside = animationRange.contains(index)
    let fillColor = scrollIndex == index ? config.activeTint : config.inActiveTint.opacity(isInside ? 1 : 0.4)
    
    Rectangle()
      .fill(fillColor)
      .frame(
        width: config.tickWidth,
        height: height * (isInside ? 1 : config.inActiveHeightProgress)
      )
      .frame(width: width, height: height, alignment: config.alignment.value)
      .animation(isInside || !isInitialSetupDone ? .none : config.animation, value: isInside)
  }
  
  func updateScrollPosition(selection: Int) {
    let safeSelection = max(min(selection, count), 0)
    scrollPosition = safeSelection
    scrollIndex = safeSelection
    animationRange = safeSelection...safeSelection
  }
  
  var width: CGFloat {
    return config.tickWidth + (config.tickPadding * 2)
  }
}

#Preview {
  ContentView()
}
