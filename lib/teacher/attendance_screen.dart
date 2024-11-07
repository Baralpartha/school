import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:intl/intl.dart'; // make sure to import this for jsonEncode

const String apiUrl = 'http://103.106.118.10/mCampus/attendanceupdate.php';

Future<List<dynamic>> getAcademicYears(int userId) async {
  try {
    // Log the API request parameters
    print('Sending API request: action = getSession, user_id = $userId');

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'action': 'getSession',
        'user_id': userId,
      }),
    );

    // Log the complete response
    print('API Response (Academic Years): ${response.body}');
    print('Response Status: ${response.statusCode}');
    print('Response Headers: ${response.headers}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'success' && data['data'] != null) {
        return List<dynamic>.from(data['data']);
      } else {
        print('Error: ${data['message']}');
      }
    } else {
      print('Error: ${response.statusCode}');
    }
    return [];
  } catch (e) {
    print('Error fetching academic years: $e');
    return [];
  }
}

Future<List<dynamic>> getClasses(int academicId, int userId) async {
  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'action': 'getClass',
        'academic_id': academicId,
        'user_id': userId,
      }),
    );

    print('API Response (Classes): ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'success' && data['data'] != null) {
        return List<dynamic>.from(data['data']);
      }
    }
    return [];
  } catch (e) {
    print('Error fetching classes: $e');
    return [];
  }
}

Future<List<dynamic>> getSections(
    int classId, int academicId, int userId) async {
  try {
    final response = await http.post(Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'action': 'getSection',
          'class_id': classId,
          'academic_id': academicId,
          'user_id': userId,
        }));

    print('API Response (Sections): ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'success' && data['data'] != null) {
        return List<dynamic>.from(data['data']);
      }
    }
    return [];
  } catch (e) {
    print('Error fetching sections: $e');
    return [];
  }
}

Future<List<dynamic>> getAttendanceView(
    String date, int sectionId, int classId, int academicId, int userId) async {
  try {
    final response = await http.post(Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'action': 'getAttendancesView',
          'attn_date': date,
          'section_id': sectionId,
          'class_id': classId,
          'academic_id': academicId,
          'user_id': userId,
        }));

    print('API Response (Attendance View): ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'success' && data['data'] != null) {
        return List<dynamic>.from(data['data']);
      }
      print(data);
    }
    return [];
  } catch (e) {
    print('Error fetching attendance: $e');
    return [];
  }
}

class AttendanceScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  AttendanceScreen({required this.user});
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  int userId = 5742; // Example user ID
  List<dynamic> academicYears = [];
  List<dynamic> classes = [];
  List<dynamic> sections = [];
  List<dynamic> attendanceList = [];

  int? selectedAcademicId;
  int? selectedClassId;
  int? selectedSectionId;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    fetchAcademicYears();
  }

  Future<void> fetchAcademicYears() async {
    List<dynamic> result = await getAcademicYears(userId);
    print('Fetched Academic Years: $result');
    setState(() {
      academicYears = result;
      selectedAcademicId = null; // Reset selected value
      selectedClassId = null;
      selectedSectionId = null;
      classes = [];
      sections = [];
    });
  }

  Future<void> fetchClasses(int academicId) async {
    List<dynamic> result = await getClasses(academicId, userId);
    print('Fetched Classes: $result');
    setState(() {
      classes = result;
      selectedClassId = null; // Reset selected class
      selectedSectionId = null; // Reset selected section
      sections = [];
    });
  }

  Future<void> fetchSections(int classId) async {
    List<dynamic> result =
        await getSections(classId, selectedAcademicId!, userId);
    print('Fetched Sections: $result');
    setState(() {
      sections = result;
      selectedSectionId = null; // Reset selected section
    });
  }

  Future<void> fetchAttendance() async {
    if (selectedDate != null &&
        selectedSectionId != null &&
        selectedClassId != null &&
        selectedAcademicId != null) {
      List<dynamic> result = await getAttendanceView(
        selectedDate!.toIso8601String().split('T').first,
        selectedSectionId!,
        selectedClassId!,
        selectedAcademicId!,
        userId,
      );
      setState(() {
        attendanceList = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attendance')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<int>(
              decoration: InputDecoration(labelText: 'Academic Year'),
              items: academicYears.map((year) {
                return DropdownMenuItem<int>(
                  value: int.tryParse(year['ACADEMIC_ID']?.toString() ?? '0'),
                  child: Text(year['TITLE'] ?? ''),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedAcademicId = value;
                  selectedClassId = null;
                  selectedSectionId = null;
                  classes = [];
                  sections = [];
                });
                if (value != null) fetchClasses(value);
              },
              value: academicYears
                      .any((year) => year['ACADEMIC_ID'] == selectedAcademicId)
                  ? selectedAcademicId
                  : null, // Set to null if not in the list
            ),
            DropdownButtonFormField<int>(
              decoration: InputDecoration(labelText: 'Class'),
              items: classes.map((classItem) {
                return DropdownMenuItem<int>(
                  value: int.tryParse(classItem['CLASS_ID'].toString() ?? '0'),
                  child: Text(classItem['CLASS_NAME'] ?? ''),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedClassId = value;
                  selectedSectionId = null;
                  sections = [];
                });
                if (value != null) fetchSections(value);
              },
              value: classes.any(
                      (classItem) => classItem['CLASS_ID'] == selectedClassId)
                  ? selectedClassId
                  : null,
            ),
            DropdownButtonFormField<int>(
              decoration: InputDecoration(labelText: 'Section'),
              items: sections.map((section) {
                return DropdownMenuItem<int>(
                  value: int.tryParse(section['SECTION_ID'].toString() ?? '0'),
                  child: Text(section['SECTION_NAME'] ?? ''),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSectionId = value;
                });
              },
              value: sections.any(
                      (section) => section['SECTION_ID'] == selectedSectionId)
                  ? selectedSectionId
                  : null,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (date != null) {
                  setState(() {
                    selectedDate = date;
                  });
                }
              },
              child: Text(selectedDate == null
                  ? 'Pick a Date'
                  : DateFormat('yyyy-MM-dd').format(selectedDate!)),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: fetchAttendance,
              child: Text('Fetch Attendance'),
            ),
          ],
        ),
      ),
    );
  }
}
