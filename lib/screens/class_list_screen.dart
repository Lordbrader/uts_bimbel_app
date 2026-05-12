import 'package:flutter/material.dart';
import 'registration_form_screen.dart'; // Nama file sesuai folder kamu

class ClassListScreen extends StatefulWidget {
  const ClassListScreen({super.key});

  @override
  State<ClassListScreen> createState() => _ClassListScreenState();
}

class _ClassListScreenState extends State<ClassListScreen> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  final Map<String, List<Map<String, String>>> daftarKelas = {
    'SD': [
      {'nama': 'Matematika Dasar', 'guru': 'Pak Budi', 'img': '📐'},
      {'nama': 'Bahasa Indonesia', 'guru': 'Bu Sari', 'img': '📖'},
      {'nama': 'IPA Alam', 'guru': 'Pak Heru', 'img': '🧪'},
      {'nama': 'Bahasa Inggris', 'guru': 'Ms. Jane', 'img': '🇬🇧'},
      {'nama': 'Seni Musik', 'guru': 'Pak Andi', 'img': '🎸'},
      {'nama': 'IPS Dasar', 'guru': 'Bu Retno', 'img': '🌍'},
      {'nama': 'Pendidikan Agama', 'guru': 'Ust. Yusuf', 'img': '🕌'},
      {'nama': 'PJOK / Olahraga', 'guru': 'Pak Jaka', 'img': '⚽'},
      {'nama': 'Pancasila', 'guru': 'Bu Mega', 'img': '🇮🇩'},
      {'nama': 'Digital Art', 'guru': 'Kak Rio', 'img': '🎨'},
    ],
    'SMP': [
      {'nama': 'Aljabar & Logika', 'guru': 'Pak Anton', 'img': '🔢'},
      {'nama': 'Fisika Dasar', 'guru': 'Bu Lisa', 'img': '⚡'},
      {'nama': 'Biologi Sel', 'guru': 'Dr. Wahyu', 'img': '🔬'},
      {'nama': 'English Grammar', 'guru': 'Mr. Smith', 'img': '📚'},
      {'nama': 'Sejarah Dunia', 'guru': 'Pak Bondan', 'img': '📜'},
      {'nama': 'Geografi Modern', 'guru': 'Bu Yani', 'img': '🗺️'},
      {'nama': 'Ekonomi Remaja', 'guru': 'Pak Toto', 'img': '💰'},
      {'nama': 'Coding Python', 'guru': 'Kak Muhro', 'img': '🐍'},
      {'nama': 'Seni Tari', 'guru': 'Bu Maya', 'img': '💃'},
      {'nama': 'Robotik Dasar', 'guru': 'Pak Gani', 'img': '🤖'},
    ],
    'SMA': [
      {'nama': 'Kalkulus Lanjut', 'guru': 'Prof. Slamet', 'img': '📈'},
      {'nama': 'Fisika Kuantum', 'guru': 'Dr. Indah', 'img': '⚛️'},
      {'nama': 'Kimia Organik', 'guru': 'Bu Rina', 'img': '⚗️'},
      {'nama': 'Biologi Molekuler', 'guru': 'Pak Eko', 'img': '🧬'},
      {'nama': 'Sosiologi Makro', 'guru': 'Bu Sita', 'img': '👥'},
      {'nama': 'English TOEFL', 'guru': 'Ms. Kelly', 'img': '🎓'},
      {'nama': 'Algoritma & DS', 'guru': 'Pak Doni', 'img': '💻'},
      {'nama': 'Astronomi', 'guru': 'Pak Surya', 'img': '🌟'},
      {'nama': 'Sastra Indonesia', 'guru': 'Bu Dewi', 'img': '🖋️'},
      {'nama': 'Akuntansi', 'guru': 'Pak Bambang', 'img': '📊'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 220.0,
                pinned: true,
                backgroundColor: Colors.purple,
                title: const Text("Explorer"),
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.deepPurple, Colors.purpleAccent]),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),
                        const Text("Cari Kelas Favoritmu", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: TextField(
                            controller: searchController,
                            onChanged: (value) => setState(() => searchQuery = value.toLowerCase()),
                            decoration: InputDecoration(
                              hintText: "Nama kelas atau guru...",
                              prefixIcon: const Icon(Icons.search),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  const TabBar(
                    labelColor: Colors.purple,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.purple,
                    tabs: [Tab(text: "SD"), Tab(text: "SMP"), Tab(text: "SMA")],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              _buildFilteredGrid(daftarKelas['SD']!),
              _buildFilteredGrid(daftarKelas['SMP']!),
              _buildFilteredGrid(daftarKelas['SMA']!),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilteredGrid(List<Map<String, String>> data) {
    List<Map<String, String>> filtered = data.where((kelas) {
      return kelas['nama']!.toLowerCase().contains(searchQuery) || 
             kelas['guru']!.toLowerCase().contains(searchQuery);
    }).toList();

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15, childAspectRatio: 0.8,
      ),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final kelas = filtered[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(kelas['img']!, style: const TextStyle(fontSize: 40)),
              const SizedBox(height: 10),
              Text(kelas['nama']!, style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              Text(kelas['guru']!, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegistrationFormScreen(selectedClassName: kelas['nama']),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple.shade50, foregroundColor: Colors.purple, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                child: const Text("Daftar"),
              )
            ],
          ),
        );
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);
  final TabBar _tabBar;
  @override double get minExtent => _tabBar.preferredSize.height;
  @override double get maxExtent => _tabBar.preferredSize.height;
  @override Widget build(context, shrinkOffset, overlapsContent) => Container(color: Colors.white, child: _tabBar);
  @override bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}