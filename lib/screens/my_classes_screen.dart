import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

class MyClassesScreen extends StatefulWidget {
  const MyClassesScreen({super.key});

  @override
  State<MyClassesScreen> createState() => _MyClassesScreenState();
}

class _MyClassesScreenState extends State<MyClassesScreen> {
  List<dynamic> _daftarKelas = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _muatDataDariBrowser();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _muatDataDariBrowser();
  }

  void _muatDataDariBrowser() {
    setState(() => _isLoading = true);
    try {
      String? jsonString = html.window.localStorage['pendaftaran_data'];
      if (jsonString != null && jsonString.isNotEmpty) {
        setState(() {
          _daftarKelas = jsonDecode(jsonString);
        });
      } else {
        setState(() {
          _daftarKelas = [];
        });
      }
    } catch (e) {
      print("Error muat data: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text('Kelas Saya', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFF4A148C),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.tune_rounded, color: Colors.white),
            onPressed: _muatDataDariBrowser,
          )
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF6A1B9A)))
          : _daftarKelas.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.layers_clear_rounded, size: 80, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('Belum ada kelas terdaftar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey)),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 100), // Beri padding bawah agar tidak tertutup nav bar melayang
                  itemCount: _daftarKelas.length,
                  itemBuilder: (context, index) {
                    final item = _daftarKelas[index];
                    final String fotoPath = item['foto_path'] ?? '';

                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 15, offset: const Offset(0, 6))
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  width: 64,
                                  height: 64,
                                  color: const Color(0xFFF3E5F5),
                                  child: fotoPath.isNotEmpty
                                      ? Image.network(fotoPath, fit: BoxFit.cover)
                                      : const Icon(Icons.menu_book_rounded, color: Color(0xFF7B1FA2)),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['kelas'] ?? 'Paket Bimbel',
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF4A148C)),
                                    ),
                                    const SizedBox(height: 4),
                                    Text('Siswa: ${item['nama']}', style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE0F2F1),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(Icons.done_all_rounded, size: 14, color: Color(0xFF004D40)),
                                    SizedBox(width: 4),
                                    Text('Aktif', style: TextStyle(color: Color(0xFF004D40), fontSize: 11, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Visualisasi Progres Belajar Modern
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('Progres Materi Materi Baru', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                  Text('0%', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF6A1B9A))),
                                ],
                              ),
                              const SizedBox(height: 6),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: const LinearProgressIndicator(
                                  value: 0.0,
                                  backgroundColor: Color(0xFFE1BEE7),
                                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF7B1FA2)),
                                  minHeight: 6,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 12),
                          Divider(color: Colors.grey[100]),
                          Row(
                            children: [
                              const Icon(Icons.pin_drop_rounded, size: 14, color: Colors.grey),
                              const SizedBox(width: 6),
                              Text(
                                'GPS: ${item['latitude'].toStringAsFixed(4)}, ${item['longitude'].toStringAsFixed(4)}',
                                style: const TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}