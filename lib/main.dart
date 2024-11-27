// import 'package:flutter/material.dart';
// import '/auth/login_page.dart'; // Import LoginPage
// import '/auth/auth_utils.dart'; // Import authentication check
// import 'auth/register_page.dart';
// import 'room.dart'; // Import your Pages like Rooms, Teachers, etc.
// import 'teachers.dart'; // Import the TeachersPage
// import 'subjects.dart'; // Import the SubjectsPage
// import 'classes.dart'; // Import the ClassesPage
// import 'sessions.dart'; // Import the SessionsPage
// import 'students.dart'; // Import the StudentsPage
// import 'timetable.dart'; // Import the TimetablePage

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Button Navigator',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
//         useMaterial3: true,
//       ),
//       routes: {
//         '/login': (context) => const LoginPage(),
//         '/main': (context) => const HomePage(), // Home page after login
//         '/register': (context) => const RegisterPage(),
//       },
//       home: FutureBuilder<bool>(
//         future: isAuthenticated(), // Check if authenticated
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.data == true) {
//             return const HomePage(); // Show HomePage if authenticated
//           } else {
//             return const LoginPage(); // Show LoginPage if not authenticated
//           }
//         },
//       ),
//     );
//   }
// }

// // HomePage that contains your button navigation
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Home')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _buildButton(context, 'Rooms', const RoomsPage()),
//             _buildButton(context, 'Teachers', const TeachersPage()),
//             _buildButton(context, 'Subjects', const SubjectsPage()),
//             _buildButton(context, 'Classes', const ClassesPage()),
//             _buildButton(context, 'Sessions', const SessionsPage()),
//             _buildButton(context, 'Students', const StudentsPage()),
//             _buildButton(context, 'Timetable', const TimetablePage()),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildButton(BuildContext context, String title, Widget targetPage) {
//     return ElevatedButton(
//       onPressed: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => targetPage),
//         );
//       },
//       child: Text(title),
//     );
//   }
// }
// //  print('Token: $token');
import 'package:flutter/material.dart';
import '/auth/login_page.dart'; // Import LoginPage
import '/auth/auth_utils.dart'; // Import authentication check
import 'auth/register_page.dart';
import 'room.dart'; // Import your Pages like Rooms, Teachers, etc.
import 'teachers.dart'; // Import the TeachersPage
import 'subjects.dart'; // Import the SubjectsPage
import 'classes.dart'; // Import the ClassesPage
import 'sessions.dart'; // Import the SessionsPage
import 'students.dart'; // Import the StudentsPage
import 'timetable.dart'; // Import the TimetablePage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Button Navigator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routes: {
        '/login': (context) => const LoginPage(),
        '/main': (context) => const HomePage(), // Home page after login
        '/register': (context) => const RegisterPage(),
      },
      home: FutureBuilder<bool>( 
        future: isAuthenticated(), // Check if authenticated
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data == true) {
            return const HomePage(); // Show HomePage if authenticated
          } else {
            return const LoginPage(); // Show LoginPage if not authenticated
          }
        },
      ),
    );
  }
}

// HomePage that contains your button navigation
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // Center the title in the AppBar
        title: Text(
          'Home', // Title text
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold, // Make the title bold
            color: const Color.fromARGB(255, 134, 46, 202), // Set the text color to white
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB06AB3), Color(0xFF4568DC)], // Dégradé violet/bleu
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 3 buttons per row
                  crossAxisSpacing: 16.0, // Space between buttons
                  mainAxisSpacing: 16.0, // Space between rows
                  childAspectRatio: 1.0, // Aspect ratio to make buttons square
                ),
                itemCount: 7,
                itemBuilder: (context, index) {
                  // Mapping the button titles and target pages
                  final buttonData = <String, Widget>{
                    'Rooms': const RoomsPage(),
                    'Teachers': const TeachersPage(),
                    'Subjects': const SubjectsPage(),
                    'Classes': const ClassesPage(),
                    'Sessions': const SessionsPage(),
                    'Students': const StudentsPage(),
                    'Timetable': const TimetablePage(),
                  };

                  // Retrieve the title and corresponding page
                  final title = buttonData.keys.elementAt(index);
                  final targetPage = buttonData[title]!;

                  return _buildSquareButton(context, title, targetPage);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Create square button with custom style
  Widget _buildSquareButton(BuildContext context, String title, Widget targetPage) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetPage),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6A1B9A), // Violet foncé
        padding: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Corner radius for square shape
        ),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center, // Center the text inside the button
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
