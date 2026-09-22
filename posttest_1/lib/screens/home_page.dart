import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // SafeArea -> memastikan konten tidak tertutup notch/status bar
      body: SafeArea(
        // SingleChildScrollView -> agar seluruh konten home bisa di-scroll
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(height: 16),
                // GreetingSection -> menampilkan sapaan dan nama user.
                GreetingSection(namaUser: 'User'),
                SizedBox(height: 20),
                // SearchField -> kolom pencarian lapangan.
                SearchField(),
                SizedBox(height: 20),
                // PromoBanner -> menampilkan informasi promo booking.
                PromoBanner(),
                SizedBox(height: 24),
                // SectionTitle -> judul daftar lapangan populer.
                SectionTitle('Lapangan Populer'),
                SizedBox(height: 12),
                // LapanganPopulerList -> daftar lapangan yang dapat di-scroll horizontal.
                LapanganPopulerList(),
                SizedBox(height: 24),
                // SectionTitle -> judul jadwal booking terdekat.
                SectionTitle('Jadwal Terdekat'),
                SizedBox(height: 12),
                // JadwalTerdekatSection -> menampilkan jadwal booking terdekat.
                JadwalTerdekatSection(),
                SizedBox(height: 24),
                // SectionTitle -> judul booking yang sedang aktif.
                SectionTitle('Booking Aktif'),
                SizedBox(height: 12),
                // BookingAktifCard -> menampilkan detail booking aktif.
                BookingAktifCard(),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
      // BottomNavBar -> navigasi utama di bagian bawah halaman.
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
