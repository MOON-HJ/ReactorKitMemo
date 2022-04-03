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
  }
  
  struct State {
    var value: Int
  }
  
  init() {
    self.initialState = .init(value: 0)
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .increase:
      return .concat([
        .just(.increaseValue)
      ])
    case .decrease:
      return .concat([
        .just(.decreaseValue)
      ])
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    switch mutation {
    case .increaseValue:
      state.value += 1
    case .decreaseValue:
      state.value -= 1
    }
    return state
  }
}
