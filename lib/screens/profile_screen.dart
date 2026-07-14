import 'package:flutter/material.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  final String userEmail;

  const ProfileScreen({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text('Profil Saya', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFF4A148C),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Avatar Bulat Premium
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: const Color(0xFFE1BEE7),
                child: const Icon(Icons.person_rounded, size: 60, color: Color(0xFF4A148C)),
              ),
            ),
            const SizedBox(height: 20),
            
            // Detail Informasi Akun
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.email_rounded, color: Color(0xFF7B1FA2)),
                      title: const Text('Email Aktif', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      // PERBAIKAN DI SINI: Menggunakan Colors.black dengan alpha modern agar tidak eror
                      subtitle: Text(
                        userEmail, 
                        style: TextStyle(
                          fontSize: 16, 
                          fontWeight: FontWeight.bold, 
                          color: Colors.black.withValues(alpha: 0.85),
                        ),
                      ),
                    ),
                    const Divider(),
                    const ListTile(
                      leading: Icon(Icons.verified_user_rounded, color: Colors.green),
                      title: Text('Status Akun', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      subtitle: Text('Siswa Terverifikasi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            
            // Tombol Logout
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(54),
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              icon: const Icon(Icons.logout_rounded, color: Colors.white),
              label: const Text('Keluar dari Akun', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}