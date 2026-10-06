class Lapangan {
  final String nama;
  final String harga;
  final String rating;

  const Lapangan({
    required this.nama,
    required this.harga,
    required this.rating,
  });
}

/// Data dummy lapangan populer untuk ditampilkan di Home.
const List<Lapangan> lapanganPopulerDummy = [
  Lapangan(nama: 'Lapangan A', harga: 'Rp100.000/jam', rating: '4.8'),
  Lapangan(nama: 'Lapangan B', harga: 'Rp120.000/jam', rating: '4.6'),
  Lapangan(nama: 'Lapangan C', harga: 'Rp90.000/jam', rating: '4.9'),
];

/// Data dummy semua lapangan untuk ditampilkan di halaman Lapangan.
const List<Lapangan> semuaLapanganDummy = [
  Lapangan(nama: 'Lapangan A', harga: 'Rp100.000/jam', rating: '4.8'),
  Lapangan(nama: 'Lapangan B', harga: 'Rp120.000/jam', rating: '4.6'),
  Lapangan(nama: 'Lapangan C', harga: 'Rp90.000/jam', rating: '4.9'),
  Lapangan(nama: 'Lapangan D', harga: 'Rp110.000/jam', rating: '4.7'),
  Lapangan(nama: 'Lapangan E', harga: 'Rp95.000/jam', rating: '4.5'),
  Lapangan(nama: 'Lapangan F', harga: 'Rp130.000/jam', rating: '4.8'),
];
