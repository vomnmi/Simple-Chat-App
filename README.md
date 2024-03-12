# Chat App

This is a Flutter-based mobile application for instant messaging, built using Firebase services for authentication and real-time database.

## Features

- User Authentication: Users can sign up and log in securely using email and password authentication provided by Firebase Authentication.
- Real-time Chat: Users can send and receive messages in real-time using Firebase Realtime Database.
- User Profile: Users can update their profile information such as name, profile picture, etc.
- Dark Mode Support: The app supports dark mode for enhanced user experience.

## Technologies Used

- **Flutter:** A UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
- **Firebase Authentication:** Provides backend services, easy-to-use SDKs, and ready-made UI libraries to authenticate users to your app.
- **Firebase Realtime Database:** A cloud-hosted NoSQL database that lets you store and sync data between your users in real-time.

## Getting Started

1. **Clone the repository:**
   git clone https://github.com/your_username/chat_app.git
2. **Set up Firebase:**

- Create a new Firebase project on the Firebase Console (https://console.firebase.google.com/).
- Enable Firebase Authentication and Realtime Database services.
- Download and add the `google-services.json` file to the `android/app` directory for Android, and `GoogleService-Info.plist` to the `ios/Runner` directory for iOS.

3. **Run the app:**
   flutter run

## Contributing

Contributions are welcome! Please follow the [contributing guidelines](CONTRIBUTING.md).

## License

This project is licensed under the [MIT License](LICENSE).
