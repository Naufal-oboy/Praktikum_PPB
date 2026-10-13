import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/notification_model.dart';
import '../providers/notification_provider.dart';
import '../theme/app_theme.dart';

/// NotifikasiPage menampilkan daftar notifikasi pengguna secara dinamis
/// dari NotificationProvider, dengan indikator unread dan aksi tandai dibaca.
class NotifikasiPage extends StatelessWidget {
  const NotifikasiPage({super.key});

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
          'Notifikasi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
        actions: [
          // Tombol "Baca Semua" – hanya tampil jika ada unread
          Consumer<NotificationProvider>(
            builder: (context, notifProv, _) {
              if (notifProv.unreadCount > 0) {
                return TextButton(
                  onPressed: () {
                    notifProv.tandaiSemuaDibaca();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                            'Semua notifikasi ditandai sudah dibaca'),
                        backgroundColor: AppColors.primary,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    );
                  },
                  child: const Text(
                    'Baca Semua',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, notifProv, _) {
          final notifikasi = notifProv.daftarNotifikasi;

          // Empty State
          if (notifikasi.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.notifications_off_outlined,
                        color: AppColors.primary,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Belum ada notifikasi',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Notifikasi terbaru akan muncul di sini.',
                      style: TextStyle(
                          fontSize: 13, color: Colors.grey.shade500),
                    ),
                  ],
                ),
              ),
            );
          }

          // List notifikasi
          return ListView.separated(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            itemCount: notifikasi.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final notif = notifikasi[index];
              return GestureDetector(
                onTap: () {
                  if (!notif.isRead) {
                    notifProv.tandaiDibaca(notif.id);
                  }
                },
                child: _NotifCard(notif: notif),
              );
            },
          );
        },
      ),
    );
  }
}

/// Mengembalikan ikon dan warna berdasarkan tipe notifikasi.
({IconData icon, Color iconColor, Color iconBgColor}) _getNotifStyle(
    String tipe) {
  switch (tipe) {
    case 'booking':
      return (
        icon: Icons.check_circle_outline,
        iconColor: Colors.green.shade700,
        iconBgColor: Colors.green.shade50,
      );
    case 'batal':
      return (
        icon: Icons.cancel_outlined,
        iconColor: Colors.red.shade700,
        iconBgColor: Colors.red.shade50,
      );
    case 'promo':
      return (
        icon: Icons.local_offer_outlined,
        iconColor: Colors.orange.shade700,
        iconBgColor: Colors.orange.shade50,
      );
    case 'sistem':
    default:
      return (
        icon: Icons.info_outline,
        iconColor: AppColors.primary,
        iconBgColor: AppColors.primaryLight,
      );
  }
}

/// Kartu notifikasi dengan indikator unread dot.
class _NotifCard extends StatelessWidget {
  final AppNotification notif;

  const _NotifCard({required this.notif});

  @override
  Widget build(BuildContext context) {
    final style = _getNotifStyle(notif.tipe);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: notif.isRead ? Colors.white : AppColors.primaryLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: notif.isRead
              ? Colors.grey.shade200
              : AppColors.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: style.iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(style.icon, color: style.iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          // Konten
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notif.judul,
                        style: TextStyle(
                          fontWeight:
                              notif.isRead ? FontWeight.w500 : FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    // Unread dot
                    if (!notif.isRead)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  notif.pesan,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  notif.waktuRelatif,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
