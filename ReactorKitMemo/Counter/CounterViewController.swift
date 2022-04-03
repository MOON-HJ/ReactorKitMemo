//
//  CounterViewController.swift
//  ReactorKitMemo
//
//  Created by 문효재 on 2022/04/03.
//

import UIKit
import SnapKit
import RxCocoa
import ReactorKit

final class CounterViewController: UIViewController, View {
  typealias Reactor = CounterReactor
  var disposeBag = DisposeBag()
  
  private let increaseButton: UIButton = {
    var button = UIButton()
    button.setTitle("+", for: .normal)
    button.setTitleColor(UIColor.systemBlue, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
    return button
  }()
  
  private let decreaseButton: UIButton = {
    var button = UIButton()
    button.setTitle("-", for: .normal)
    button.setTitleColor(UIColor.systemBlue, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
    return button
  }()

  private let label: UILabel = {
    var label = UILabel()
    label.text = "0"
    label.textColor = .label
    label.font = .systemFont(ofSize: 30, weight: .heavy)
    return label
  }()
  
  private let indicator: UIActivityIndicatorView = {
    var indicator = UIActivityIndicatorView()
    indicator.hidesWhenStopped = true
    return indicator
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureUI()
    self.configureConstraints()

  }
  
  init(reactor: Reactor) {
    super.init(nibName: nil, bundle: nil)
    self.reactor = reactor
  }
    
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI() {
    self.view.backgroundColor = .systemBackground
    [increaseButton, label, decreaseButton, indicator].forEach {
      self.view.addSubview($0)
    }
  }
  
  private func configureConstraints() {
    decreaseButton.snp.makeConstraints {
      $0.left.equalToSuperview().offset(24)
      $0.centerY.equalToSuperview()
      $0.right.equalTo(label).offset(-24)
    }
    
    label.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
    
    increaseButton.snp.makeConstraints {
      $0.left.equalTo(label).offset(24)
      $0.centerY.equalToSuperview()
      $0.right.equalToSuperview().offset(-24)
    }
    
    indicator.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.centerY.equalToSuperview().multipliedBy(0.5)
    }
  }
  
  // MARK: Bind Reactor
  func bind(reactor: CounterReactor) {
    decreaseButton.rx.tap
      .map { Reactor.Action.decrease }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
    
    increaseButton.rx.tap
      .map { Reactor.Action.increase }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
    
    reactor.state
      .map { String($0.value) }
      .distinctUntilChanged()
      .bind(to: label.rx.text)
      .disposed(by: self.disposeBag)
    
    reactor.state
      .map { $0.indicatorVisible }
      .bind(to: indicator.rx.isAnimating )
      .disposed(by: self.disposeBag)
  }
}
