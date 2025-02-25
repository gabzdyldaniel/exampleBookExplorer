//
//  Created with ❤️ by Daniel Gabzdyl.

import Swinject


class RemoteDataSourceAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(VolumeDataSource.self) { resolver in
            VolumeDataSourceRemote()
        }
    }
}
