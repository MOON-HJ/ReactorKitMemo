//
//  CounterReactor.swift
//  ReactorKitMemo
//
//  Created by 문효재 on 2022/04/03.
//

import Foundation
import ReactorKit

class CounterReactor: Reactor {
  var initialState: State
  
  enum Action {
    case increase
    case decrease
  }
  
  enum Mutation {
    case increaseValue
    case decreaseValue
    case loading(Bool)
  }
  
  struct State {
    var value: Int
    var indicatorVisible: Bool
    var alertMessage: String?
  }
  
  init() {
    self.initialState = .init(value: 0,
                              indicatorVisible: false,
                              alertMessage: nil)
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .increase:
      return .concat([
        .just(.loading(true)),
        .just(.increaseValue)
        .delay(.milliseconds(20), scheduler: MainScheduler.instance),
        .just(.loading(false))
      ])
    case .decrease:
      return .concat([
        .just(.loading(true)),
        .just(.decreaseValue)
        .delay(.milliseconds(20), scheduler: MainScheduler.instance),
        .just(.loading(false))
      ])
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    switch mutation {
    case .increaseValue:
      state = increaseValue(state: state)
    case .decreaseValue:
      state = decreaseValue(state: state)
    case .loading(let visible):
      state.indicatorVisible = visible
    }
    return state
  }
}

// MARK: - Reduce Method
extension CounterReactor {
  private func increaseValue(state: State) -> State {
    var state = state
    if state.value >= 10 {
      state.alertMessage = "값이 10 이상입니다"
    } else {
      state.alertMessage = nil
      state.value += 1
    }
    return state
  }
  
  private func decreaseValue(state: State) -> State {
    var state = state
    if state.value >= -10 {
      state.value -= 1
      state.alertMessage = nil
    } else {
      state.alertMessage = "값이 -10 미만입니다"
    }
    return state
  }
}
