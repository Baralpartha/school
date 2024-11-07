import 'dart:convert';
import 'package:http/http.dart' as http;

const String apiUrl = 'http://103.106.118.10/mCampus/attendanceupdate.php';

Future<List<dynamic>> getAcademicYears(int userId) async {
  final response = await http.post(Uri.parse(apiUrl), body: {
    'action': 'getSession',
    'user_id': userId.toString(),
  });
  final data = jsonDecode(response.body);
  return data['data'];
}

Future<List<dynamic>> getClasses(int academicId, int userId) async {
  final response = await http.post(Uri.parse(apiUrl), body: {
    'action': 'getClass',
    'academic_id': academicId.toString(),
    'user_id': userId.toString(),
  });
  final data = jsonDecode(response.body);
  return data['data'];
}

Future<List<dynamic>> getSections(int classId, int academicId, int userId) async {
  final response = await http.post(Uri.parse(apiUrl), body: {
    'action': 'getSection',
    'class_id': classId.toString(),
    'academic_id': academicId.toString(),
    'user_id': userId.toString(),
  });
  final data = jsonDecode(response.body);
  return data['data'];
}

Future<List<dynamic>> getAttendanceView(String date, int sectionId, int classId, int academicId, int userId) async {
  final response = await http.post(Uri.parse(apiUrl), body: {
    'action': 'getAttendancesView',
    'attn_date': date,
    'section_id': sectionId.toString(),
    'class_id': classId.toString(),
    'academic_id': academicId.toString(),
    'user_id': userId.toString(),
  });
  final data = jsonDecode(response.body);
  return data['data'];
}
