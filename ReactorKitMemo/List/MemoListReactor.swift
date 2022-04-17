//
//  MemoListReactor.swift
//  ReactorKitMemo
//
//  Created by 문효재 on 2022/04/15.
//

import Foundation
import ReactorKit

final class MemoListReactor: Reactor {
  typealias Section = MemoListSection
  
  var initialState: State
  
  enum Action {
    case fetch
  }
  
  enum Mutation {
    case fetchList
    case loading(Bool)
  }
  
  struct State {
    var items: [Section]
    var indicatorVisible: Bool
  }
  
  init() {
    self.initialState = .init(items: [],
                              indicatorVisible: false)
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .fetch:
      return .concat([
        .just(.loading(true)),
        .just(.fetchList).delay(.milliseconds(500), scheduler: MainScheduler.instance),
        .just(.loading(false))
      ])
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    switch mutation {
    case .fetchList:
      state = fetchList(state: state)
    case .loading(let visible):
      state.indicatorVisible = visible
    }
    
    return state
  }
}

// MARK: - Mutate Method
extension MemoListReactor {
  private func fetchList(state: State) -> State {
    var state = state
    state.items = [.init(identity: .items, items: ["Hello World", "Swift", "hey"].map { .item(.init(title: $0)) })]
    return state
  }
}
