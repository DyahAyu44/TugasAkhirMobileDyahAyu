import 'package:flutter/material.dart';

import 'supir.dart';

//class entryform dari supir
class EntryForm extends StatefulWidget {
  final Supir supir;
  EntryForm(this.supir);
  @override
  EntryFormState createState() => EntryFormState(this.supir);
}

//class controller
class EntryFormState extends State<EntryForm> {
  Supir supir;
  EntryFormState(this.supir);
  TextEditingController namaController =
      TextEditingController(); //controller dari nama
  TextEditingController umurController =
      TextEditingController(); //controller dari umur
  TextEditingController alamatController =
      TextEditingController(); //controller dari alamat
  @override
  Widget build(BuildContext context) {
    //kondisi
    if (supir != null) {
      //jika supit tidak sama dengan null maka nama, umur, alamat di masukkan ke dalam controller masing masing
      namaController.text = supir.nama;
      umurController.text = supir.umur.toString();
      alamatController.text = supir.alamat;
    }
    //merubah
    return Scaffold(
        appBar: AppBar(
          //appBar
          title:
              supir == null ? Text('Tambah') : Text('Ubah'), //text pada appBar
          leading:
              Icon(Icons.keyboard_arrow_left), //menambahkan icon arrow left
        ),
        body: Padding(
          //padding
          padding: EdgeInsets.only(
              top: 15.0, left: 10.0, right: 10.0), //mengatur jarak padding
          child: ListView(
            //listView
            children: <Widget>[
              // nama
              Padding(
                //padding
                padding: EdgeInsets.only(
                    top: 20.0, bottom: 20.0), //mengatur jarak padding
                child: TextField(
                  controller: namaController, //controller
                  keyboardType:
                      TextInputType.text, //mengatur keyboard dengan type text
                  decoration: InputDecoration(
                    labelText: 'Nama', //text pada label
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
              //umur
              Padding(
                //padding
                padding: EdgeInsets.only(
                    top: 20.0, bottom: 20.0), //mengatur jarak padding
                child: TextField(
                  controller: umurController, //controller
                  keyboardType: TextInputType
                      .number, //mengatur keyboard dengan type number
                  decoration: InputDecoration(
                    labelText: 'Umur', //text pada label
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
              //alamat
              Padding(
                //padding
                padding: EdgeInsets.only(
                    top: 20.0, bottom: 20.0), //mengatur jarak padding
                child: TextField(
                  controller: alamatController, //controller
                  keyboardType:
                      TextInputType.text, //mengatur keyboard dengan type text
                  decoration: InputDecoration(
                    labelText: 'Alamat', //text pada label
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
                          if (supir == null) {
                            //jika supir sama degan null
                            // tambah data
                            supir = Supir(
                                namaController.text,
                                int.parse(umurController.text),
                                alamatController.text);
                          } else {
                            //jika supir tidak sama dengan null
                            // ubah data
                            supir.nama = namaController.text;
                            supir.umur = umurController.text;
                            supir.alamat = alamatController.text;
                          }
                          // kembali ke layar sebelumnya dengan membawa objek supir
                          Navigator.pop(context, supir);
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
                        onPressed: () {
                          //ketika di klik akan kembali pada halaman sebelumnya
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
