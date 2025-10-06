# AstroDaily - iOS sample for NASA Astronomy Picture of the Day (APOD)

AstroDaily is an iOS sample that displays NASA's Astronomy Picture of the Day (APOD), supporting images and embedded videos. The project demonstrates a pragmatic architecture and testing setup suitable for exploration and discussion.

## Running the Local APOD API 

Run the local backend first, then launch the iOS app. Steps:

```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python application.py
```

Expected server output (example):

```
* Serving Flask app 'application'
 * Debug mode: off
INFO:werkzeug:WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
 * Running on all addresses (0.0.0.0)
 * Running on http://127.0.0.1:8000
 * Running on http://<LAN_IP>:8000
```

Select an appropriate base URL as needed when running the iOS app.

The app defaults to a local/mock API and does not require a NASA API key.

Local APOD API repository:
- [nasa/apod-api](https://github.com/nasa/apod-api)

## Features

### Basic Features (All Implemented)

- **Daily APOD Display**: Automatically loads and displays the current day's Astronomy Picture of the Day
- **Multi-Media Support**: Handles both images and embedded videos (e.g., October 11, 2021 APOD)
- **Date Selection**: Allows users to browse APOD for any historical date since June 16, 1995
- **Tab Bar Navigation**: Clean navigation with Today tab; History tab is display-only for future expansion
- **Intelligent Caching**: Automatic caching with fallback to cached content when network fails
- **Offline Support**: Graceful degradation using cached data when offline

### Bonus Features (All Implemented)

- **Universal Compatibility**: Optimized for both iPhone and iPad with responsive layouts
- **Orientation Support**: Full support for portrait and landscape orientations
- **Dark Mode**: Native dark mode support with system theme integration
- **Dynamic Type**: Full accessibility support with Dynamic Type scaling
- **Production Notes**: Error handling, logging, and stability features

## Architecture

### MVVM + Coordinator Pattern

The application follows a clean architecture pattern combining **MVVM (Model-View-ViewModel)** with the **Coordinator Pattern** for optimal separation of concerns and testability.

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│      View       │    │    ViewModel     │    │     Model       │
│   (SwiftUI)     │◄──►│  (Business Logic)│◄──►│   (Data Layer)  │
└─────────────────┘    └──────────────────┘    └─────────────────┘
         │                       │                       │
         │                       │                       │
         ▼                       ▼                       ▼
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Coordinator   │    │   Service Layer  │    │  Infrastructure │
│ (Navigation)    │    │  (Data Access)   │    │   (DI, Utils)   │
└─────────────────┘    └──────────────────┘    └─────────────────┘
```

### SOLID Principles Implementation

The codebase strictly adheres to SOLID principles:

- **Single Responsibility**: Each class has a single, well-defined responsibility
- **Open/Closed**: Services are protocol-based, allowing extension without modification
- **Liskov Substitution**: All implementations can be substituted for their protocols
- **Interface Segregation**: Small, focused protocols for specific functionalities
- **Dependency Inversion**: High-level modules depend on abstractions, not concretions

### Key Architectural Components

#### 1. **Presentation Layer**
- **Views**: SwiftUI-based UI components with reactive state management
- **Coordinators**: Navigation logic separated from views for better testability

#### 2. **Business Logic Layer**
- **ViewModels**: Handle presentation logic and state management using `@Published` properties
- **Services**: Protocol-based data access layer with dependency injection

#### 3. **Data Layer**
- **Models**: Clean data structures with proper validation
- **Network**: Robust HTTP client with error handling and retry logic
- **Cache**: Intelligent caching system with size limits and cleanup

#### 4. **Infrastructure Layer**
- **Dependency Injection**: Centralized service registration and resolution
- **Logging**: Structured logging with multiple levels
- **Error Handling**: Centralized error management with user-friendly messages

## Technical Implementation

### Dependency Injection Container

```swift
final class DIContainer {
    static let shared = DIContainer()
    
    func registerSingleton<T>(_ type: T.Type, factory: @escaping () -> T) {
        // Thread-safe singleton registration
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        // Type-safe service resolution
    }
}
```

### Service Layer Architecture

All services implement protocol-based design:

```swift
protocol APODServiceProtocol {
    func fetchTodaysAPOD() async throws -> APODResult
    func fetchAPOD(for date: Date) async throws -> APODResult
}

class APODService: APODServiceProtocol {
    @Injected(NetworkServiceProtocol.self) private var networkService
    @Injected(CacheServiceProtocol.self) private var cacheService
    
    // Implementation with fallback logic and caching
}
```

### Coordinator Pattern for Navigation

```swift
class AppCoordinator: BaseCoordinator {
    func showDatePicker(selectedDate: Date, onDateSelected: @escaping (Date) -> Void) {
        // Centralized navigation logic
    }
    
    func showAPODDetail(_ apod: APOD) {
        // Detail view navigation
    }
}
```

### API Usage and Fallback Policy

- API Key: No NASA API key is used by default. The app targets a local/mock API during development and does not require a NASA key. If needed, the official NASA APOD API can be used after applying for an `api_key` and updating the base URL.
- Fallback Behavior: When requesting "today's" APOD, if no data is available, the app will automatically fall back to the most recent available day within the past 30 days and display that entry. If none is available within 30 days, cached content (if any) will be shown.
- Arbitrary Date: When the user selects a specific date, the app requests that exact date. If that date has no data, it falls back day-by-day, up to 30 days, to find the most recent available entry.


## Security Considerations

The application includes basic security measures and provides a security implementation guide for potential enhancements:

### Current Security Implementation
- **Input Validation**: Basic validation for date inputs and API responses
- **Error Handling**: Safe error messages without sensitive information disclosure

### Security Enhancement Guide
A detailed security implementation guide is available in [`OWASP_Mobile_Application_Security_Implementation_Guide.md`](OWASP_Mobile_Application_Security_Implementation_Guide.md) outlining approaches based on the **OWASP Mobile Top 10**.

## Testing Strategy

### Test Coverage

The application includes extensive testing with **62 test cases** covering:

- **Unit Tests (54)**: Business logic, services, utilities, and models
- **UI Tests (8)**: User interface interactions and navigation flows
- **Integration Tests**: End-to-end service testing
- **Mock Services**: Mocked dependencies for isolated testing

### Test Categories

1. **Model Tests**: Data structure validation and parsing
2. **Service Tests**: Business logic and error handling
3. **ViewModel Tests**: State management and user interactions
4. **Coordinator Tests**: Navigation flow validation
5. **Utility Tests**: Helper functions and constants
6. **UI Tests**: User interface behavior and accessibility

## Performance Optimizations

### Image Processing
- **Intelligent Caching**: Multi-level caching strategy with size limits
- **Image Optimization**: Automatic resizing and compression
- **Memory Management**: Efficient memory usage with proper cleanup

### Network Optimization
- **Request Optimization**: Efficient API calls with proper error handling
- **Fallback Logic**: Graceful degradation with cached content
- **Timeout Management**: Appropriate timeout settings for different scenarios

### UI Performance
- **Lazy Loading**: Efficient view loading and memory management
- **State Management**: Optimized state updates with minimal re-renders
- **Accessibility**: Full Dynamic Type support without performance impact

## Accessibility Features

### Dynamic Type Support
- All text scales appropriately with user's preferred text size
- UI elements adapt to different text sizes
- Maintains usability across all accessibility settings

### Accessibility Support
- Basic accessibility labels and hints for key interactive elements
- Accessibility traits for images and buttons
- Standard iOS navigation patterns for logical flow
- Dynamic Type support for text scaling

### Dark Mode
- Native dark mode implementation
- Automatic theme switching based on system settings
- Consistent visual hierarchy in both light and dark modes

## Universal App Design

### iPhone and iPad Support
- **Responsive Layouts**: Adaptive UI that works on all screen sizes
- **Orientation Support**: Full support for portrait and landscape modes
- **Device-specific Sizing**: Font sizes and padding adapt to device type

### Adaptive UI Components
- **Tab Bar**: Optimized for both iPhone and iPad layouts
- **Navigation**: Context-appropriate navigation patterns
- **Content Display**: Efficient use of available screen space

## Requirements Compliance

### iOS 18.0+ Support
- Minimum deployment target: iOS 18.0
- Latest Swift features and APIs
- Modern iOS development practices

### No Third-Party Dependencies
- Pure Swift and iOS frameworks only
- No external libraries or dependencies
- Self-contained implementation

### Production Ready
- Error handling
- Extensive logging and monitoring
- Performance optimizations
- Basic security measures
- Accessibility compliance

## Project Structure

```
AstroDaily/
├── AstroDaily/
│   ├── AstroDailyApp.swift          # App entry point
│   ├── ContentView.swift            # Root view
│   ├── Core/
│   │   ├── DIContainer.swift        # Dependency injection
│   │   └── Coordinator.swift        # Navigation management
│   ├── Models/
│   │   ├── APODModels.swift         # Data models
│   │   ├── NetworkModels.swift      # Network models
│   │   └── ColorTheme.swift         # Theme definitions
│   ├── Services/
│   │   ├── APODService.swift        # Business logic
│   │   ├── NetworkService.swift     # HTTP client
│   │   ├── CacheService.swift       # Data persistence
│   │   └── ImageService.swift       # Image handling
│   ├── ViewModels/
│   │   └── APODViewModel.swift      # View state management
│   ├── Views/
│   │   ├── MainTabView.swift        # Tab navigation
│   │   ├── APODContentView.swift    # Main content view
│   │   ├── APODDetailView.swift     # Detail view
│   │   └── Components/              # Reusable UI components
│   └── Utils/
│       ├── Logger.swift             # Logging system
│       ├── ErrorHandler.swift       # Error management
│       └── AppConstants.swift       # Application constants
├── AstroDailyTests/                 # Unit tests
├── AstroDailyUITests/              # UI tests
└── Documentation/
    ├── Architecture_Diagram.md      # Architecture documentation
    └── OWASP_Mobile_Application_Security_Implementation_Guide.md
```

## Future Enhancements

The architecture is designed for easy extension with potential future features:

### Security Enhancements (OWASP Mobile Top 10)
1. **M1 - Improper Platform Usage**: Enhanced platform security configurations
2. **M2 - Insecure Data Storage**: Advanced data encryption and secure storage
3. **M3 - Insecure Communication**: Enhanced network security with custom URLSession
4. **M4 - Insecure Authentication**: Biometric authentication and strong auth mechanisms
5. **M5 - Insufficient Cryptography**: Data protection with encryption
6. **M6 - Insecure Authorization**: Enhanced access control and authorization
7. **M7 - Client Code Quality**: Code obfuscation and production build protection
8. **M8 - Code Tampering**: Integrity checking and tamper detection mechanisms
9. **M9 - Reverse Engineering**: Anti-debugging and code protection measures
10. **M10 - Extraneous Functionality**: Feature flags and runtime security controls

### Feature Enhancements
- **GenAI Integration**: Content enhancement and intelligent analysis
- **Performance Optimization**: C language integration for critical paths

## Contributing

This is a production-ready implementation demonstrating modern iOS development best practices. The codebase serves as a reference for:

- Clean Architecture implementation
- SOLID principles application
- Basic security measures with enhancement guide
- Testing strategies
- Accessibility compliance
- Performance optimization techniques

---

**Built with Swift and modern iOS development practices**
