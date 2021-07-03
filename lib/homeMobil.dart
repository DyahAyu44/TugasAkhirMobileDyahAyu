import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tugas_akhir_dyah_ayu/dbhelper.dart';
import 'package:tugas_akhir_dyah_ayu/entyformmobil.dart';
import 'dart:async';

import 'mobil.dart';

//pendukung program asinkron
// class HomeMobil
class HomeMobil extends StatefulWidget {
  @override
  HomeMobilState createState() => HomeMobilState();
}

//class HomeMobilState
class HomeMobilState extends State<HomeMobil> {
  DbHelper dbHelper = DbHelper(); //memanggil class DbHelper
  int count = 0;
  List<Mobil> mobilList; //membuat list mobil
  @override
  Widget build(BuildContext context) {
    //jika list mobil sama dengan nulll maka mobillist dimasukkan ke dalam list
    if (mobilList == null) {
      mobilList = List<Mobil>();
    }
    return Scaffold(
      appBar: AppBar(
        //appBar
        title: Text('Daftar Mobil'), //judul appBar
      ),
      //kolom
      body: Column(children: [
        Expanded(
          child: createListView(), //memanggil method createListView
        ),
        //container
        Container(
          alignment:
              Alignment.bottomCenter, //alignment berada pada tengah bawah
          child: SizedBox(
            //sizeBox
            width: double.infinity, //mengatur lebar sizeBox
            child: RaisedButton(
              //button
              child: Text("Tambah Mobil"), //text untuk button
              //ketika di klik
              onPressed: () async {
                var mobil = await navigateToEntryForm(
                    context, null); //menuju pada entry form pada mobil
                //jika item yang dimasukkan tidak sama dengan null
                if (mobil != null) {
//TODO 2 Panggil Fungsi untuk Insert ke DB
                  int result = await dbHelper
                      .insertMobil(mobil); //maka akan dimasukkan pada list
                  if (result > 0) {
                    updateListView(); //memanggil method updateListView
                  }
                }
              },
            ),
          ),
        ),
      ]),
    );
  }

  //menuju pada entry form pada mobil
  Future<Mobil> navigateToEntryForm(BuildContext context, Mobil mobil) async {
    //membuat variabel result
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(
          mobil); //mengembalikan nilai dari method entryform dengan parameter supir yaitu isi dari mobil
    }));
    return result; //mengembalikan nilai result
  }

  //listView
  ListView createListView() {
    TextStyle textStyle =
        Theme.of(context).textTheme.headline5; //mengedit style dari text
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          //card
          color: Colors.white, //mengatur warna card
          elevation: 2.0,
          child: ListTile(
            //listTile
            leading: CircleAvatar(
                backgroundColor: Colors.pink[200], //warna background leading
                child: Icon(Icons.car_rental) //menambahkan icon mobil
                ),
            title: Text(
              //membuat text
              this
                  .mobilList[index]
                  .merk, //isi text list mobil berdasarkan index merk
              style: textStyle, //mengatur style text
            ),
            subtitle: Text(this
                .mobilList[index]
                .harga
                .toString()), //membuat text subtitle dengan isi list type berdasarkan index
            trailing: GestureDetector(
              child: Icon(Icons.delete), //menambahkan icon delete
              onTap: () async {
                //ketika icon di klik
//TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Item
                //membuat variabale result
                int result =
                    await dbHelper.deleteMobil(this.mobilList[index].id);
                if (result > 0) {
                  updateListView(); //memanggil method updateListView
                }
              },
            ),
            //ketika card di klik
            onTap: () async {
              //membuat variabel untuk menampung list yang dihapus
              var mobil =
                  await navigateToEntryForm(context, this.mobilList[index]);
//TODO 4 Panggil Fungsi untuk Edit data
              int result = await dbHelper.updateMobil(mobil); //mengahapus list
              if (result > 0) {
                updateListView(); //memanggil method updateListView
              }
            },
          ),
        );
      },
    );
  }

//update List item
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
//TODO 1 Select data dari DB
      Future<List<Mobil>> mobilListFuture = dbHelper.getMobilList();
      mobilListFuture.then((mobilList) {
        setState(() {
          this.mobilList = mobilList;
          this.count = mobilList.length;
        });
      });
    });
  }
}
