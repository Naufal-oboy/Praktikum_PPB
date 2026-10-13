import 'package:flutter/material.dart';

import '../models/booking.dart';

/// BookingProvider mengelola state daftar booking menggunakan ChangeNotifier.
/// Provider ini menyimpan semua data booking dan menyediakan method
/// untuk menambah, membatalkan, menyelesaikan, serta memfilter booking.
class BookingProvider extends ChangeNotifier {
  final List<Booking> _daftarBooking = [];

  /// Getter – seluruh daftar booking.
  List<Booking> get daftarBooking => List.unmodifiable(_daftarBooking);

  /// Getter – hanya booking dengan status 'Aktif'.
  List<Booking> get bookingAktif =>
      _daftarBooking.where((b) => b.status == 'Aktif').toList();

  /// Getter – hanya booking dengan status 'Selesai'.
  List<Booking> get bookingSelesai =>
      _daftarBooking.where((b) => b.status == 'Selesai').toList();

  /// Getter – hanya booking dengan status 'Dibatalkan'.
  List<Booking> get bookingDibatalkan =>
      _daftarBooking.where((b) => b.status == 'Dibatalkan').toList();

  /// Menambahkan booking baru ke daftar.
  void tambahBooking(Booking booking) {
    _daftarBooking.insert(0, booking);
    notifyListeners();
  }

  /// Membatalkan booking berdasarkan ID (hanya jika masih Aktif).
  void batalkanBooking(String id) {
    final index = _daftarBooking.indexWhere((b) => b.id == id);
    if (index != -1 && _daftarBooking[index].status == 'Aktif') {
      _daftarBooking[index].status = 'Dibatalkan';
      notifyListeners();
    }
  }

  /// Menyelesaikan booking berdasarkan ID (hanya jika masih Aktif).
  void selesaikanBooking(String id) {
    final index = _daftarBooking.indexWhere((b) => b.id == id);
    if (index != -1 && _daftarBooking[index].status == 'Aktif') {
      _daftarBooking[index].status = 'Selesai';
      notifyListeners();
    }
  }

  /// Mengembalikan booking berdasarkan ID, atau null jika tidak ditemukan.
  Booking? cariBooking(String id) {
    final index = _daftarBooking.indexWhere((b) => b.id == id);
    return index != -1 ? _daftarBooking[index] : null;
  }

  /// Mengambil list booking berdasarkan nama tab/status.
  List<Booking> getByStatus(String status) {
    switch (status) {
      case 'Aktif':
        return bookingAktif;
      case 'Selesai':
        return bookingSelesai;
      case 'Dibatalkan':
        return bookingDibatalkan;
      default:
        return daftarBooking;
    }
  }
}
