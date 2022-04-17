//
//  MemoListViewController.swift
//  ReactorKitMemo
//
//  Created by 문효재 on 2022/04/15.
//

import UIKit

import RxCocoa
import RxSwift
import RxDataSources
import ReactorKit
import Then

final class MemoListViewController: UIViewController, View {
  typealias Reactor = MemoListReactor
  typealias Section = RxTableViewSectionedReloadDataSource<MemoListSection>
  var disposeBag = DisposeBag()
  
  let dataSource: Section = Section(configureCell: { _, tableView, indexPath, item -> UITableViewCell in
    switch item {
    case .item(let item):
      guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoListItemCell.id) as? MemoListItemCell else { return UITableViewCell() }
      cell.configure(item: item)
      return cell
    }
  })
  
  private let listView = UITableView().then {
    $0.rowHeight = UITableView.automaticDimension
    $0.estimatedRowHeight = UITableView.automaticDimension
    
    $0.register(MemoListItemCell.self, forCellReuseIdentifier: MemoListItemCell.id)
  }

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
    [listView].forEach {
      self.view.addSubview($0)
    }
  }
  
  private func configureConstraints() {
    listView.snp.makeConstraints {
      $0.edges.equalTo(view.safeAreaLayoutGuide)
    }
  }

  func bind(reactor: Reactor) {
    rx.viewDidAppear.take(1)
      .map { _ in Reactor.Action.fetch }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
    
    reactor.state
      .map { $0.items }
      .bind(to: listView.rx.items(dataSource: dataSource))
      .disposed(by: self.disposeBag)
  }
}
