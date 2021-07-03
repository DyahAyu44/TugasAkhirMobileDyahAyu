//class supir
class Supir {
  //atribut dari supir
  int _id;
  String _nama;
  int _umur;
  String _alamat;

  int get id => _id; //getter id

  String get nama => this._nama; //getter nama
  set nama(String value) => this._nama = value; //setter nama

  get umur => this._umur; //getter umur
  set umur(value) => this._umur = value; //setter umur

  String get alamat => this._alamat; //getter alamat
  set alamat(String value) => this._alamat = value; //setter alamat

  // konstruktor versi 1
  Supir(this._nama, this._umur, this._alamat);

  // konstruktor versi 2: konversi dari Map ke Item
  Supir.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nama = map['nama'];
    this._umur = map['umur'];
    this._alamat = map['alamat'];
  }

// konversi dari Item ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['nama'] = nama;
    map['umur'] = umur;
    map['alamat'] = alamat;
  }
}
