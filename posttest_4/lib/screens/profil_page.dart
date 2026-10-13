import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/booking_provider.dart';
import '../providers/favorite_provider.dart';
import '../providers/notification_provider.dart';
import '../providers/user_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/profile_image.dart';
import 'bantuan_faq_page.dart';
import 'edit_profil_page.dart';
import 'lapangan_favorit_page.dart';
import 'notifikasi_page.dart';
import 'ubah_password_page.dart';

/// ProfilPage menampilkan informasi profil pengguna.
/// Data nama dan email dibaca secara reaktif dari UserProvider.
class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    height: 160,
                    color: AppColors.primaryDark,
                  ),
                  const Positioned(
                    top: 20,
                    left: 20,
                    child: Text(
                      'Profil Saya',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -45,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Consumer<UserProvider>(
                          builder: (context, userProvider, _) {
                            return Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                color: AppColors.primaryLight,
                                borderRadius: BorderRadius.circular(45),
                                border: Border.all(
                                    color: Colors.white, width: 4),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black
                                        .withValues(alpha: 0.15),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(41),
                                child: userProvider.fotoProfil != null
                                    ? profileImage(
                                        userProvider.fotoProfil!,
                                        width: 82,
                                        height: 82,
                                      )
                                    : const Icon(
                                        Icons.person,
                                        size: 48,
                                        color: AppColors.primary,
                                      ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 60),

              // Nama & email dari UserProvider (reaktif)
              Consumer<UserProvider>(
                builder: (context, userProvider, _) {
                  return Column(
                    children: [
                      Text(
                        userProvider.nama,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        userProvider.email,
                        style: TextStyle(
                            fontSize: 13, color: Colors.grey.shade500),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),

              // Statistik booking (dinamis dari Provider)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Consumer2<BookingProvider, FavoriteProvider>(
                  builder: (context, bookingProv, favProv, _) {
                    final totalBooking =
                        bookingProv.daftarBooking.length.toString();
                    final totalJam = bookingProv.daftarBooking
                        .fold<int>(0, (sum, b) => sum + b.durasi)
                        .toString();
                    final totalFav = favProv.jumlahFavorit.toString();

                    return Row(
                      children: [
                        Expanded(
                          child: _StatCard(
                              label: 'Total Booking', value: totalBooking),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _StatCard(
                              label: 'Jam Bermain', value: totalJam),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child:
                              _StatCard(label: 'Favorit', value: totalFav),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Menu profil dengan navigasi
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    _MenuProfilItem(
                      icon: Icons.person_outline,
                      label: 'Edit Profil',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const EditProfilPage()),
                      ),
                    ),
                    _MenuProfilItem(
                      icon: Icons.history,
                      label: 'Riwayat Booking',
                      onTap: () => Navigator.pushReplacementNamed(
                          context, '/booking'),
                    ),
                    _MenuProfilItem(
                      icon: Icons.favorite_border,
                      label: 'Lapangan Favorit',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const LapanganFavoritPage()),
                      ),
                    ),
                    Consumer<NotificationProvider>(
                      builder: (context, notifProv, _) {
                        return _MenuProfilItem(
                          icon: Icons.notifications_outlined,
                          label: 'Notifikasi',
                          badge: notifProv.unreadCount > 0
                              ? notifProv.unreadCount
                              : null,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const NotifikasiPage()),
                          ),
                        );
                      },
                    ),
                    _MenuProfilItem(
                      icon: Icons.lock_outline,
                      label: 'Ubah Password',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const UbahPasswordPage()),
                      ),
                    ),
                    _MenuProfilItem(
                      icon: Icons.help_outline,
                      label: 'Bantuan & FAQ',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const BantuanFaqPage()),
                      ),
                    ),
                    _MenuProfilItem(
                      icon: Icons.logout,
                      label: 'Keluar',
                      isDestructive: true,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            title: const Text('Keluar'),
                            content: const Text(
                                'Apakah Anda yakin ingin keluar?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text('Batal'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text(
                                          'Berhasil keluar dari akun'),
                                      backgroundColor: AppColors.primary,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Keluar',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          const routes = {0: '/', 1: '/lapangan', 2: '/booking', 3: '/profil'};
          if (index != 3) {
            Navigator.pushReplacementNamed(context, routes[index]!);
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stadium_rounded),
            label: 'Lapangan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_rounded),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

/// Kartu statistik di halaman profil
class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Item menu di halaman profil (sekarang dengan onTap callback).
class _MenuProfilItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDestructive;
  final VoidCallback? onTap;
  final int? badge;

  const _MenuProfilItem({
    required this.icon,
    required this.label,
    this.isDestructive = false,
    this.onTap,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? Colors.red.shade400 : Colors.black87;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // Badge notifikasi belum dibaca
            if (badge != null)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  badge! > 99 ? '99+' : badge.toString(),
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            if (!isDestructive)
              Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 20),
          ],
        ),
      ),
    );
  }
}
