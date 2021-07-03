import 'package:flutter/material.dart';

import 'mobil.dart';

//class entryform dari mobil
class EntryForm extends StatefulWidget {
  final Mobil mobil;
  EntryForm(this.mobil);
  @override
  EntryFormState createState() => EntryFormState(this.mobil);
}

//class controller
class EntryFormState extends State<EntryForm> {
  Mobil mobil;
  EntryFormState(this.mobil);
  TextEditingController merkController =
      TextEditingController(); //controller dari merk
  TextEditingController typeController =
      TextEditingController(); //controller dari type
  TextEditingController warnaController =
      TextEditingController(); //controller dari warna
  TextEditingController hargaController =
      TextEditingController(); //controller dari harga
  TextEditingController stockController =
      TextEditingController(); //controller dari stock
  @override
  Widget build(BuildContext context) {
    //kondisi
    //jika mobil tidak sama dengan null maka merk, type, warna, harga, stock di masukkan ke dalam controller masing masing
    if (mobil != null) {
      merkController.text = mobil.merk;
      typeController.text = mobil.type;
      warnaController.text = mobil.warna;
      hargaController.text = mobil.harga.toString();
      stockController.text = mobil.stock.toString();
    }
    //merubah
    return Scaffold(
        appBar: AppBar(
          //appBar
          title:
              mobil == null ? Text('Tambah') : Text('Ubah'), //text pada appBar
          leading:
              Icon(Icons.keyboard_arrow_left), //menambahkan icon arrow left
        ),
        body: Padding(
          //padding
          padding: EdgeInsets.only(
              top: 15.0, left: 10.0, right: 10.0), //mengatur jarak padding
          child: ListView(
            children: <Widget>[
              // merk
              Padding(
                //padding
                padding: EdgeInsets.only(
                    top: 20.0, bottom: 20.0), //mengatur jarak padding
                child: TextField(
                  controller: merkController, //controller
                  keyboardType:
                      TextInputType.text, //mengatur keyboard dengan type text
                  decoration: InputDecoration(
                    labelText: 'Merk Mobil', //text pada label
                    border: OutlineInputBorder(
                      //border garis luar
                      borderRadius: BorderRadius.circular(
                          5.0), //mengatur border dengan radius circular
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              //type
              Padding(
                //padding
                padding: EdgeInsets.only(
                    top: 20.0, bottom: 20.0), //mengatur jarak padding
                child: TextField(
                  controller: typeController, //controller
                  keyboardType:
                      TextInputType.text, //mengatur keyboard dengan type text
                  decoration: InputDecoration(
                    labelText: 'Type Mobil', //text pada label
                    border: OutlineInputBorder(
                      //border garis luar
                      borderRadius: BorderRadius.circular(
                          5.0), //mengatur border dengan radius circular
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              //warna
              Padding(
                //padding
                padding: EdgeInsets.only(
                    top: 20.0, bottom: 20.0), //mengatur jarak padding
                child: TextField(
                  controller: warnaController, //controller
                  keyboardType:
                      TextInputType.text, //mengatur keyboard dengan type text
                  decoration: InputDecoration(
                    labelText: 'Warna Mobil', //text pada label
                    border: OutlineInputBorder(
                      //border garis luar
                      borderRadius: BorderRadius.circular(
                          5.0), //mengatur border dengan radius circular
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              // harga
              Padding(
                //padding
                padding: EdgeInsets.only(
                    top: 20.0, bottom: 20.0), //mengatur jarak padding
                child: TextField(
                  controller: hargaController, //controller
                  keyboardType: TextInputType
                      .number, //mengatur keyboard dengan type number
                  decoration: InputDecoration(
                    labelText: 'Harga Sewa', //text pada label
                    border: OutlineInputBorder(
                      //border garis luar
                      borderRadius: BorderRadius.circular(
                          5.0), //mengatur border dengan radius circular
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              //stock
              Padding(
                //padding
                padding: EdgeInsets.only(
                    top: 20.0, bottom: 20.0), //mengatur jarak padding
                child: TextField(
                  controller: stockController, //controller
                  keyboardType: TextInputType
                      .number, //mengatur keyboard dengan type number
                  decoration: InputDecoration(
                    labelText: 'Stock', //text pada label
                    border: OutlineInputBorder(
                      //border garis luar
                      borderRadius: BorderRadius.circular(
                          5.0), //mengatur border dengan radius circular
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              // tombol button
              Padding(
                padding: EdgeInsets.only(
                    top: 20.0, bottom: 20.0), //mengatur jarak padding
                child: Row(
                  children: <Widget>[
                    // tombol simpan
                    Expanded(
                      child: RaisedButton(
                        //button
                        color: Theme.of(context)
                            .primaryColorDark, //mengatur warna button
                        textColor: Theme.of(context)
                            .primaryColorLight, //mengatur warna text button
                        child: Text(
                          'Save', //text button
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          //ketika di klik
                          if (mobil == null) {
                            //jika mobil sama degan null
                            // tambah data
                            mobil = Mobil(
                                merkController.text,
                                typeController.text,
                                warnaController.text,
                                int.parse(hargaController.text),
                                int.parse(stockController.text));
                          } else {
                            //jika mobil tidak sama dengan null
                            // ubah data
                            mobil.merk = merkController.text;
                            mobil.type = typeController.text;
                            mobil.warna = warnaController.text;
                            mobil.harga = hargaController.text;
                            mobil.stock = stockController.text;
                          }
                          // kembali ke layar sebelumnya dengan membawa objek mobil
                          Navigator.pop(context, mobil);
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    // tombol batal
                    Expanded(
                      child: RaisedButton(
                        //button
                        color: Theme.of(context)
                            .primaryColorDark, //mengatur warna button
                        textColor: Theme.of(context)
                            .primaryColorLight, //mengatur warna text buton
                        child: Text(
                          'Cancel', //text button
                          textScaleFactor: 1.5,
                        ),
                        //ketika di klik akan kembali pada halaman sebelumnya
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
