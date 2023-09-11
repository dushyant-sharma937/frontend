# Notes App 

This is a Flutter front-end notes app that allows users to create, modify, and delete notes. It uses Firebase for authentication and MongoDB as the database, with a Node.js backend. This README will guide you through the setup and running of the application.

## Prerequisites

Before you begin, ensure you have the following installed on your system:

- Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
- Node.js: [Installation Guide](https://nodejs.org/)
- MongoDB: [Installation Guide](https://docs.mongodb.com/manual/installation/)
- Firebase Project: [Firebase Console](https://console.firebase.google.com/)

## Getting Started

1. Clone the repository to your local machine:

   ```bash
   git clone https://github.com/yourusername/flutter-notes-app.git
   ```

2. Change to the project directory:

   ```bash
   cd flutter-notes-app
   ```

3. Install Flutter dependencies:

   ```bash
   flutter pub get
   ```

4. Install Node.js server dependencies:

   ```bash
   cd server
   npm install
   ```

5. Configure Firebase:

   - Create a Firebase project in the [Firebase Console](https://console.firebase.google.com/).
   - Go to Project Settings and add a new web app to get the Firebase configuration keys.
   - Copy the Firebase configuration object from the Firebase Console and replace it in `lib/services/firebase_service.dart` in the Flutter app:

     ```dart
     const firebaseConfig = {
       apiKey: "YOUR_API_KEY",
       authDomain: "YOUR_AUTH_DOMAIN",
       projectId: "YOUR_PROJECT_ID",
       storageBucket: "YOUR_STORAGE_BUCKET",
       messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
       appId: "YOUR_APP_ID",
     };
     ```

6. Configure MongoDB:

   - Start your MongoDB server.
   - Create a new MongoDB database and collection for this app.

7. Configure Node.js server:

   - Rename the `config.example.js` file in the `server` directory to `config.js`.
   - Update the MongoDB connection URI in `config.js` to point to your MongoDB database.

8. Start the Node.js server:

   ```bash
   cd server
   node server.js
   ```

9. Run the Flutter app:

   ```bash
   flutter run
   ```

## Usage

1. Register or log in using Firebase authentication.

2. Add, modify, or delete notes as needed through the Flutter app.

## Contributing

Feel free to contribute to this project by opening issues or submitting pull requests. Please follow the [code of conduct](CODE_OF_CONDUCT.md) and [contribution guidelines](CONTRIBUTING.md).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Thanks to the Flutter, Node.js, Firebase, and MongoDB communities for their excellent documentation and support.

---

Happy note-taking with your Flutter Notes App! If you have any questions or encounter any issues, please don't hesitate to reach out for assistance.
