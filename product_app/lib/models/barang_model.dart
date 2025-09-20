class Barang {
  int? id;
  String namaBarang;
  int kategoriId;
  int stok;
  String? kelompokBarang;
  int harga;

  Barang({this.id, required this.namaBarang, required this.kategoriId, required this.stok, this.kelompokBarang, required this.harga});

  factory Barang.fromJson(Map<String, dynamic> json) => Barang(
    id: json['id'],
    namaBarang: json['nama_barang'],
    kategoriId: json['kategori_id'],
    stok: json['stok'],
    kelompokBarang: json['kelompok_barang'],
    harga: int.parse(json['harga'].toString()),

  );

  Map<String, dynamic> toJson() => {
    'nama_barang': namaBarang,
    'kategori_id': kategoriId,
    'stok': stok,
    'kelompok_barang': kelompokBarang,
    'harga': harga,
  };
}
