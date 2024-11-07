import 'package:flutter/material.dart';

import '../home/UserProfileScreen.dart';

class AddResultScreen extends StatelessWidget {
  final Map<String, dynamic> user;

  AddResultScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Result submission',
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

      body: Center(child: Text('Result Form for ${user['name']}')), // Example usage
    );
  }
}
