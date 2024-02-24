//
//  Bindable.swift
//  GithubFollowers
//
//  Created by Tuấn Kiều on 24/02/2024.
//

import UIKit

public protocol Bindable: AnyObject {
    associatedtype ViewModelType

    var viewModel: ViewModelType! { get set }

    func bindViewModel()
}

extension Bindable where Self: UIViewController {
    public func bindViewModel(to model: Self.ViewModelType) {
        viewModel = model
        loadViewIfNeeded()

        bindViewModel()
    }
}
