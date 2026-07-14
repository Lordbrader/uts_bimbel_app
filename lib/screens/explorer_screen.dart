import 'package:flutter/material.dart';

class ExplorerScreen extends StatelessWidget {
  final String userEmail;
  final Function(String)? onPackageSelected;

  const ExplorerScreen({super.key, required this.userEmail, this.onPackageSelected});

  String _ambilNamaPanggilan() {
    if (userEmail.contains('@')) {
      String namaMentah = userEmail.split('@')[0];
      return namaMentah[0].toUpperCase() + namaMentah.substring(1); 
    }
    return userEmail;
  }

  @override
  Widget build(BuildContext context) {
    String namaUser = _ambilNamaPanggilan();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 40),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4A148C), Color(0xFF7B1FA2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Selamat Datang ✨', style: TextStyle(color: Colors.white70, fontSize: 14)),
                          const SizedBox(height: 4),
                          Text('Halo, $namaUser!', style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.notifications_none_rounded, color: Colors.white),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem('2', 'Kelas Aktif'),
                        Container(width: 1, height: 40, color: Colors.white24),
                        _buildStatItem('85%', 'Progres'),
                        Container(width: 1, height: 40, color: Colors.white24),
                        _buildStatItem('12 Jam', 'Waktu Belajar'),
                      ],
                    ),
                  )
                ],
              ),
            ),
            
            // Konten Utama
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Paket Bimbel Populer', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF212121))),
                  const SizedBox(height: 4),
                  const Text('Pilih paket untuk langsung mendaftar dengan cepat', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 16),
                  
                  // List Paket
                  ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildPackageCard(context, 'Kelas 10 SMA', 'Fokus Pemantapan Materi Dasar', Icons.science_rounded, const Color(0xFFE8EAF6), const Color(0xFF3F51B5)),
                      _buildPackageCard(context, 'Kelas 11 SMA', 'Persiapan Ujian Tengah Jenjang', Icons.functions_rounded, const Color(0xFFF3E5F5), const Color(0xFF9C27B0)),
                      _buildPackageCard(context, 'Kelas 12 SMA', 'Akselerasi Ujian UTBK & PTN', Icons.auto_stories_rounded, const Color(0xFFEFFFFA), const Color(0xFF00BFA5)),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  // KEMBALIKAN DATA PELAJARAN DI SINI
                  const Text('Mata Pelajaran Tersedia', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF212121))),
                  const SizedBox(height: 16),
                  
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 1.2,
                    children: [
                      _buildSubjectCard('Matematika Wajib', '24 Materi • Aljabar & Geometri', Icons.calculate_rounded, const Color(0xFFFFECEB), Colors.redAccent),
                      _buildSubjectCard('Fisika', '18 Materi • Mekanika & Termo', Icons.blur_on_rounded, const Color(0xFFE3F2FD), Colors.blue),
                      _buildSubjectCard('Kimia', '15 Materi • Struktur Atom & Gas', Icons.science_outlined, const Color(0xFFE8F5E9), Colors.green),
                      _buildSubjectCard('Biologi', '20 Materi • Genetika & Ekosistem', Icons.eco_rounded, const Color(0xFFFFF8E1), Colors.amber[700]!),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  Widget _buildPackageCard(BuildContext context, String title, String desc, IconData icon, Color bg, Color accent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          if (onPackageSelected != null) {
            onPackageSelected!(title);
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4))
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: accent, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(desc, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk membuat kartu mata pelajaran
  Widget _buildSubjectCard(String title, String subtitle, IconData icon, Color bgColor, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 8, offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87), maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 2),
              Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.grey), maxLines: 1, overflow: TextOverflow.ellipsis),
            ],
          ),
        ],
      ),
    );
  }
}