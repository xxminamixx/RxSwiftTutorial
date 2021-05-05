//
//  ViewController.swift
//  RxSwiftTutorial
//
//  Created by 南京兵 on 2021/02/06.
//

import UIKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController {
  
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var textField: UITextField!
  @IBOutlet private weak var resetButton: UIButton!
  @IBOutlet private weak var fetchButton: UIButton!
  
  private let viewModel: ViewModelProtocol = {
    ViewModel()
  }()
  
  private let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // ViewModelの変更をTextFieldが監視
    viewModel.title
      .bind(to: textField.rx.text)
      .disposed(by: disposeBag)
    // ViewModelの変更をラベルが監視
    viewModel.title
      .bind(to: titleLabel.rx.text)
      .disposed(by: disposeBag)
    // TextField の変更をViewModelが監視
    textField.rx.text.orEmpty
      .bind(to: viewModel.title)
      .disposed(by: disposeBag)
    
    // リセットボタンの押下イベント設定
    resetButton.rx.tap
      .bind(to: buttonTapBinder)
      .disposed(by: disposeBag)
    // フェッチボタンの押下イベントを設定
    fetchButton.rx.tap
      .subscribe { [unowned self] _ in
        // subscribe で stream を検知して処理を実行する
        self.viewModel.fetch()
      }
      .disposed(by: disposeBag)
    
  }
  
  /// ボタン押下時処理
  private var buttonTapBinder: Binder<()> {
    return Binder(self) { base, _ in
      // ViewModelに値をセット
      // accept で stream に値を流す
      self.viewModel.title.accept("")
    }
  }
  
}

