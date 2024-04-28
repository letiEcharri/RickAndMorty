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
    }
    
    struct UseCases {
        let getAllCharacters: GetCharactersUseCaseContract
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
        do {
            let characters = try await useCases.getAllCharacters.execute()
        } catch {
            print(error)
        }
    }
}
