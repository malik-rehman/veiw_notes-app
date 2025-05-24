## 🔥 Firebase Integration in Flutter Project

This project uses **Firebase** to store user-generated notes in Firestore.

### 📦 Firebase Services Used

- **Cloud Firestore** – to store and retrieve notes in real-time.
- *(Optional: Firebase Authentication, if you plan to add login/signup)*

---

### 🔧 Firebase Setup Instructions

1. Go to [https://console.firebase.google.com](https://console.firebase.google.com) and create a new project.
2. Click **"Add App"** and select **Flutter**.
3. Follow the steps to download the `google-services.json` file and place it in `android/app/`.
4. Enable **Cloud Firestore** from the Firebase Console.
5. Update your **Firestore Rules** to allow reads/writes (for testing):

   ```js
   rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents {
       match /{document=**} {
         allow read, write: if true;
       }
     }
   }
