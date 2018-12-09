# Post App Example With Rx

### Instalation

Dependencies in this project are provided via Cocoapods. Please install all dependecies with [Pods][1]

`
pod install
`

#### Infrastructure 


The `Infrastructure` is basically what the App is about and what use cases contains, divided on Entities, UseCases and dataSources. It just depends on Providers Modules (NetworkProvider)

#### NetworkProvider

The `NetworkProvider` is a very basic network layer provider.

#### postsApp
It is the main of the `Application` is responsible for delivering information to the user and handling user input. It contains the Scenes which will implement our delivery Pattern or architecture design.

##### Scenes
It is the main presentation layer. It has been used an MVVM, because it is a pattern that fits with Reactive paradigm.


## Detail 
 
To enforce modularity, `Infrastructure`, `NetworkProvider` and `postsApp` are separate targets in the App, which allows us to take advantage of the `internal` access layer in Swift to prevent exposing of types that we don't want to expose.

#### Infrastructure

Entities are implemented as Swift value types, implementing the Codable protocol to parse directly from json decoder

UseCases are protocols which do a specific thing. In our case Comments and Posts use cases where:

    - Comments Retrieve and Save (Save is not calling the Network because of its lack of implementation on Server)
    - Posts just Retrieve data

#### NetworkProvider

The NetworkProvider just accepts a request with an HTTPMethod (overriden caused to be other modules only dependant on this module) with an URL, Params and Headers, and returns a generic type which is inherited from the context, making not neccessary to provide the Type as a variable.


#### postsApp

In the current project, `Application` is implemented with the [MVVM](https://en.wikipedia.org/wiki/Model–view–viewmodel) pattern and heavy use of [RxSwift](https://github.com/ReactiveX/RxSwift), which makes binding very easy.

[1]###Pods
* [RxSwift](https://github.com/ReactiveX/RxSwift)
* [RxAlamofire](https://github.com/RxSwiftCommunity/RxAlamofire)


### Modularization

The corner stone of **Clean Architecture** is modularization, as you can hide implementation detail under `internal` access layer. 

### TODO:

* add tests 

### Links
* [ViewModel](https://medium.com/@azamsharp/mvvm-in-ios-from-net-perspective-580eb7f4f129)
* [Clean Architecture - RXSwift](https://medium.com/@rezafarahani/clean-architecture-with-rxswift-salt-f79abe547e32)

