import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/booking.dart';
import '../providers/booking_provider.dart';
import '../providers/notification_provider.dart';
import '../theme/app_theme.dart';

/// BookingPage menampilkan daftar riwayat dan booking aktif pengguna
/// secara dinamis menggunakan `Consumer<BookingProvider>`.
class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  /// Index tab yang sedang aktif: 0 = Aktif, 1 = Selesai, 2 = Dibatalkan
  int _selectedTabIndex = 0;
  final List<String> _tabs = ['Aktif', 'Selesai', 'Dibatalkan'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Booking Saya',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // --- Tab filter ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: List.generate(_tabs.length, (index) {
                  return Padding(
                    padding: EdgeInsets.only(right: index < 2 ? 10 : 0),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTabIndex = index),
                      child: _TabButton(
                        label: _tabs[index],
                        isActive: _selectedTabIndex == index,
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 8),

            // --- Daftar Booking dari Provider ---
            Expanded(
              child: Consumer<BookingProvider>(
                builder: (context, provider, _) {
                  final bookings =
                      provider.getByStatus(_tabs[_selectedTabIndex]);

                  // Empty state
                  if (bookings.isEmpty) {
                    return _EmptyState(status: _tabs[_selectedTabIndex]);
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: bookings.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final booking = bookings[index];
                      return GestureDetector(
                        onTap: () => _showDetailBooking(context, booking),
                        child: _BookingItemCard(booking: booking),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          const routes = {0: '/', 1: '/lapangan', 2: '/booking', 3: '/profil'};
          if (index != 2) {
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

  /// Menampilkan bottom sheet detail booking.
  void _showDetailBooking(BuildContext context, Booking booking) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _DetailBookingSheet(booking: booking),
    );
  }
}

// ─────────────────────────────────────────────
// TAB BUTTON
// ─────────────────────────────────────────────

/// Tombol tab filter di halaman Booking
class _TabButton extends StatelessWidget {
  final String label;
  final bool isActive;

  const _TabButton({required this.label, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: isActive ? Colors.white : Colors.grey.shade600,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// EMPTY STATE
// ─────────────────────────────────────────────

/// Widget untuk menampilkan pesan jika belum ada booking.
class _EmptyState extends StatelessWidget {
  final String status;

  const _EmptyState({required this.status});

  @override
  Widget build(BuildContext context) {
    final Map<String, Map<String, dynamic>> emptyInfo = {
      'Aktif': {
        'icon': Icons.calendar_today_rounded,
        'title': 'Belum ada booking aktif',
        'subtitle': 'Yuk booking lapangan favoritmu sekarang!',
      },
      'Selesai': {
        'icon': Icons.check_circle_outline_rounded,
        'title': 'Belum ada booking selesai',
        'subtitle': 'Riwayat booking yang sudah selesai akan muncul di sini.',
      },
      'Dibatalkan': {
        'icon': Icons.cancel_outlined,
        'title': 'Tidak ada booking dibatalkan',
        'subtitle': 'Booking yang dibatalkan akan muncul di sini.',
      },
    };

    final info = emptyInfo[status]!;

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
              child: Icon(
                info['icon'] as IconData,
                color: AppColors.primary,
                size: 40,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              info['title'] as String,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              info['subtitle'] as String,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// BOOKING ITEM CARD
// ─────────────────────────────────────────────

/// Kartu item booking di daftar riwayat booking
class _BookingItemCard extends StatelessWidget {
  final Booking booking;

  const _BookingItemCard({required this.booking});

  @override
  Widget build(BuildContext context) {
    final bool isAktif = booking.status == 'Aktif';
    final bool isDibatalkan = booking.status == 'Dibatalkan';

    // Warna badge status
    Color statusBgColor;
    Color statusTextColor;
    if (isAktif) {
      statusBgColor = AppColors.primaryLight;
      statusTextColor = AppColors.primary;
    } else if (isDibatalkan) {
      statusBgColor = Colors.red.shade50;
      statusTextColor = Colors.redAccent;
    } else {
      statusBgColor = Colors.green.shade50;
      statusTextColor = Colors.green.shade700;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/lapangan.jpg',
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(
                    Icons.sports_soccer,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.namaLapangan,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 13, color: Colors.grey.shade500),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        booking.jadwalFormatted,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  booking.totalHargaFormatted,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: statusBgColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              booking.status,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: statusTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// DETAIL BOOKING BOTTOM SHEET
// ─────────────────────────────────────────────

/// Bottom sheet yang menampilkan detail lengkap sebuah booking,
/// serta opsi untuk membatalkan/menyelesaikan jika status masih Aktif.
class _DetailBookingSheet extends StatelessWidget {
  final Booking booking;

  const _DetailBookingSheet({required this.booking});

  /// Format harga ke rupiah.
  String _formatRupiah(int value) {
    final str = value.toString();
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

  @override
  Widget build(BuildContext context) {
    final bool isAktif = booking.status == 'Aktif';

    // Warna badge status
    Color statusBgColor;
    Color statusTextColor;
    if (isAktif) {
      statusBgColor = AppColors.primaryLight;
      statusTextColor = AppColors.primary;
    } else if (booking.status == 'Dibatalkan') {
      statusBgColor = Colors.red.shade50;
      statusTextColor = Colors.redAccent;
    } else {
      statusBgColor = Colors.green.shade50;
      statusTextColor = Colors.green.shade700;
    }

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Header
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Detail Booking',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusBgColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    booking.status,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: statusTextColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Info detail
            _DetailRow(
              icon: Icons.confirmation_number_outlined,
              label: 'ID Booking',
              value: booking.id,
            ),
            const SizedBox(height: 14),
            _DetailRow(
              icon: Icons.stadium_rounded,
              label: 'Lapangan',
              value: booking.namaLapangan,
            ),
            const SizedBox(height: 14),
            _DetailRow(
              icon: Icons.person_outline,
              label: 'Pemesan',
              value: booking.namaPemesan,
            ),
            const SizedBox(height: 14),
            _DetailRow(
              icon: Icons.calendar_today_outlined,
              label: 'Jadwal',
              value: booking.jadwalFormatted,
            ),
            const SizedBox(height: 14),
            _DetailRow(
              icon: Icons.timer_outlined,
              label: 'Durasi',
              value: '${booking.durasi} jam',
            ),
            const SizedBox(height: 20),

            // Total harga
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Pembayaran',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    _formatRupiah(booking.totalHarga),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),

            // Aksi jika masih aktif
            if (isAktif) ...[
              const SizedBox(height: 20),
              Row(
                children: [
                  // Tombol Batalkan
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        context
                            .read<BookingProvider>()
                            .batalkanBooking(booking.id);

                        // Tambahkan notifikasi otomatis saat booking dibatalkan
                        context
                            .read<NotificationProvider>()
                            .tambahNotifikasi(
                          judul: 'Booking Dibatalkan ⚠️',
                          pesan:
                              'Booking ${booking.namaLapangan} telah berhasil dibatalkan.',
                          tipe: 'batal',
                        );

                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                const Text('Booking berhasil dibatalkan.'),
                            backgroundColor: Colors.redAccent,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.redAccent),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.cancel_outlined,
                                color: Colors.redAccent, size: 18),
                            SizedBox(width: 6),
                            Text(
                              'Batalkan',
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Tombol Selesaikan
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        context
                            .read<BookingProvider>()
                            .selesaikanBooking(booking.id);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                                'Booking ditandai sebagai selesai. ✅'),
                            backgroundColor: Colors.green.shade700,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle_outline,
                                color: Colors.white, size: 18),
                            SizedBox(width: 6),
                            Text(
                              'Selesaikan',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Widget baris detail booking (ikon + label + value).
class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: Colors.grey.shade500),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
