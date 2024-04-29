protocol GetCharactersByPageNameUseCaseContract {
    func execute(by pageName: Int) async throws -> [CharacterModel]
}

struct GetCharactersByPageNameUseCase: GetCharactersByPageNameUseCaseContract {
    private let repository: CharacterRepositoryContract

    init(repository: CharacterRepositoryContract) {
        self.repository = repository
    }

    func execute(by pageName: Int) async throws -> [CharacterModel] {
        try await repository.getCharacters(by: pageName)
    }
}
