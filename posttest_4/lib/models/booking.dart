/// Model data untuk sebuah booking lapangan futsal.
class Booking {
  final String id;
  final String namaLapangan;
  final String namaPemesan;
  final String jamBooking;
  final int durasi; // dalam jam
  final int totalHarga;
  final DateTime tanggalBooking;
  String status; // 'Aktif', 'Selesai', 'Dibatalkan'

  Booking({
    required this.id,
    required this.namaLapangan,
    required this.namaPemesan,
    required this.jamBooking,
    required this.durasi,
    required this.totalHarga,
    required this.tanggalBooking,
    this.status = 'Aktif',
  });

  /// Mengembalikan string jam selesai berdasarkan jam mulai + durasi.
  String get jamSelesai {
    final parts = jamBooking.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    final endHour = (hour + durasi) % 24;
    return '${endHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  /// Format jadwal lengkap untuk ditampilkan di kartu booking.
  String get jadwalFormatted {
    final day = tanggalBooking.day.toString().padLeft(2, '0');
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
    ];
    final month = months[tanggalBooking.month - 1];
    final year = tanggalBooking.year;
    return '$day $month $year • $jamBooking – $jamSelesai';
  }

  /// Format total harga ke bentuk rupiah (misal: Rp200.000).
  String get totalHargaFormatted {
    final str = totalHarga.toString();
    final buffer = StringBuffer();
    int count = 0;
    for (int i = str.length - 1; i >= 0; i--) {
      buffer.write(str[i]);
      count++;
      if (count % 3 == 0 && i != 0) {
        buffer.write('.');
      }
    }
    return 'Rp${buffer.toString().split('').reversed.join()}';
  }
}
