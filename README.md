# pixelverse_clone

Source Code for Full Stack Social Media App - Works on Android & iOS!
A replacement for Twitter!

# Features
Sign Up With Email, Password
Sign In With Email, Password
Tweeting Text


# Tech Stack
Server: Appwrite Auth, Appwrite Storage, Appwrite Database, Appwrite Realtime

Client: Flutter, Riverpod

# Important Files/Folders
   Reusabe API files stored in lib/apis. This is where Riverpod providers are setup and workin in conjuction with controllers spread throughout the project. 
   /.../constants/appwrite_constants.dart

Regarding /.../constants/appwrite_constants.dart
Without a an exact copy of the Docker images, to access Appwrite DB and update values, the projectId, usersCollection, and tweetsCollection need to be configured to match users own console and database. 
The endPoint setup is for Macbook iPhone emulators. Local IP/terminal command to route IP and localhost are necessary for Android emulators/devices.


Future features and tech debt:
Currently other searching for users, a profile page, and a logout feature need implementation for a complete application. However, users collection ID and auth API is already setup, and the project DB is scalable to allow features without excess coupling. 
Color (still wworks) is deprecated and should be replaced with ColorFilter.

