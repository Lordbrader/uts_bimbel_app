import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/class_list_screen.dart';
import 'screens/registration_form_screen.dart';
import 'screens/my_classes_screen.dart';
import 'screens/profile_screen.dart';

void main() => runApp(const SmartBimbelApp());

class SmartBimbelApp extends StatelessWidget {
  const SmartBimbelApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple, 
        useMaterial3: true,
        fontFamily: 'Poppins'
      ),
      home: const LoginScreen(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});
  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const ClassListScreen(),
    const RegistrationFormScreen(),
    const MyClassesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Container(
          width: 450, 
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]
          ),
          child: Scaffold(
            body: IndexedStack(index: _currentIndex, children: _pages),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _currentIndex,
              selectedItemColor: Colors.purple,
              unselectedItemColor: Colors.grey,
              onTap: (i) => setState(() => _currentIndex = i),
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
                BottomNavigationBarItem(icon: Icon(Icons.edit_note), label: "Daftar"),
                BottomNavigationBarItem(icon: Icon(Icons.class_rounded), label: "Kelas"),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}