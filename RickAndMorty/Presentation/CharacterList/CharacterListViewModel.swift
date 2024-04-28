//
//  CharacterList.swift
//  RickAndMorty
//
//  Created by Leticia Echarri on 28/4/24.
//

import Foundation

protocol CharacterListViewModelContract {
    func viewDidLoad() async
}

class CharacterListViewModel {
    enum ViewState: Equatable {
        case clear
        case showLoader
        case updateList([CharacterListCell.Model])
    }
    
    struct UseCases {
        let getAllCharacters: GetCharactersUseCaseContract
    }
    
    var viewState: ViewState = .clear {
        didSet {
            guard oldValue != viewState else {
                preconditionFailure("If states were correctly implemented, this wouldn't have happened. 😒")
            }
            viewController?.changeViewState(viewState)
        }
    }
    
    weak private var coordinator: CoordinatorContract?
    weak var viewController: CharacterListViewControllerContract?
    private let useCases: UseCases
    
    init(coordinator: CoordinatorContract, useCases: UseCases) {
        self.coordinator = coordinator
        self.useCases = useCases
    }
}

extension CharacterListViewModel: CharacterListViewModelContract {
    func viewDidLoad() async {
        viewState = .showLoader
        do {
            let characters = try await useCases.getAllCharacters.execute()
            viewState = .updateList(getCells(from: characters))
        } catch {
            print(error)
        }
    }
}

private extension CharacterListViewModel {
    func getCells(from list: [CharacterModel]) -> [CharacterListCell.Model] {
        list.compactMap { item in
            CharacterListCell.Model(imageUrlString: item.url,
                                    name: item.name,
                                    id: item.id)
        }
    }
}
