import 'package:flutter/material.dart';

import '../data/registration_data.dart'; 

class RegistrationFormScreen extends StatefulWidget {
  final String? selectedClassName;

  const RegistrationFormScreen({super.key, this.selectedClassName});

  @override
  State<RegistrationFormScreen> createState() => _RegistrationFormScreenState();
}

class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
  final TextEditingController _nameController = TextEditingController();
  
  
  final Map<String, List<String>> dataKelasPerJenjang = {
    'SD': [
      'Matematika Dasar', 'Bahasa Indonesia', 'IPA Alam', 'Bahasa Inggris',
      'Seni Musik', 'IPS Dasar', 'Pendidikan Agama', 'PJOK / Olahraga', 
      'Pancasila', 'Digital Art'
    ],
    'SMP': [
      'Aljabar & Logika', 'Fisika Dasar', 'Biologi Sel', 'English Grammar',
      'Sejarah Dunia', 'Geografi Modern', 'Ekonomi Remaja', 'Coding Python', 
      'Seni Tari', 'Robotik Dasar'
    ],
    'SMA': [
      'Kalkulus Lanjut', 'Fisika Kuantum', 'Kimia Organik', 'Biologi Molekuler',
      'Sosiologi Makro', 'English TOEFL', 'Algoritma & DS', 'Astronomi', 
      'Sastra Indonesia', 'Akuntansi'
    ],
  };

  String? selectedJenjang;
  String? selectedClass;

  @override
  void initState() {
    super.initState();
    if (widget.selectedClassName != null) {
      selectedClass = widget.selectedClassName;
      dataKelasPerJenjang.forEach((jenjang, listKelas) {
        if (listKelas.contains(widget.selectedClassName)) {
          selectedJenjang = jenjang;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Pendaftaran"),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Nama Mahasiswa", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: "Ketik nama lengkap...",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 25),
            
            const Text("Pilih Jenjang", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: const Text("Pilih SD, SMP, atau SMA"),
                  value: selectedJenjang,
                  items: dataKelasPerJenjang.keys.map((String jenjang) {
                    return DropdownMenuItem<String>(
                      value: jenjang,
                      child: Text(jenjang),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedJenjang = newValue;
                      selectedClass = null; 
                    });
                  },
                ),
              ),
            ),
            
            const SizedBox(height: 20),

            const Text("Pilih Kelas Bimbel", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: selectedJenjang == null ? Colors.grey.shade300 : Colors.grey),
                borderRadius: BorderRadius.circular(10),
                color: selectedJenjang == null ? Colors.grey.shade100 : Colors.white,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  disabledHint: const Text("Pilih jenjang terlebih dahulu"),
                  hint: const Text("Pilih kelas sesuai jenjang"),
                  value: selectedClass,
                  items: selectedJenjang == null 
                    ? [] 
                    : dataKelasPerJenjang[selectedJenjang]!.map((String kelas) {
                        return DropdownMenuItem<String>(
                          value: kelas,
                          child: Text(kelas),
                        );
                      }).toList(),
                  onChanged: selectedJenjang == null ? null : (newValue) {
                    setState(() {
                      selectedClass = newValue;
                    });
                  },
                ),
              ),
            ),
            
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  if (_nameController.text.isNotEmpty && selectedClass != null) {
                    
                    registeredClasses.add({
                      'nama': _nameController.text,
                      'jenjang': selectedJenjang ?? "-",
                      'kelas': selectedClass!,
                      'tanggal': "12-05-2026",
                    });
                    _showReceipt();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Lengkapi Nama, Jenjang dan Kelas!")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text("KONFIRMASI", 
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showReceipt() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Center(child: Text("STRUK PENDAFTARAN", style: TextStyle(fontWeight: FontWeight.bold))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const Divider(),
            _buildInfoRow("Nama", _nameController.text),
            _buildInfoRow("Jenjang", selectedJenjang ?? "-"),
            _buildInfoRow("Kelas", selectedClass ?? "-"),
            _buildInfoRow("Tanggal", "12-05-2026"),
            const Divider(),
            const Text("Simpan sebagai bukti pendaftaran.", style: TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              
              Navigator.of(context, rootNavigator: true).pop();
              
              
              setState(() {
                _nameController.clear();
                selectedJenjang = null;
                selectedClass = null;
              });

              
              
            },
            child: const Center(child: Text("OK, MENGERTI", style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold))),
          )
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}