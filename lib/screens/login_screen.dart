import 'package:flutter/material.dart';
import '../main.dart';
import '../data/user_session.dart'; // Import file penyimpanan

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool _isObscure = true;

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // SIMPAN DATA KE SESSION & CETAK KE DEBUG CONSOLE
      UserSession.saveUser(_emailController.text, _passController.text);

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(color: Colors.purple),
        ),
      );

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context); 
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainNavigation()),
        );
      });
    }
  }

  void _showForgotPasswordDialog(BuildContext context) {
    final TextEditingController _resetEmail = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 25, right: 25, top: 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Reset Password 🔑", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.purple)),
            const SizedBox(height: 10),
            TextField(
              controller: _resetEmail,
              decoration: InputDecoration(labelText: "Email", prefixIcon: const Icon(Icons.email_outlined), border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity, height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                onPressed: () {
                  if (_resetEmail.text.isNotEmpty) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Link reset dikirim ke ${_resetEmail.text}"), backgroundColor: Colors.green));
                  }
                },
                child: const Text("KIRIM", style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, height: double.infinity,
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF6A1B9A), Color(0xFFAD1457)])),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              margin: const EdgeInsets.symmetric(horizontal: 25),
              padding: const EdgeInsets.all(35),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(35)),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.auto_stories_rounded, size: 80, color: Colors.purple),
                    const SizedBox(height: 10),
                    const Text("Smart Bimbel", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.purple)),
                    const SizedBox(height: 40),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: "Email", prefixIcon: const Icon(Icons.email_outlined), border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
                      validator: (v) => v!.isEmpty ? "Email wajib diisi" : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passController,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        labelText: "Password", prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off), onPressed: () => setState(() => _isObscure = !_isObscure)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      validator: (v) => v!.length < 6 ? "Minimal 6 karakter" : null,
                    ),
                    Align(alignment: Alignment.centerRight, child: TextButton(onPressed: () => _showForgotPasswordDialog(context), child: const Text("Lupa Password?", style: TextStyle(color: Colors.purple)))),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity, height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                        onPressed: _handleLogin,
                        child: const Text("MASUK", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}