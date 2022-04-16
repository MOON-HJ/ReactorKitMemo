//
//  MemoListItemCell.swift
//  ReactorKitMemo
//
//  Created by 문효재 on 2022/04/15.
//

import UIKit
import SnapKit

class MemoListItemCell: UITableViewCell {
  static let id: String = "MemoListItemCell"
  private var item: MemoListItem?
  
  private let titleLabel = UILabel()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureUI()
    configureConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func configure(item: MemoListItem) {
    self.item = item
  }
  
  private func configureUI() {
    self.contentView.backgroundColor = .white
    [titleLabel].forEach {
      contentView.addSubview($0)
    }
  }
  
  private func configureConstraints() {
    titleLabel.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
