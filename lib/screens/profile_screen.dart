import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../data/user_session.dart'; 

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text("Profil Saya"), backgroundColor: Colors.purple, foregroundColor: Colors.white),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const CircleAvatar(radius: 60, backgroundColor: Colors.purple, child: Icon(Icons.person, size: 60, color: Colors.white)),
            const SizedBox(height: 15),
            const Text("Mahasiswa Smart Bimbel", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            
            
            Text(UserSession.loggedInEmail ?? "Guest@mail.com", style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),

            _buildDetailTile(Icons.email, "Email Terdaftar", UserSession.loggedInEmail ?? "-"),
            _buildDetailTile(Icons.lock, "Kata Sandi (Hashed)", "********"), 
            _buildDetailTile(Icons.security, "Status Akun", "Terverifikasi"),
            
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                  onPressed: () {
                    UserSession.clearSession(); 
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const LoginScreen()));
                  },
                  child: const Text("LOGOUT"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailTile(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.purple),
      title: Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      subtitle: Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }
}