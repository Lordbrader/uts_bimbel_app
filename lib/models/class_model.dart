class BimbelClass {
  final String name;
  final String teacher;
  final String image;
  final double rating;
  final double price;
  final String level;
  final String schedule;
  final String description;

  BimbelClass({
    required this.name,
    required this.teacher,
    required this.image,
    required this.rating,
    required this.price,
    required this.level,
    required this.schedule,
    required this.description,
  });
}

List<BimbelClass> dummyClasses = [
  BimbelClass(
    name: "Matematika Dasar",
    teacher: "Bpk. Budi Santoso",
    image: "https://images.unsplash.com/photo-1518133910546-b6c2fb7d79e3?q=80&w=400",
    rating: 4.8,
    price: 250000,
    level: "SD Kelas 4-6",
    schedule: "Senin & Rabu, 15:00",
    description: "Menguasai konsep berhitung cepat dan logika matematika dasar.",
  ),
  BimbelClass(
    name: "Bahasa Inggris Fun",
    teacher: "Ms. Sarah Johnson",
    image: "https://images.unsplash.com/photo-1456513080510-7bf3a84b82f8?q=80&w=400",
    rating: 4.9,
    price: 300000,
    level: "SMP Kelas 7-9",
    schedule: "Selasa & Kamis, 16:00",
    description: "Belajar percakapan sehari-hari dengan metode yang interaktif.",
  ),
  BimbelClass(
    name: "Fisika Quantum",
    teacher: "Dr. Albert Kurniawan",
    image: "https://images.unsplash.com/photo-1636466497217-26a8cbeaf0aa?q=80&w=400",
    rating: 4.7,
    price: 450000,
    level: "SMA Kelas 12",
    schedule: "Jumat, 18:30",
    description: "Persiapan mendalam menghadapi ujian sekolah dan masuk PTN.",
  ),
  BimbelClass(
    name: "Persiapan UTBK",
    teacher: "Tim Mentor Ahli",
    image: "https://images.unsplash.com/photo-1434030216411-0b793f4b4173?q=80&w=400",
    rating: 5.0,
    price: 600000,
    level: "SMA (Intensif)",
    schedule: "Sabtu & Minggu, 09:00",
    description: "Bedah soal-soal HOTS dan strategi lolos seleksi universitas.",
  ),
  BimbelClass(
    name: "IPA Terpadu",
    teacher: "Ibu Citra Dewi",
    image: "https://images.unsplash.com/photo-1532094349884-543bc11b234d?q=80&w=400",
    rating: 4.6,
    price: 275000,
    level: "SMP Kelas 8",
    schedule: "Rabu & Jumat, 15:30",
    description: "Eksperimen seru untuk memahami biologi dan fisika.",
  ),
  BimbelClass(
    name: "Koding Anak",
    teacher: "Kak Reza",
    image: "https://images.unsplash.com/photo-1517694712202-14dd9538aa97?q=80&w=400",
    rating: 4.9,
    price: 500000,
    level: "SD-SMP",
    schedule: "Sabtu, 13:00",
    description: "Membuat game sendiri menggunakan blok koding Scratch.",
  ),
];

List<Map<String, String>> myEnrolledClasses = [];