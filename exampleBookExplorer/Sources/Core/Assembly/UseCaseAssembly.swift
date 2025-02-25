//
//  Created with ❤️ by Daniel Gabzdyl.

import Swinject


class UseCaseAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(GetBooksUseCase.self) { resolver in
            BookUseCase.GetBooks(dataSource: inject())
        }
    }
}
