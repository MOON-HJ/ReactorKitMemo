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
  private var sections: [Section] = [
    Section(identity: .items, items: [])
  ]
  
  enum Action {
    case fetch
  }
  
  enum Mutation {
    case fetchList
  }
  
  struct State {
    var items: [Section]
  }
  
  init() {
    self.initialState = .init(items: sections)
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .fetch:
      return .concat([
        .just(.fetchList)
      ])
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    switch mutation {
    case .fetchList:
      state = fetchList(state: state)
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
