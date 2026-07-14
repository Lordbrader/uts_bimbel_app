import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'explorer_screen.dart';
import 'registration_form_screen.dart';
import 'my_classes_screen.dart';
import 'profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  final CameraDescription? camera;
  final String userEmail;

  const MainNavigationScreen({super.key, this.camera, required this.userEmail});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  String? _autoSelectedClass; // Menyimpan kelas pilihan dari beranda

  // Fungsi untuk berpindah tab secara terprogram dari halaman Beranda
  void pindahKeTabDaftar(String namaKelas) {
    setState(() {
      _currentIndex = 1; // Pindah ke indeks Tab Daftar
      _autoSelectedClass = namaKelas; // Set kelas otomatis
    });
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return ExplorerScreen(
          userEmail: widget.userEmail,
          onPackageSelected: pindahKeTabDaftar, // Oper fungsi navigasi
        );
      case 1:
        return RegistrationFormScreen(
          camera: widget.camera,
          selectedClassName: _autoSelectedClass, // Kirim kelas pilihan ke form
        );
      case 2:
        return const MyClassesScreen();
      case 3:
        return ProfileScreen(userEmail: widget.userEmail);
      default:
        return ExplorerScreen(userEmail: widget.userEmail, onPackageSelected: pindahKeTabDaftar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: _buildBody(),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 25),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6A1B9A).withValues(alpha: 0.15),
              blurRadius: 25,
              offset: const Offset(0, 8),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                if (index != 1) {
                  _autoSelectedClass = null; // Reset pilihan jika pindah ke tab selain daftar
                }
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFF6A1B9A),
            unselectedItemColor: const Color(0xFF9E9E9E),
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: 'Beranda'),
              BottomNavigationBarItem(icon: Icon(Icons.assignment_ind_rounded), label: 'Daftar'),
              BottomNavigationBarItem(icon: Icon(Icons.class_rounded), label: 'Kelas'),
              BottomNavigationBarItem(icon: Icon(Icons.account_circle_rounded), label: 'Profil'),
            ],
          ),
        ),
      ),
    );
  }
}