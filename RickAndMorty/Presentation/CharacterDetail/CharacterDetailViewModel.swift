//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Leticia Echarri on 29/4/24.
//

import Foundation

protocol CharacterDetailViewModelContract {
    func viewDidLoad()
}

class CharacterDetailViewModel {
    enum ViewState: Equatable {
        case clear
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
    weak var viewController: CharacterDetailViewController?
    private let character: CharacterModel
    
    init(coordinator: CoordinatorContract, character: CharacterModel) {
        self.coordinator = coordinator
        self.character = character
    }
}

extension CharacterDetailViewModel: CharacterDetailViewModelContract {
    func viewDidLoad() {
        
    }
}
