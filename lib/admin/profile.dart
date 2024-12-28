import 'package:flutter/material.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  _AdminProfileScreenState createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  // Dummy data for the profile
  String name = "Admin";
  String mobile = "6754878892";
  String email = "admin45@example.com";
  String profilePicture = "https://via.placeholder.com/150"; // Placeholder URL

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Profile'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture
              CircleAvatar(
                radius: 60, // Adjust the size
                backgroundImage: NetworkImage(profilePicture),
                child: profilePicture == null
                    ? Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white,
                      )
                    : null,
              ),
              SizedBox(height: 20),
          
              // Name
              Text(
                name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
          
              // Mobile Number
              Text(
                'Mobile: $mobile',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 10),
          
              // Email
              Text(
                'Email: $email',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 20),
          
              // Edit Profile Button
              ElevatedButton(
                onPressed: () {
                  // Handle edit action (e.g., navigate to edit profile screen)
                  print('Edit Profile clicked');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, // Background color
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Edit Profile',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const AdminProfileScreen(),
    );
  }
}
