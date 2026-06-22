# Currency Converter 🪙

A Flutter application that fetches live exchange rates, performs currency conversions, and stores conversion history locally.

---

## Features

### Currency Conversion

- Convert between currencies using real-time exchange rates.
- Input validation for amount values.
- Currency selection with reusable picker components.
- Indicative exchange rate display.
- Swap base and target currencies.

### Conversion History

- Persist conversion history locally.
- History survives app restarts.
- Delete individual history records.
- Clear all conversion history.

### User Experience

- Loading and error states.
- Responsive layout for phones and tablets.
- Light and dark themes.
- Reusable widgets and centralized design system.

---

## Screens

### Home Screen

- Enter amount.
- Select source currency.
- Select target currency.
- View converted result.
- Save conversion automatically.

### History Screen

- View all previous conversions.
- Delete individual records.
- Clear all records.

### Settings Screen

- Toggle dark mode.

---

## Tech Stack

### State Management

- Cubit / BLoC

### Networking

- Dio

### Dependency Injection

- GetIt

### Local Storage

- SQLite
- SharedPreferences

### Architecture

- Clean Architecture

---

## Architecture

The project follows **Clean Architecture**, separating responsibilities into three layers:

### Data Layer

Responsible for:

- API communication.
- Local storage.
- Model definitions.
- Repository implementations.

### Domain Layer

Responsible for:

- Business logic.
- Use cases.
- Repository contracts.

### Presentation Layer

Responsible for:

- UI.
- Cubits and states.
- Screens and reusable widgets.

---

## Project Structure

```text
lib
├── core
│
├── features
│   ├── home
│   │   ├── data
│   │   ├── domain
│   │   └── presentation
│   │
│   ├── history
│   │   ├── data
│   │   ├── domain
│   │   └── presentation
│   │
│   └── settings
│       ├── data
│       ├── domain
│       └── presentation
│
├── app.dart
└── main.dart
```

---

## Design System

The application uses a centralized design system containing:

### Colors

- Centralized color palette.
- Support for light and dark themes.

### Typography

- Montserrat font family.
- Shared text styles.

### Reusable Components

Examples include:

- Currency picker bottom sheet.
- History card.
- Custom snackbars.
- Input rows.
- List components.
- App bar theme.
- Text theme.

---

## API

The application uses:

**Frankfurter API**

- No API key required.
- Provides live exchange rates.
- Simple and reliable REST API.

Example:

```text
https://api.frankfurter.app
```

---

## Local Storage

### SQLite

Used for:

- Saving conversion history.
- Retrieving previous conversions.
- Deleting records.
- Clearing history.

### SharedPreferences

Used for:

- Persisting dark mode preference.

---

## Error Handling

The project uses:

- `ApiResult`
- `ApiErrorHandler`

to provide:

- Success states.
- Error states.
- Consistent exception handling.

---

## Dependency Injection

Dependency injection is implemented using **GetIt**, making components easier to:

- Maintain.
- Test.
- Replace.

---

## State Management

The application uses **Cubit** for state management.

### CurrencyCubit

Responsible for:

- Fetching exchange rates.
- Performing conversions.
- Saving conversion records.

### HistoryCubit

Responsible for:

- Loading history.
- Deleting records.
- Clearing all history.

### SettingsCubit

Responsible for:

- Managing dark mode.

---

## Setup Instructions

### 1. Clone the Repository

```bash
git clone <repository-url>
```

### 2. Navigate to the Project

```bash
cd currency_converter
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Run the Application

```bash
flutter run
```

---

## Requirements

- Flutter latest stable channel
- Dart SDK compatible with the installed Flutter version

---

## Build APK

```bash
flutter build apk
```

---

## Design Decisions

### Why Clean Architecture?

To provide:

- Separation of concerns.
- Scalability.
- Maintainability.
- Easier testing.

### Why Cubit?

Cubit offers:

- Simplicity.
- Predictable state management.
- Less boilerplate than full Bloc.

### Why SQLite?

SQLite provides:

- Persistent storage.
- Fast queries.
- Offline access.
- Easy integration with Flutter.

---

## Optional Features Implemented

- ✅ Dark mode support.
- ✅ Delete individual history entries.
- ✅ Clear all conversion history.
- ✅ Responsive layout.
- ✅ Reusable widget library.

---

## AI Usage Note

AI tools were used during development.

### Tools Used

- **Google Gemini**
- **ChatGPT**

### Usage

AI assistance was used for:

- Architecture discussions.
- Reviewing code structure.
- Debugging issues.
- Exploring alternative implementations.
- Improving documentation.

### Verification

All generated suggestions and code snippets were manually reviewed, adapted when necessary, and tested to ensure correctness and compliance with the project requirements.
