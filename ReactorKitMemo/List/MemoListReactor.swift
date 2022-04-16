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
    Section(identity: .items, items: [
      .item(.init(title: "헬로월드"))
    ])
  ]
  
  enum Action {
  }
  
  enum Mutation {
  }
  
  struct State {
    let items: [Section]
  }
  
  init() {
    self.initialState = .init(items: sections)
  }
  
  func mutate(action: Action) -> Observable<Mutation> {

  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    
  }
}
