import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'screens/login_screen.dart'; // Memastikan masuk halaman login dulu

void main() async {
  // Memastikan inisialisasi widget Flutter selesai sebelum mengakses sistem native (seperti kamera)
  WidgetsFlutterBinding.ensureInitialized();
  
  CameraDescription? firstCamera;

  try {
    // Mengambil daftar kamera yang tersedia di perangkat
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      firstCamera = cameras.first;
    }
  } catch (e) {
    print("Sistem Kamera tidak mendeteksi hardware (Web/Simulator tanpa izin): $e");
  }

  runApp(BimbelApp(camera: firstCamera));
}

class BimbelApp extends StatelessWidget {
  final CameraDescription? camera;

  const BimbelApp({super.key, this.camera});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bimbel Modern',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF4A148C),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6A1B9A),
          surface: const Color(0xFFF8F9FE), // Menggunakan properti terbaru 'surface'
        ),
        // Kustomisasi global font untuk kesan lebih premium
        fontFamily: 'Roboto', 
      ),
      // Diarahkan ke LoginScreen terlebih dahulu agar alur masuk aplikasi benar
      home: LoginScreen(camera: camera),
    );
  }
}