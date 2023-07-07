
public struct DependencyInversionHelper {
    var dependencies = [String: AnyObject]()
    static var shared = DependencyInversionHelper()
    
    static func register<T>(_ type: T.Type, instance: T) {
        shared.register(T.self, instance: instance)
    }
    
    static func resolve<T>() -> T {
        shared.resolve()
    }
    
    private mutating func register<T>(_ dependency: T.Type, instance: T) {
        let key = String(describing: T.self)
        dependencies[key] = instance as AnyObject
    }
    
    private func resolve<T>() -> T {
        let key = String(describing: T.self)
        let dependency = dependencies[key] as? T
        precondition(dependency != nil, "No dependency found for \(key)! must register a dependency before resolve.")
        return dependency!
    }
}

@propertyWrapper
struct Resolver<T> {
    var wrappedValue: T
    
    init() {
        wrappedValue = DependencyInversionHelper.resolve()
    }
}