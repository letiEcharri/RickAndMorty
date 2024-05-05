protocol GetCharactersByNameUseCaseContract {
    func execute(name: String) async throws -> [CharacterModel]
}

struct GetCharactersByNameUseCase: GetCharactersByNameUseCaseContract {
    private let repository: CharacterRepositoryContract

    init(repository: CharacterRepositoryContract) {
        self.repository = repository
    }

    func execute(name: String) async throws -> [CharacterModel] {
        // Sorry for this but I can't use getCharactersByFilter from the library
        let characters = try await repository.getAllCharacters()
        let filter = characters.filter({ $0.name.contains(name) })
        
        return filter
    }
}
