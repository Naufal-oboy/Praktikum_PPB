/// Model data untuk sebuah notifikasi aplikasi.
class AppNotification {
  final String id;
  final String judul;
  final String pesan;
  final DateTime waktu;
  final String tipe; // 'booking', 'batal', 'promo', 'sistem'
  bool isRead;

  AppNotification({
    required this.id,
    required this.judul,
    required this.pesan,
    required this.waktu,
    required this.tipe,
    this.isRead = false,
  });

  /// Mengembalikan waktu dalam format relatif
  /// seperti "Baru saja", "5 menit yang lalu", "2 jam yang lalu", dll.
  String get waktuRelatif {
    final now = DateTime.now();
    final diff = now.difference(waktu);

    if (diff.inSeconds < 60) {
      return 'Baru saja';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} menit yang lalu';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} jam yang lalu';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} hari yang lalu';
    } else {
      final day = waktu.day.toString().padLeft(2, '0');
      final months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
        'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
      ];
      final month = months[waktu.month - 1];
      return '$day $month ${waktu.year}';
    }
  }
}
