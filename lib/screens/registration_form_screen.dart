import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:geolocator/geolocator.dart';
import 'package:universal_html/html.dart' as html;
import '../services/api_service.dart';

class RegistrationFormScreen extends StatefulWidget {
  final CameraDescription? camera;
  final String? selectedClassName; // Menangkap kiriman kelas otomatis

  const RegistrationFormScreen({super.key, this.camera, this.selectedClassName});

  @override
  State<RegistrationFormScreen> createState() => _RegistrationFormScreenState();
}

class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  
  String _selectedKelas = 'Kelas 10 SMA';
  // List Pilihan Komplet yang disamakan dengan Beranda
  final List<String> _listKelas = ['Kelas 10 SMA', 'Kelas 11 SMA', 'Kelas 12 SMA'];

  CameraController? _cameraController;
  String? _capturedImagePath;
  Position? _currentPosition;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _inisialisasiKelas();

    if (widget.camera != null) {
      _cameraController = CameraController(
        widget.camera!, 
        ResolutionPreset.medium,
        enableAudio: false,
      );
      _cameraController!.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    }
    _determinePosition();
  }

  // Mendeteksi perubahan properti kiriman parameter antar tab screen
  @override
  void didUpdateWidget(covariant RegistrationFormScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedClassName != oldWidget.selectedClassName) {
      _inisialisasiKelas();
    }
  }

  void _inisialisasiKelas() {
    if (widget.selectedClassName != null && _listKelas.contains(widget.selectedClassName)) {
      _selectedKelas = widget.selectedClassName!;
    }
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
    });
  }

  Future<void> _takePicture() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) return;
    try {
      final image = await _cameraController!.takePicture();
      setState(() {
        _capturedImagePath = image.path;
      });
    } catch (e) {
      print("Gagal ambil foto: $e");
    }
  }

  Future<void> _prosesPendaftaran() async {
    if (!_formKey.currentState!.validate()) return;
    if (_capturedImagePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan ambil foto Kartu Pelajar terlebih dahulu!'), backgroundColor: Colors.redAccent),
      );
      return;
    }

    setState(() => _isLoading = true);

    Map<String, dynamic> dataPendaftaran = {
      'nama': _namaController.text,
      'kelas': _selectedKelas,
      'foto_path': _capturedImagePath ?? '',
      'latitude': _currentPosition?.latitude ?? 0.0,
      'longitude': _currentPosition?.longitude ?? 0.0,
    };

    try {
      String? existingData = html.window.localStorage['pendaftaran_data'];
      List<dynamic> listData = existingData != null && existingData.isNotEmpty ? jsonDecode(existingData) : [];
      dataPendaftaran['id'] = listData.length + 1;
      listData.add(dataPendaftaran);
      html.window.localStorage['pendaftaran_data'] = jsonEncode(listData);
    } catch (e) {
      print("Gagal tulis storage: $e");
    }

    try {
      await ApiService().sendPendaftaranToServer(dataPendaftaran).timeout(const Duration(seconds: 3));
    } catch (_) {}

    setState(() => _isLoading = false);
    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Row(
          children: const [
            Icon(Icons.check_circle_rounded, color: Color(0xFF00BFA5), size: 32),
            SizedBox(width: 12),
            Text('Sukses!', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: const Text('Data pendaftaran tersimpan aman di browser lokal. Silakan cek di tab Kelas Saya.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _namaController.clear();
              setState(() => _capturedImagePath = null);
            },
            child: const Text('OK', style: TextStyle(color: Color(0xFF6A1B9A), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text('Form Pendaftaran', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFF4A148C),
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF6A1B9A)))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Lengkapi Data Diri', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF4A148C))),
                    const SizedBox(height: 20),
                    
                    TextFormField(
                      controller: _namaController,
                      decoration: InputDecoration(
                        labelText: 'Nama Lengkap Siswa',
                        prefixIcon: const Icon(Icons.person_rounded, color: Color(0xFF7B1FA2)),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                      ),
                      validator: (v) => v!.isEmpty ? 'Nama tidak boleh kosong' : null,
                    ),
                    const SizedBox(height: 16),
                    
                    // Dropdown Pintar Dinamis
                    DropdownButtonFormField<String>(
                      key: ValueKey(_selectedKelas), // Menjamin UI ter-refresh saat nilai berubah otomatis
                      value: _selectedKelas,
                      decoration: InputDecoration(
                        labelText: 'Pilih Paket Bimbel',
                        prefixIcon: const Icon(Icons.school_rounded, color: Color(0xFF7B1FA2)),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                      ),
                      items: _listKelas.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                      onChanged: (v) => setState(() => _selectedKelas = v!),
                    ),
                    const SizedBox(height: 20),
                    
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF7B1FA2).withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFF7B1FA2).withValues(alpha: 0.1)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.share_location_rounded, color: Color(0xFF7B1FA2), size: 28),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Lokasi GPS Terdeteksi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                const SizedBox(height: 2),
                                Text(
                                  _currentPosition == null
                                      ? 'Mencari koordinat satelit...'
                                      : 'Lat: ${_currentPosition!.latitude.toStringAsFixed(5)}, Long: ${_currentPosition!.longitude.toStringAsFixed(5)}',
                                  style: const TextStyle(color: Colors.black54, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    const Text('Verifikasi Kartu Pelajar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 12),
                    
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        height: 220,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: _capturedImagePath != null
                            ? Image.network(_capturedImagePath!, fit: BoxFit.cover)
                            : (_cameraController != null && _cameraController!.value.isInitialized)
                                ? CameraPreview(_cameraController!)
                                : const Center(child: Icon(Icons.camera_enhance_rounded, size: 55, color: Colors.grey)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: _takePicture,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF3E5F5),
                          foregroundColor: const Color(0xFF4A148C),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                        icon: const Icon(Icons.camera_alt_rounded),
                        label: const Text('Ambil Gambar', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    ElevatedButton(
                      onPressed: _prosesPendaftaran,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(56),
                        backgroundColor: const Color(0xFF6A1B9A),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 3,
                      ),
                      child: const Text('Daftar & Sinkronisasikan Data', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _namaController.dispose();
    super.dispose();
  }
}