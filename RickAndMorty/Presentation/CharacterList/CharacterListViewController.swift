//
//  CharacterListViewController.swift
//  RickAndMorty
//
//  Created by Leticia Echarri on 28/4/24.
//

import UIKit

protocol CharacterListViewControllerContract: AnyObject {
    var viewModel: CharacterListViewModelContract { get set }

    func changeViewState(_ state: CharacterListViewModel.ViewState)
}

class CharacterListViewController: UIViewController, ActivityIndicatorPresenter {
    var activityIndicator = UIActivityIndicatorView()
    var viewModel: CharacterListViewModelContract
    
    // MARK: - Life cycle
    init(viewModel: CharacterListViewModelContract) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("Storyboard are a pain")
    }
    
    override func loadView() {
        super.loadView()
        setupViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        Task {
            await viewModel.viewDidLoad()
        }
    }
}

private extension CharacterListViewController {
    func setupViews() {
        view.backgroundColor = .white
    }
}

extension CharacterListViewController: CharacterListViewControllerContract {
    func changeViewState(_ state: CharacterListViewModel.ViewState) {
        switch state {
        case .clear:
            break
        case .showLoader:
            showActivityIndicator()
        case .hideLoader:
            hideActivityIndicator()
        }
    }
}
