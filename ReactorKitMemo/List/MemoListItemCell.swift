//
//  MemoListItemCell.swift
//  ReactorKitMemo
//
//  Created by 문효재 on 2022/04/15.
//

import UIKit

class MemoListItemCell: UITableViewCell {
  static let id: String = "MemoListItemCell"
  private var item: MemoListItem?
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  public func configure(item: MemoListItem) {
    self.item = item
  }
}


