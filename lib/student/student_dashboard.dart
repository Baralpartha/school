import 'package:flutter/material.dart';

import '../home/UserProfileScreen.dart';

class StudentDashboard extends StatelessWidget {
  final Map<String, dynamic> user;

  StudentDashboard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Dashboard',
          style: TextStyle(
            color: Colors.white, // Set title text color to white
          ),
        ),
        backgroundColor: Colors.teal, // Set AppBar background color
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfileScreen(user: user)),
              );
            },
            color: Colors.white, // Set icon color to white for better contrast
          ),
        ],
      ),

      body: Center(
        child: Text('Welcome, ${user['name']}!'), // Adjust to your user data format
      ),
    );
  }
}
