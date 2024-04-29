//
//  CharacterList.swift
//  RickAndMorty
//
//  Created by Leticia Echarri on 28/4/24.
//

import Foundation

protocol CharacterListViewModelContract {
    func viewDidLoad() async
    func getMoreCharacters() async
}

class CharacterListViewModel {
    enum ViewState: Equatable {
        case clear
        case showLoader
        case updateList([CharacterListCell.Model])
    }
    
    struct UseCases {
        let getCharactersByPage: GetCharactersByPageNameUseCaseContract
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
    private var pageName = 1
    private var characters = [CharacterModel]()
    
    init(coordinator: CoordinatorContract, useCases: UseCases) {
        self.coordinator = coordinator
        self.useCases = useCases
    }
}

extension CharacterListViewModel: CharacterListViewModelContract {
    func viewDidLoad() async {
        viewState = .showLoader
        await getMoreCharacters()
    }
    
    func getMoreCharacters() async {
        do {
            let newCharacters = try await useCases.getCharactersByPage.execute(by: pageName)
            characters.append(contentsOf: newCharacters)
            pageName += 1
            viewState = .updateList(getCells(from: characters))
        } catch {
            print(error)
            viewState = .clear
        }
    }
}

private extension CharacterListViewModel {
    func getCells(from list: [CharacterModel]) -> [CharacterListCell.Model] {
        list.compactMap { item in
            CharacterListCell.Model(imageUrlString: item.image,
                                    name: item.name,
                                    id: item.id)
        }
    }
}
