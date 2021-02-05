//
//  ViewModel.swift
//  RxSwiftTutorial
//
//  Created by 南京兵 on 2021/02/06.
//

import UIKit
import RxSwift
import RxRelay

protocol ViewModelProtocol {
  var title: BehaviorRelay<String> { get set }
}

struct ViewModel: ViewModelProtocol {
  var title = BehaviorRelay<String>(value: "")
}
