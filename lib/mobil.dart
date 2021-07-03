//class mobil
class Mobil {
  //atribut dari mobil
  int _id;
  String _merk;
  String _type;
  String _warna;
  int _harga;
  int _stock;

  int get id => _id; //getter id

  String get merk => this._merk; //getter merk
  set merk(String value) => this._merk = value; //setter merk

  String get type => this._type; //getter type
  set type(String value) => this._type = value; //setter type

  String get warna => this._warna; //getter warna
  set warna(String value) => this._warna = value; //setter warna

  get harga => this._harga; //getter harga
  set harga(value) => this._harga = value; //setter harga

  get stock => this._stock; //getter stock
  set stock(value) => this._stock = value; //setter stock

// konstruktor versi 1
  Mobil(this._merk, this._type, this._warna, this._harga, this._stock);

// konstruktor versi 2: konversi dari Map ke Item
  Mobil.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._merk = map['merk'];
    this._type = map['type'];
    this._warna = map['warna'];
    this._harga = map['harga'];
    this._stock = map['stock'];
  }

// konversi dari Item ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['merk'] = merk;
    map['type'] = type;
    map['warna'] = warna;
    map['harga'] = harga;
    map['stock'] = stock;
    return map;
  }
}
