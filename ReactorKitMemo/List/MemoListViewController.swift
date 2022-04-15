//
//  MemoListViewController.swift
//  ReactorKitMemo
//
//  Created by 문효재 on 2022/04/15.
//

import UIKit
import ReactorKit

final class MemoListViewController: UIViewController, View {
  typealias Reactor = MemoListReactor
  var disposeBag = DisposeBag()

  init(reactor: Reactor) {
    super.init(nibName: nil, bundle: nil)
    self.reactor = reactor
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureUI()
    self.configureConstraints()
    
    self.title = "메모 목록"
  }
    
  private func configureUI() {
    self.view.backgroundColor = .systemBackground
    [].forEach {
      self.view.addSubview($0)
    }
  }
  
  private func configureConstraints() {
  }

  func bind(reactor: MemoListReactor) {

  }
}
