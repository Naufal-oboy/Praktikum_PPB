import 'package:flutter/material.dart';

import '../models/lapangan.dart';

/// FavoriteProvider mengelola daftar lapangan favorit pengguna.
/// Menggunakan ChangeNotifier agar UI otomatis terupdate
/// saat user menambah atau menghapus favorit.
class FavoriteProvider extends ChangeNotifier {
  final List<Lapangan> _favorites = [];

  /// Getter — daftar lapangan favorit.
  List<Lapangan> get favorites => List.unmodifiable(_favorites);

  /// Jumlah lapangan favorit.
  int get jumlahFavorit => _favorites.length;

  /// Mengecek apakah lapangan sudah ada di daftar favorit.
  bool isFavorite(Lapangan lapangan) {
    return _favorites.any((l) => l.nama == lapangan.nama);
  }

  /// Toggle favorit: tambah jika belum ada, hapus jika sudah ada.
  void toggleFavorite(Lapangan lapangan) {
    if (isFavorite(lapangan)) {
      _favorites.removeWhere((l) => l.nama == lapangan.nama);
    } else {
      _favorites.add(lapangan);
    }
    notifyListeners();
  }

  /// Menghapus lapangan dari daftar favorit.
  void removeFavorite(Lapangan lapangan) {
    _favorites.removeWhere((l) => l.nama == lapangan.nama);
    notifyListeners();
  }
}
