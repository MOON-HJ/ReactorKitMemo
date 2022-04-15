//
//  MemoListReactor.swift
//  ReactorKitMemo
//
//  Created by 문효재 on 2022/04/15.
//

import Foundation
import ReactorKit

final class MemoListReactor: Reactor {
  var initialState: State
  
  enum Action {
  }
  
  enum Mutation {
  }
  
  struct State {
  }
  
  init() {
    self.initialState = .init()
  }
  
  func mutate(action: Action) -> Observable<Mutation> {

  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    
  }
}
