# Project Title

App to display unicorn like cute-dogs 🐶


## Getting Started

We uses these apis to fetch data
```
GET 'https://dog.ceo/api/breeds/list'
GET 'https://dog.ceo/api/breed/{name}/images'
```

- The app uses: Storyboard, UITableViewController, UICollectionViewController
because its a simple project.

### Prerequisites

🖥, cocoapods, xcode, swift 4

### Installing

pod install

### Steps Done

```
1) Created Project dog-api
2)Pod Initialized
3)Podfiles
```

### Pods
- pod 'Alamofire', '~> 4.5'
- pod 'AlamofireNetworkActivityLogger', '~> 2.0'
- pod 'AlamofireObjectMapper', '~> 5.0'
- pod 'ObjectMapper', '~> 3.0'
- pod 'Kingfisher', '~> 4.0'
- pod 'PKHUD', '~> 5.0'
- pod 'Agrume'
- pod 'SwiftLint'
- pod 'EmptyKit'

#### Why?

**Alamofire**: Easy to use networking
**AlamofireNetworkActivityLogger**: Display the networkis logs on your console
**AlamofireObjectMapper**: Helps alamo mapping json to objects using object mapper
**ObjectMapper**: Simple JSON Object mapping written in Swift
**Kingfisher**: A lightweight, pure-Swift library for downloading and caching images from the web. (Manges async downloads, cache on memory and disk, activity while downloading)
**PKHUD**: A Swift based reimplementation of the Apple HUD (Volume, Ringer, Rotation,…)
**Agrume**: Image Previewer, has zoom too.
**SwiftLint**: A tool to enforce Swift style and conventions
**EmptyKit**: Swift library for displaying emptyView whenever the view(tableView/collectionView) has no content to display, displays image, label, button that retries the network call.

### SwiftLint Rules Used
```
disabled_rules: # rule identifiers to exclude from running
- force_cast
- force_try
- line_length
excluded: # paths to ignore during linting. Takes precedence over `included`.
- Pods
opt_in_rules: # some rules are only opt-in
- empty_count
```

### Steps Done

```
4) Models Created, as well as the the Api Responses
- Models: Dog & Breed
- Response Models: DogsResponse & BreedsResponse
5) Transport Security added to only use https to Dog CEO to the Info.plist
6) Added ClientManager to handle the api calls, using object mapping for ease
7) Controller Added for getting list, and displaying the images
8) Workers added to call the api and comunicate with the controllers
9) Folders Structure Created/Modified
10) LaunchScreen added to display DogCeo Image
11) Assets added
10) Swiftlint autocorrect applied
```


