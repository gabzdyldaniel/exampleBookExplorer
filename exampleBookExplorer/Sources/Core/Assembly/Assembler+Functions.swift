//
//  Created with ❤️ by Daniel Gabzdyl.

import Swinject


fileprivate let assembler: Assembler = {
    let container = Container()
            
    return Assembler([
        dataSourceAssembly(),
        UseCaseAssembly(),
    ], container: container)
}()

func dataSourceAssembly() -> Assembly {
    // TODO: Split into multiple configurations and use assembly according to the environment
    return RemoteDataSourceAssembly()
}

func inject<Service>(_ serviceType: Service.Type) -> Service {
    return assembler.resolver.resolve(serviceType)!
}

func inject<Service, Arg1>(_ serviceType: Service.Type, argument: Arg1) -> Service {
    assembler.resolver.resolve(serviceType, argument: argument)!
}

func inject<Service, Arg1, Arg2>(_ serviceType: Service.Type, arguments argument1: Arg1, _ argument2: Arg2) -> Service {
    assembler.resolver.resolve(serviceType, arguments: argument1, argument2)!
}

public func inject<T>() -> T {
    assembler.resolver.resolve(T.self)!
}
