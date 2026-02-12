# Joinln 📍

**See the plan. Join the moment.**

Joinln is a map-first social planning application built with Flutter. It allows users to discover real-time social plans happening around them on an interactive map, request to join, and connect with others.

## ✨ Features

*   **🗺️ Map-First Interface**: View plans as pins on a full-screen Google Map.
*   **📱 Phone Authentication**: Secure login via SMS using Firebase Auth.
*   **📍 Location-Based**: Request specific plans based on your real-time location.
*   **📅 Plan Management**: Create and view details of social gatherings.
*   **💬 Chat (MVP)**: Basic UI for 1-on-1 messaging with plan hosts.
*   **🔌 Offline Support**: Monitors internet connectivity and alerts the user when offline.

## 🛠️ Tech Stack

*   **Framework**: [Flutter](https://flutter.dev/)
*   **Language**: Dart
*   **Backend**: Firebase (Auth, Firestore)
*   **Maps**: Google Maps SDK for Flutter
*   **State Management**: `provider`
*   **Architecture**: Clean Architecture (Feature-based folder structure)

## 🚀 Getting Started

### Prerequisites
*   Flutter SDK installed.
*   A Firebase Project.
*   A Google Cloud Project with Maps SDK for Android enabled.

### Installation

1.  **Clone the repository**
    ```bash
    git clone https://github.com/yourusername/joinln.git
    cd joinln
    ```

2.  **Install Dependencies**
    ```bash
    flutter pub get
    ```

3.  **🔑 Configuration (CRITICAL)**
    This project relies on native cloud services. You **must** add your own keys for it to run.

    *   **Firebase**:
        *   Download `google-services.json` from your Firebase Console.
        *   Place it in: `android/app/google-services.json`.
        *   *Note: Ensure "Phone Auth" is enabled in your Firebase Console authentication settings.*

    *   **Google Maps**:
        *   Get an API Key from Google Cloud Console.
        *   Open `android/app/src/main/AndroidManifest.xml`.
        *   Replace `YOUR_API_KEY_HERE` with your actual key.

4.  **Run the App**
    ```bash
    flutter run
    ```

## 📂 Project Structure

```
lib/
├── core/             # Shared utilities (Theme, Constants, Network)
├── features/         # Feature modules (Auth, Map, Plans, Profile, Chat)
│   ├── auth/         # Login, OTP, Onboarding
│   ├── map/          # Home Map Screen & Pins
│   └── ...
├── services/         # External service wrappers (AuthService, FirestoreService)
└── main.dart         # Entry point
```

## 📸 Screenshots

*(Add your screenshots here)*

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
