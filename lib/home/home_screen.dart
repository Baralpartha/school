import 'package:flutter/material.dart';
import '../login/login_screen.dart';
import '../student/student_dashboard.dart';
import '../teacher/attendance_screen.dart';
import '../teacher/result_submission_screen.dart';
import 'UserProfileScreen.dart';

class HomeScreen extends StatelessWidget {
  final String role;
  final Map<String, dynamic> user;

  HomeScreen({required this.role, required this.user});

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


      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          children: [
            if (role == 'student')
              _buildDashboardCard(
                context,
                'Student Profile',
                Icons.person,
                Colors.blueAccent,
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StudentDashboard(user: user)),
                  );
                },
              ),
            if (role == 'teacher') ...[
              _buildDashboardCard(
                context,
                'Attendance',
                Icons.check_circle,
                Colors.orange,
                    () {
                  // Navigate to AddAttendanceScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AttendanceScreen(user: user)),
                  );
                },
              ),
              _buildDashboardCard(
                context,
                'Marks Entry',
                Icons.mark_chat_read_outlined,
                Colors.cyan,
                    () {
                  // Navigate to AddAttendanceScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddResultScreen (user: user,)),
                  );
                },
              ),
              _buildDashboardCard(
                context,
                'Class Routine',
                Icons.schedule,
                Colors.teal,
                    () {
                  // Navigate to class routine screen
                },
              ),
             /* _buildDashboardCard(
                context,
                'Sign Out',
                Icons.exit_to_app,
                Colors.red,
                    () {
                  // Handle sign out
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()), // Navigate to login screen
                  );
                },
              ),*/

              _buildDashboardCard(
                context,
                'Fees Due Report',
                Icons.receipt,
                Colors.green,
                    () {
                  // Navigate to fees due report screen
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 40),
              SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
