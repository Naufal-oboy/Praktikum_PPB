import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/lapangan.dart';
import '../providers/booking_provider.dart';
import '../providers/user_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Filter lapangan populer berdasarkan pencarian
    final filteredLapangan = lapanganPopulerDummy.where((lapangan) {
      return lapangan.nama.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      // SafeArea – memastikan konten tidak tertutup notch/status bar
      body: SafeArea(
        // SingleChildScrollView – agar seluruh konten home bisa di-scroll
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // GreetingSection – menampilkan sapaan dan nama user
                GreetingSection(
                  namaUser: context.watch<UserProvider>().nama,
                  fotoProfil: context.watch<UserProvider>().fotoProfil,
                ),
                const SizedBox(height: 20),
                // SearchField – kolom pencarian lapangan
                SearchField(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                // PromoBanner – menampilkan informasi promo booking
                const PromoBanner(),
                const SizedBox(height: 24),
                // SectionTitle – judul daftar lapangan populer
                const SectionTitle('Lapangan Populer'),
                const SizedBox(height: 12),
                // LapanganPopulerList – daftar lapangan yang dapat di-scroll horizontal
                LapanganPopulerList(daftarLapangan: filteredLapangan),
                const SizedBox(height: 24),
                // SectionTitle – judul jadwal booking terdekat
                const SectionTitle('Jadwal Terdekat'),
                const SizedBox(height: 12),
                // JadwalTerdekatSection – menampilkan jadwal booking terdekat
                const JadwalTerdekatSection(),
                const SizedBox(height: 24),
                // SectionTitle – judul booking yang sedang aktif
                const SectionTitle('Booking Aktif'),
                const SizedBox(height: 12),
                // BookingAktifCard – menampilkan detail booking aktif
                // Consumer – Modul 4: memantau perubahan pada BookingProvider
                Consumer<BookingProvider>(
                  builder: (context, bookingProv, _) {
                    final aktif = bookingProv.bookingAktif;
                    if (aktif.isNotEmpty) {
                      // Ambil booking aktif terbaru (pertama dalam list)
                      final booking = aktif.first;
                      return BookingAktifCard(
                        namaLapangan: booking.namaLapangan,
                        jadwal: booking.jadwalFormatted,
                        status: booking.status,
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/booking');
                        },
                      );
                    }
                    // Empty State – ketika belum ada booking aktif
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 24,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            size: 40,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Belum ada jadwal booking aktif',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: 160,
                            height: 36,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/lapangan',
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 0,
                                textStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              child: const Text('Pesan Lapangan'),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          const routes = {0: '/', 1: '/lapangan', 2: '/booking', 3: '/profil'};
          if (index != 0) {
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
