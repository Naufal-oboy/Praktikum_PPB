import 'package:flutter/material.dart';

/// UserProvider mengelola data profil pengguna menggunakan ChangeNotifier.
/// Data user tersimpan di sini dan bisa diakses dari halaman manapun
/// melalui context.watch atau context.read.
class UserProvider extends ChangeNotifier {
  String _nama = 'User FutsalKu';
  String _email = 'user@futsalku.id';
  String _noTelepon = '081234567890';
  String _password = '123456';
  String? _fotoProfil; // path file foto profil

  // Getters
  String get nama => _nama;
  String get email => _email;
  String get noTelepon => _noTelepon;
  String get password => _password;
  String? get fotoProfil => _fotoProfil;

  /// Memperbarui data profil pengguna.
  void updateProfil({
    required String nama,
    required String email,
    required String noTelepon,
  }) {
    _nama = nama;
    _email = email;
    _noTelepon = noTelepon;
    notifyListeners();
  }

  /// Memperbarui foto profil pengguna.
  void updateFotoProfil(String path) {
    _fotoProfil = path;
    notifyListeners();
  }

  /// Menghapus foto profil pengguna.
  void hapusFotoProfil() {
    _fotoProfil = null;
    notifyListeners();
  }

  /// Mengubah password pengguna.
  /// Mengembalikan true jika password lama cocok dan berhasil diubah.
  bool ubahPassword({
    required String passwordLama,
    required String passwordBaru,
  }) {
    if (passwordLama == _password) {
      _password = passwordBaru;
      notifyListeners();
      return true;
    }
    return false;
  }
}

