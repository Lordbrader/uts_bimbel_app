import 'package:flutter/material.dart';

import '../data/registration_data.dart'; 

class MyClassesScreen extends StatefulWidget {
  const MyClassesScreen({super.key});

  @override
  State<MyClassesScreen> createState() => _MyClassesScreenState();
}

class _MyClassesScreenState extends State<MyClassesScreen> {
  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kelas Saya"),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        actions: [
          
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {}); 
            },
          ),
        ],
      ),
      body: registeredClasses.isEmpty
          ? const Center(
              child: Text(
                "Belum ada data pendaftaran.",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              
              itemCount: registeredClasses.length, 
              itemBuilder: (context, index) {
                
                final data = registeredClasses[index];
                
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.purple,
                      child: Icon(Icons.book, color: Colors.white),
                    ),
                    title: Text(
                      data['kelas'] ?? "Tanpa Nama Kelas",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("${data['jenjang']} - ${data['nama']}"),
                    trailing: const Text(
                      "Aktif",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}