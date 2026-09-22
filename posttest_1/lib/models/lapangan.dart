
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
