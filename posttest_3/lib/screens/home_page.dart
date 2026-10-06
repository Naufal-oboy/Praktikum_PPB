import 'package:flutter/material.dart';

import '../models/lapangan.dart';
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
                const GreetingSection(namaUser: 'User'),
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
                const BookingAktifCard(),
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
