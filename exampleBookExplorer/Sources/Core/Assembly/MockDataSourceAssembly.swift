//
//  Created with ❤️ by Daniel Gabzdyl.

import Swinject


class MockDataSourceAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(VolumeDataSource.self) { resolver in
            VolumeDataSourceMock()
        }
    }
}
