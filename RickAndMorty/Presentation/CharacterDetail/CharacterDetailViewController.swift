//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Leticia Echarri on 29/4/24.
//

import UIKit

protocol CharacterDetailViewControllerContract: AnyObject {
    var viewModel: CharacterDetailViewModelContract { get set }

    func changeViewState(_ state: CharacterDetailViewModel.ViewState)
}

class CharacterDetailViewController: UIViewController {
    var viewModel: CharacterDetailViewModelContract
    
    // MARK: - Life cycle
    init(viewModel: CharacterDetailViewModelContract) {
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
        viewModel.viewDidLoad()
    }
}

private extension CharacterDetailViewController {
    func setupViews() {
        title = "Detail"
        view.backgroundColor = .systemGroupedBackground
    }
}

extension CharacterDetailViewController: CharacterDetailViewControllerContract {
    func changeViewState(_ state: CharacterDetailViewModel.ViewState) {
        DispatchQueue.main.async {
            switch state {
            case .clear:
                break
            }
        }
    }
}
