import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// BantuanFaqPage menampilkan daftar pertanyaan umum (FAQ)
/// dan informasi kontak customer service.
class BantuanFaqPage extends StatelessWidget {
  const BantuanFaqPage({super.key});

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
          'Bantuan & FAQ',
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
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.help_outline_rounded,
                      color: AppColors.primary,
                      size: 40,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Ada pertanyaan?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Temukan jawaban di bawah atau hubungi kami.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // FAQ Section
              const Text(
                'Pertanyaan Umum',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),

              _FaqTile(
                question: 'Bagaimana cara melakukan booking lapangan?',
                answer:
                    'Pilih lapangan yang ingin Anda booking dari halaman Lapangan, '
                    'lalu buka detail lapangan dan tekan tombol "Booking Sekarang". '
                    'Isi form booking (jam, durasi, nama pemesan) dan tekan "Konfirmasi Booking".',
              ),
              _FaqTile(
                question: 'Bagaimana cara membatalkan booking?',
                answer:
                    'Buka halaman Booking Saya, pilih booking yang ingin dibatalkan, '
                    'lalu tekan tombol "Batalkan" pada detail booking. '
                    'Pembatalan hanya bisa dilakukan jika status booking masih "Aktif".',
              ),
              _FaqTile(
                question: 'Berapa lama durasi minimal booking?',
                answer:
                    'Durasi minimal booking adalah 1 jam. Anda dapat memesan hingga '
                    'maksimal 5 jam dalam satu sesi booking.',
              ),
              _FaqTile(
                question: 'Metode pembayaran apa saja yang didukung?',
                answer:
                    'Saat ini FutsalKu mendukung pembayaran tunai di tempat (Cash on Arrival). '
                    'Pembayaran digital (transfer bank, e-wallet) akan segera tersedia.',
              ),
              _FaqTile(
                question: 'Apakah bisa mengubah jadwal booking?',
                answer:
                    'Untuk saat ini, Anda perlu membatalkan booking yang ada dan membuat '
                    'booking baru dengan jadwal yang diinginkan. Fitur reschedule sedang dalam pengembangan.',
              ),

              const SizedBox(height: 28),

              // Kontak Customer Service
              const Text(
                'Pusat Bantuan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),

              // WhatsApp
              _KontakCard(
                icon: Icons.chat_outlined,
                iconColor: Colors.green.shade700,
                iconBgColor: Colors.green.shade50,
                title: 'Chat via WhatsApp',
                subtitle: '+62 812-3456-7890',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Membuka WhatsApp...'),
                      backgroundColor: Colors.green.shade700,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),

              // Email
              _KontakCard(
                icon: Icons.email_outlined,
                iconColor: Colors.blue.shade700,
                iconBgColor: Colors.blue.shade50,
                title: 'Kirim Email',
                subtitle: 'cs@futsalku.id',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Membuka aplikasi email...'),
                      backgroundColor: Colors.blue.shade700,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),

              // Telepon
              _KontakCard(
                icon: Icons.phone_outlined,
                iconColor: AppColors.primary,
                iconBgColor: AppColors.primaryLight,
                title: 'Hubungi Telepon',
                subtitle: '(0541) 123-456',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Membuka dialer...'),
                      backgroundColor: AppColors.primary,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

/// ExpansionTile FAQ yang distilisasi agar konsisten dengan tema aplikasi.
class _FaqTile extends StatelessWidget {
  final String question;
  final String answer;

  const _FaqTile({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          childrenPadding:
              const EdgeInsets.fromLTRB(16, 0, 16, 14),
          leading: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.question_answer_outlined,
              color: AppColors.primary,
              size: 16,
            ),
          ),
          title: Text(
            question,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          iconColor: AppColors.primary,
          collapsedIconColor: Colors.grey.shade400,
          children: [
            Text(
              answer,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Kartu kontak customer service.
class _KontakCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _KontakCard({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right,
                color: Colors.grey.shade400, size: 20),
          ],
        ),
      ),
    );
  }
}
