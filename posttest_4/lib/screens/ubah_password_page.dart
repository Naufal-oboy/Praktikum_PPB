import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../theme/app_theme.dart';

/// UbahPasswordPage menampilkan form untuk mengubah password pengguna.
/// Validasi: password lama harus cocok, password baru min 6 karakter,
/// dan konfirmasi password harus sama dengan password baru.
class UbahPasswordPage extends StatefulWidget {
  const UbahPasswordPage({super.key});

  @override
  State<UbahPasswordPage> createState() => _UbahPasswordPageState();
}

class _UbahPasswordPageState extends State<UbahPasswordPage> {
  final _passwordLamaController = TextEditingController();
  final _passwordBaruController = TextEditingController();
  final _konfirmasiController = TextEditingController();

  bool _obscureLama = true;
  bool _obscureBaru = true;
  bool _obscureKonfirmasi = true;

  @override
  void dispose() {
    _passwordLamaController.dispose();
    _passwordBaruController.dispose();
    _konfirmasiController.dispose();
    super.dispose();
  }

  /// Validasi dan proses ubah password.
  void _ubahPassword() {
    final lama = _passwordLamaController.text;
    final baru = _passwordBaruController.text;
    final konfirmasi = _konfirmasiController.text;

    // Validasi field kosong
    if (lama.isEmpty || baru.isEmpty || konfirmasi.isEmpty) {
      _showError('Semua field harus diisi!');
      return;
    }

    // Validasi panjang password baru
    if (baru.length < 6) {
      _showError('Password baru minimal 6 karakter!');
      return;
    }

    // Validasi konfirmasi password
    if (baru != konfirmasi) {
      _showError('Konfirmasi password tidak cocok!');
      return;
    }

    // Cek password lama lewat UserProvider
    final berhasil = context.read<UserProvider>().ubahPassword(
          passwordLama: lama,
          passwordBaru: baru,
        );

    if (!berhasil) {
      _showError('Password lama salah!');
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Password berhasil diubah! 🔒'),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    Navigator.pop(context);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Ubah Password',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ikon keamanan
              Center(
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.lock_outline,
                    color: AppColors.primary,
                    size: 36,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  'Pastikan password baru Anda aman',
                  style:
                      TextStyle(fontSize: 13, color: Colors.grey.shade500),
                ),
              ),
              const SizedBox(height: 28),

              // Password Saat Ini
              _buildLabel('Password Saat Ini'),
              const SizedBox(height: 8),
              _buildPasswordField(
                controller: _passwordLamaController,
                hint: 'Masukkan password saat ini',
                obscure: _obscureLama,
                onToggle: () =>
                    setState(() => _obscureLama = !_obscureLama),
              ),
              const SizedBox(height: 20),

              // Password Baru
              _buildLabel('Password Baru'),
              const SizedBox(height: 8),
              _buildPasswordField(
                controller: _passwordBaruController,
                hint: 'Masukkan password baru (min. 6 karakter)',
                obscure: _obscureBaru,
                onToggle: () =>
                    setState(() => _obscureBaru = !_obscureBaru),
              ),
              const SizedBox(height: 20),

              // Konfirmasi Password Baru
              _buildLabel('Konfirmasi Password Baru'),
              const SizedBox(height: 8),
              _buildPasswordField(
                controller: _konfirmasiController,
                hint: 'Ulangi password baru',
                obscure: _obscureKonfirmasi,
                onToggle: () => setState(
                    () => _obscureKonfirmasi = !_obscureKonfirmasi),
              ),
              const SizedBox(height: 36),

              // Tombol Ubah Password
              GestureDetector(
                onTap: _ubahPassword,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.35),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock_reset, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Ubah Password',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hint,
    required bool obscure,
    required VoidCallback onToggle,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        prefixIcon:
            Icon(Icons.lock_outline, color: Colors.grey.shade400),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey.shade400,
          ),
          onPressed: onToggle,
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}
