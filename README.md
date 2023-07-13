# DependencyInversionHelper

An awesome and easy library to deal with Dependency Inversion in Swift!

Instalation:
The way of installing DependencyInversionHelper is via the Swift Package Manager (Xcode 12 or higher).

1. In Xcode, open your project and navigate to File → Swift Packages → Add Package Dependency...
2. Paste the repository URL (https://github.com/DarioSantor/DependencyInversionHelper.git) and click Next.
3. For Rules, select Version (Up to Next Minor) and click Next.
4. Click Finish.

Usage:
This package has two functions:

* register()
* resolve()

In a practical example we have a protocol and a class that implements it:

Example:
``` swift

protocol DoSomethingProtocol {
    func printSomething()
}

class DoSomething: DoSomethingProtocol {
    func printSomething() {
        print("HELLO WORLDSSSSS!")
    }
}
```


In AppDelegate swift file we should **import** DependencyInversionHelper. Then at the application() function we should **register** the Protocol with the correspondent Class instance.

Example:
``` swift
import UIKit
import DependencyInversionHelper

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        DependencyInversionHelper.register(DoSomethingProtocol.self, instance: DoSomething())

        return true
    }
}
```

Then, anywhere you need to follow the protocol, you should import the DependencyInversionHelper and then call, with the @Resolvor property wrapper, the protocol you want to use.

Example:
``` swift
import UIKit
import DependencyInversionHelper

class MyViewModel {

    @Resolver<DoSomethingProtocol> var doSomething
    
    init() {
        doSomething.printSomething()
    }
}
```
