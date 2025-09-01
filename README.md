# 🐶 DogBreedsApp

An iOS app built with **SwiftUI**, **SwiftData**, and **The Composable Architecture (TCA)** that explores dog breeds using [The Dog API](https://thedogapi.com/).  
This project was developed as part of a coding challenge.

---

## ✨ Features

- 📋 **Browse Dog Breeds**: Grid of breeds.  
- 🔍 **Search Breeds**: Search by name with detailed results (name, group, origin).  
- 📖 **Breed Details**: View name, image, group, origin, and temperament.  
- 🔄 **Tab Navigation**: Tab bar to switch between list and search.
- 🛠️ **Error Handling**: Graceful handling of API/network errors.

---

## 🗒️ TODO

- **Browse Dog Breeds**: Pagination, switch between list/grid.
- **Search Breeds**: Pagination.
- **Offline Ready**: SwiftData integration for caching results locally.
- **UI Tests**

---

## 🧩 Architecture

This project follows **The Composable Architecture (TCA)** pattern:

```
DogBreedsApp/
├── Sources/
│   ├── App/              # App entry, root reducer, tab navigation
│   ├── Core/             # Models, services, persistence, utils
│   ├── Features/         # Screens: List, Search, Detail
│   └── Resources/        # Assets, preview data
├── Tests/                # Unit tests for reducers & core logic
└── UITests/              # UI tests for navigation & flows
```

- **TCA** → Feature-first modularization, predictable state management.  
- **SwiftData** → Persistence layer for offline caching.  
- **SwiftUI** → Declarative UI for list, grid, search, and detail views.  

---

## 🚀 Getting Started

### Requirements
- Xcode 16+
- iOS 18+
- Swift 5.10+

### Setup
1. Clone the repo:
   ```sh
   git clone https://github.com/marcvitbr/DogBreedsApp.git
   cd DogBreedsApp
   ```
2. Open the project in Xcode:
   ```sh
   open DogBreedsApp.xcodeproj
   ```
3. Build & run on iOS Simulator or a device.

---

## 🧪 Tests

- **Unit Tests**: Reducers and API clients under `Tests/`.

- Run all tests with:
  ```sh
  xcodebuild test -scheme DogBreedsApp -destination 'platform=iOS Simulator,name=iPhone 16'
  ```

---

## 📦 Dependencies

- [The Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture)  
- [SwiftData](https://developer.apple.com/documentation/swiftdata) (built-in)  
- [The Dog API](https://thedogapi.com/)  

---

## 📌 Notes

- This app was built using a **test-first approach (TDD)**.  
- Several commits document the incremental steps of development.  
- The focus is on **code quality and architecture**, not UI polish.

---

## 📄 License

This project is provided as part of a coding challenge.  
