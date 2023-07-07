
public struct DependencyInversionHelper {
    var dependencies = [String: AnyObject]()
    static var shared = DependencyInversionHelper()
    
    public static func register<T>(_ type: T.Type, instance: T) {
        shared.register(T.self, instance: instance)
    }
    
    public static func resolve<T>() -> T {
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
public struct Resolver<T> {
    public var wrappedValue: T
    
    public init() {
        wrappedValue = DependencyInversionHelper.resolve()
    }
}
