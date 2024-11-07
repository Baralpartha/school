import 'package:flutter/material.dart';

import '../login/sign_out_dialog.dart';  // Import the login screen

class UserProfileScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  UserProfileScreen({required this.user});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Name: ${widget.user['user_name'] ?? 'N/A'}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Email: ${widget.user['email'] ?? 'N/A'}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Mobile No: ${widget.user['mobile_no'] ?? 'N/A'}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            if (widget.user['admission_no'] != null)
              Text(
                'Admission No: ${widget.user['admission_no']}',
                style: TextStyle(fontSize: 18),
              ),
            /*if (widget.user['staff_no'] != null)
              Text(
                'Staff No: ${widget.user['staff_no']}',
                style: TextStyle(fontSize: 18),
              ),*/
            if (widget.user['student_id'] != null)
              Text(
                'Student ID: ${widget.user['student_id']}',
                style: TextStyle(fontSize: 18),
              ),
           /* if (widget.user['teacher_id'] != null)
              Text(
                'Teacher ID: ${widget.user['teacher_id']}',
                style: TextStyle(fontSize: 18),
              ),*/
          ],
        ),
      ),
      floatingActionButton: Padding(

        padding: const EdgeInsets.only(bottom: 16.0),
        child: Container(
          width: 150.0,
          height: 50.0,
          child: FloatingActionButton(
            onPressed: () => showSignOutDialog(context),  // Call the dialog function
            child: Text(
              'Sign Out',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.teal,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
