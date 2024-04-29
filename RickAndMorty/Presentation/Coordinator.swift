//
//  CoordinatorProtocol.swift
//  RickAndMorty
//
//  Created by Leticia Echarri on 28/4/24.
//

import UIKit

protocol CoordinatorContract: AnyObject {
    func start()
    func navigateToDetail(with character: CharacterModel) 
}

class Coordinator: CoordinatorContract {
    var navigationController: UINavigationController?
    var window: UIWindow
    
    init(_ window: UIWindow) {
        self.window = window
    }
    
    func start() {
        navigationController = UINavigationController(rootViewController: getCharacterListView())
        navigationController?.modalPresentationStyle = .fullScreen
        window.rootViewController = navigationController
    }
    
    func navigateToDetail(with character: CharacterModel) {
        let viewModel = CharacterDetailViewModel(coordinator: self, character: character)
        let view = CharacterDetailViewController(viewModel: viewModel)
        viewModel.viewController = view
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(view, animated: true)
        }
    }
}

private extension Coordinator {
    func getCharacterListView() -> CharacterListViewController {
        let dataSource = RMDataSource()
        let repository = CharacterRepository(.rickAndMorty(dataSource))
        let getCharactersByPageUseCase = GetCharactersByPageNameUseCase(repository: repository)
        let viewModel = CharacterListViewModel(coordinator: self,
                                               useCases: CharacterListViewModel.UseCases(getCharactersByPage: getCharactersByPageUseCase))
        let view = CharacterListViewController(viewModel: viewModel)
        viewModel.viewController = view
        return view
    }
}
