import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TeachersPage extends StatefulWidget {
  const TeachersPage({super.key});

  @override
  _TeachersPageState createState() => _TeachersPageState();
}

class _TeachersPageState extends State<TeachersPage> {
  final String apiUrl = 'http://localhost:3000/teachers';
  List<Map<String, dynamic>> teachers = [];
  bool isLoading = true;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchTeachers();
  }

  Future<void> fetchTeachers() async {
    setState(() => isLoading = true);

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          teachers = List<Map<String, dynamic>>.from(json.decode(response.body));
        });
      } else {
        showError('Failed to fetch teachers. Please try again later.');
      }
    } catch (e) {
      showError('Error fetching teachers: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> addTeacher() async {
    final String firstName = firstNameController.text.trim();
    final String lastName = lastNameController.text.trim();
    final String email = emailController.text.trim();
    final String department = departmentController.text.trim();
    final String phone = phoneController.text.trim();

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        department.isEmpty ||
        phone.isEmpty) {
      showError('Please fill all fields.');
      return;
    }

    try {
      final newTeacher = {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'department': department,
        'phone': phone,
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(newTeacher),
      );

      if (response.statusCode == 201) {
        fetchTeachers();
        Navigator.pop(context);
      } else {
        showError('Failed to add teacher.');
      }
    } catch (e) {
      showError('Error adding teacher: $e');
    }
  }

  Future<void> updateTeacher(String id) async {
    final String firstName = firstNameController.text.trim();
    final String lastName = lastNameController.text.trim();
    final String email = emailController.text.trim();
    final String department = departmentController.text.trim();
    final String phone = phoneController.text.trim();

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        department.isEmpty ||
        phone.isEmpty) {
      showError('Please fill all fields.');
      return;
    }

    try {
      final updatedTeacher = {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'department': department,
        'phone': phone,
      };

      final response = await http.put(
        Uri.parse('$apiUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(updatedTeacher),
      );

      if (response.statusCode == 200) {
        fetchTeachers();
        Navigator.pop(context);
      } else {
        showError('Failed to update teacher.');
      }
    } catch (e) {
      showError('Error updating teacher: $e');
    }
  }

  Future<void> deleteTeacher(String id) async {
    try {
      final response = await http.delete(Uri.parse('$apiUrl/$id'));
      if (response.statusCode == 200) {
        fetchTeachers();
      } else {
        showError('Failed to delete teacher.');
      }
    } catch (e) {
      showError('Error deleting teacher: $e');
    }
  }

  void showTeacherDialog({Map<String, dynamic>? teacher}) {
    final isEditing = teacher != null;

    if (isEditing) {
      firstNameController.text = teacher?['first_name'] ?? '';
      lastNameController.text = teacher?['last_name'] ?? '';
      emailController.text = teacher?['email'] ?? '';
      departmentController.text = teacher?['department'] ?? '';
      phoneController.text = teacher?['phone'] ?? '';
    } else {
      firstNameController.clear();
      lastNameController.clear();
      emailController.clear();
      departmentController.clear();
      phoneController.clear();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blue.shade800, // Changed to match the color from RoomsPage
          title: Text(isEditing ? 'Edit Teacher' : 'Add Teacher', style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: firstNameController,
                  decoration: InputDecoration(labelText: 'First Name', labelStyle: TextStyle(color: Colors.white)),
                  style: TextStyle(color: Colors.white),
                ),
                TextField(
                  controller: lastNameController,
                  decoration: InputDecoration(labelText: 'Last Name', labelStyle: TextStyle(color: Colors.white)),
                  style: TextStyle(color: Colors.white),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email', labelStyle: TextStyle(color: Colors.white)),
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white),
                ),
                TextField(
                  controller: departmentController,
                  decoration: InputDecoration(labelText: 'Department', labelStyle: TextStyle(color: Colors.white)),
                  style: TextStyle(color: Colors.white),
                ),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(labelText: 'Phone', labelStyle: TextStyle(color: Colors.white)),
                  keyboardType: TextInputType.phone,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () => isEditing
                  ? updateTeacher(teacher!['id'])
                  : addTeacher(),
              child: Text(isEditing ? 'Update' : 'Add'),
            ),
          ],
        );
      },
    );
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message, style: TextStyle(color: Colors.white)), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teachers', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue, // Matching color with RoomsPage
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade800, // Updated color
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : teachers.isEmpty
                ? const Center(
                    child: Text(
                      'No teachers available. Add a new teacher!',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  )
                : ListView.builder(
                    itemCount: teachers.length,
                    itemBuilder: (context, index) {
                      final teacher = teachers[index];
                      return Card(
                        color: Colors.blue.shade600.withOpacity(0.8), // Matching card color
                        child: ListTile(
                          title: Text('${teacher['first_name']} ${teacher['last_name']}', style: TextStyle(color: Colors.white)),
                          subtitle: Text(
                              'Email: ${teacher['email']}\nDepartment: ${teacher['department']}\nPhone: ${teacher['phone']}',
                              style: TextStyle(color: Colors.white)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.white),
                                onPressed: () => showTeacherDialog(teacher: teacher),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.white),
                                onPressed: () => deleteTeacher(teacher['id']),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue, // Matching floating button color
        onPressed: () => showTeacherDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
