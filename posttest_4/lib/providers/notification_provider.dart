import 'package:flutter/material.dart';

import '../models/notification_model.dart';

/// NotificationProvider mengelola state daftar notifikasi menggunakan ChangeNotifier.
/// Provider ini menyimpan semua notifikasi dan menyediakan method
/// untuk menambah, menandai dibaca, serta menghitung jumlah unread.
class NotificationProvider extends ChangeNotifier {
  final List<AppNotification> _daftarNotifikasi = [
    // Notifikasi default – promo & selamat datang
    AppNotification(
      id: 'NOTIF-DEFAULT-1',
      judul: 'Promo Diskon Akhir Pekan 🔥',
      pesan:
          'Dapatkan diskon 20% untuk semua booking di hari Sabtu & Minggu!',
      waktu: DateTime.now().subtract(const Duration(hours: 1)),
      tipe: 'promo',
    ),
    AppNotification(
      id: 'NOTIF-DEFAULT-2',
      judul: 'Selamat Datang di FutsalKu! 👋',
      pesan:
          'Terima kasih sudah bergabung. Yuk mulai booking lapangan pertamamu!',
      waktu: DateTime.now().subtract(const Duration(days: 2)),
      tipe: 'sistem',
      isRead: true,
    ),
  ];

  /// Getter – seluruh daftar notifikasi.
  List<AppNotification> get daftarNotifikasi =>
      List.unmodifiable(_daftarNotifikasi);

  /// Getter – jumlah notifikasi yang belum dibaca.
  int get unreadCount =>
      _daftarNotifikasi.where((n) => !n.isRead).length;

  /// Menambahkan notifikasi baru ke urutan teratas (index 0).
  void tambahNotifikasi({
    required String judul,
    required String pesan,
    required String tipe,
  }) {
    final notif = AppNotification(
      id: 'NOTIF-${DateTime.now().millisecondsSinceEpoch}',
      judul: judul,
      pesan: pesan,
      waktu: DateTime.now(),
      tipe: tipe,
    );
    _daftarNotifikasi.insert(0, notif);
    notifyListeners();
  }

  /// Menandai satu notifikasi sebagai sudah dibaca berdasarkan ID.
  void tandaiDibaca(String id) {
    final index = _daftarNotifikasi.indexWhere((n) => n.id == id);
    if (index != -1 && !_daftarNotifikasi[index].isRead) {
      _daftarNotifikasi[index].isRead = true;
      notifyListeners();
    }
  }

  /// Menandai semua notifikasi sebagai sudah dibaca.
  void tandaiSemuaDibaca() {
    bool changed = false;
    for (final notif in _daftarNotifikasi) {
      if (!notif.isRead) {
        notif.isRead = true;
        changed = true;
      }
    }
    if (changed) notifyListeners();
  }
}
