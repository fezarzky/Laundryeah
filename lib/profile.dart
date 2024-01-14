import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_laundryapp/login.dart';

class Profile extends StatelessWidget {
  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    // Get email from Firebase
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String userEmail = user?.email ?? '';

    return ProfilePage(email: userEmail); // Pass the email to ProfilePage
  }
}

class ProfilePage extends StatelessWidget {
  final String email; // Add property to store email

  const ProfilePage({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String trimmedEmail = email.split('@').first;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage(
                  'assets/Imageprofile.png'), // Replace with your profile picture path
            ),
            SizedBox(height: 20.0),
            Text(
              '$trimmedEmail',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              email,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Add logic for editing profile
                Navigator.pushNamed(context, Login.routeName);
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  // Get email from Firebase
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  String email = user?.email ?? '';

  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => ProfilePage(email: email), // Pass email to ProfilePage
      Profile.routeName: (context) => Profile(),
    },
  ));
}
