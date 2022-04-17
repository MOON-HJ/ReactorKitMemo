//
//  MemoListItemCell.swift
//  ReactorKitMemo
//
//  Created by 문효재 on 2022/04/15.
//

import UIKit
import SnapKit

class MemoListItemCell: BaseTableViewCell {
  static let id: String = "MemoListItemCell"
  private var item: MemoListItem?
  
  private let titleLabel = UILabel().then {
    $0.textColor = .black
    $0.font = .systemFont(ofSize: 16)
    $0.sizeToFit()
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  

  public func configure(item: MemoListItem) {
    super.configure()
    
    self.item = item
    self.titleLabel.text = item.title
  }
  
  override func configureUI() {
    super.configureUI()
    
    [titleLabel].forEach {
      contentView.addSubview($0)
    }
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    titleLabel.snp.makeConstraints {
      $0.top.left.equalToSuperview().offset(16)
      $0.right.bottom.equalToSuperview().offset(-16)
    }
  }
}
