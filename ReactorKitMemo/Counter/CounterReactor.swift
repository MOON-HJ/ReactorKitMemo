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
    case showLoadIndicator(Bool)
  }
  
  struct State {
    var value: Int
    var indicatorVisible: Bool
  }
  
  init() {
    self.initialState = .init(value: 0,
                              indicatorVisible: false)
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .increase:
      return .concat([
        .just(.showLoadIndicator(true)),
        .just(.increaseValue)
        .delay(.seconds(1), scheduler: MainScheduler.instance),
        .just(.showLoadIndicator(false))
      ])
    case .decrease:
      return .concat([
        .just(.showLoadIndicator(true)),
        .just(.decreaseValue)
        .delay(.seconds(1), scheduler: MainScheduler.instance),
        .just(.showLoadIndicator(false))

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
    case .showLoadIndicator(let visible):
      state.indicatorVisible = visible
    }
    return state
  }
}
