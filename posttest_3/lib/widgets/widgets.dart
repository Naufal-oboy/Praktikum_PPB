import 'package:flutter/material.dart';

import '../models/lapangan.dart';
import '../screens/detail_lapangan_page.dart';
import '../theme/app_theme.dart';

/// Widget untuk menampilkan sapaan dan nama pengguna.
class GreetingSection extends StatelessWidget {
  final String namaUser;

  const GreetingSection({super.key, required this.namaUser});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Halo, $namaUser ',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const Icon(
                    Icons.waving_hand,
                    size: 20,
                    color: AppColors.primary,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'Mau main futsal hari ini?',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            border: Border.all(color: AppColors.primary, width: 1.5),
            borderRadius: BorderRadius.circular(22),
          ),
          child: const Icon(Icons.person, color: AppColors.primary),
        ),
      ],
    );
  }
}

/// Widget untuk menampilkan kolom pencarian.
class SearchField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  
  const SearchField({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Cari lapangan...',
        hintStyle: TextStyle(color: Colors.grey.shade400),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Icon(Icons.search, size: 24, color: Colors.grey.shade400),
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

/// Widget untuk menampilkan banner promo.
class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Row(
            children: [
              Icon(Icons.local_fire_department, color: Colors.white, size: 22),
              SizedBox(width: 8),
              Text(
                'PROMO MINGGU INI',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Diskon booking 20% untuk semua lapangan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget untuk menampilkan judul bagian (section).
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}

/// Widget kartu untuk menampilkan informasi singkat lapangan.
class LapanganCard extends StatelessWidget {
  final Lapangan lapangan;

  const LapanganCard({super.key, required this.lapangan});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailLapanganPage(lapangan: lapangan),
          ),
        );
      },
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                'assets/images/lapangan.jpg',
                width: double.infinity,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              lapangan.nama,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Color.fromARGB(255, 255, 238, 0),
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  lapangan.rating,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              lapangan.harga,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget untuk menampilkan daftar lapangan populer secara horizontal.
class LapanganPopulerList extends StatelessWidget {
  final List<Lapangan> daftarLapangan;

  const LapanganPopulerList({
    super.key,
    this.daftarLapangan = lapanganPopulerDummy,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: daftarLapangan.map((lapangan) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: LapanganCard(lapangan: lapangan),
          );
        }).toList(),
      ),
    );
  }
}

/// Widget untuk menampilkan jadwal lapangan terdekat yang tersedia.
class JadwalTerdekatSection extends StatelessWidget {
  final List<String> jamTersedia;

  const JadwalTerdekatSection({
    super.key,
    this.jamTersedia = const ['16:00', '18:00', '20:00', '21:00'],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.access_time, size: 18, color: Colors.grey.shade700),
              const SizedBox(width: 6),
              Text(
                'Jam tersedia hari ini di Lapangan A',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: jamTersedia.map((jam) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  jam,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

/// Widget kartu untuk menampilkan informasi booking yang sedang aktif.
class BookingAktifCard extends StatelessWidget {
  final String namaLapangan;
  final String jadwal;
  final String status;

  const BookingAktifCard({
    super.key,
    this.namaLapangan = 'Lapangan A',
    this.jadwal = '28 September 2026 • 19:00 - 21:00',
    this.status = 'Dikonfirmasi',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.sports_soccer, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  namaLapangan,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  jadwal,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget navigasi bawah aplikasi (Bottom Navigation Bar).
class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const AppBottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        // BoxShadow – Modul 3: bayangan pada navigation bar
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildItem(context, 0, Icons.home_rounded, 'Home'),
              _buildItem(context, 1, Icons.stadium_rounded, 'Lapangan'),
              _buildItem(context, 2, Icons.receipt_long_rounded, 'Booking'),
              _buildItem(context, 3, Icons.person_rounded, 'Profil'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    int index,
    IconData icon,
    String label,
  ) {
    final bool isActive = currentIndex == index;
    final Color color = isActive ? AppColors.primary : Colors.grey.shade400;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.normal,
            ),
          ),
          const SizedBox(height: 0),
        ],
      ),
    );
  }
}
