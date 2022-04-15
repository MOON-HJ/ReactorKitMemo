//
//  MemoListSection.swift
//  ReactorKitMemo
//
//  Created by 문효재 on 2022/04/15.
//

import RxDataSources

struct MemoListSection {
  enum Identity: Int {
    case items
  }
  let identity: Identity
  var items: [MemoListSectionItem]
}

extension MemoListSection: SectionModelType {
  init(original: MemoListSection, items: [MemoListSectionItem]) {
    self = .init(identity: original.identity, items: items)
  }
}

enum MemoListSectionItem {
  case item
}
