import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tugas_akhir_dyah_ayu/dbhelper.dart';
import 'package:tugas_akhir_dyah_ayu/entryformsupir.dart';
import 'dart:async';

import 'supir.dart';

//pendukung program asinkron
class HomeSupir extends StatefulWidget {
  // class HomeSupir
  @override
  HomeSupirState createState() => HomeSupirState();
}

class HomeSupirState extends State<HomeSupir> {
  //class HomeSupirState
  DbHelper dbHelper = DbHelper(); //memanggil class DbHelper
  int count = 0;
  List<Supir> supirList; //membuat list supir
  @override
  Widget build(BuildContext context) {
    if (supirList == null) {
      //jika list supir sama dengan nulll maka supirlist dimasukkan ke dalam list
      supirList = List<Supir>();
    }
    return Scaffold(
      appBar: AppBar(
        //appBar
        title: Text('Daftar Supir'), //judul appBar
      ),
      body: Column(children: [
        //kolom
        Expanded(
          child: createListView(), //memanggil method createListView
        ),
        Container(
          //container
          alignment:
              Alignment.bottomCenter, //alignment berada pada tengah bawah
          child: SizedBox(
            //sizeBox
            width: double.infinity, //mengatur lebar sizeBox
            child: RaisedButton(
              //button
              child: Text("Tambah Supir"), //text pada button
              onPressed: () async {
                //ketika di klik
                var item = await navigateToEntryForm(
                    context, null); //menuju pada entry form pada supir
                if (item != null) {
                  //jika item yang dimasukkan tidak sama dengan null
//TODO 2 Panggil Fungsi untuk Insert ke DB
                  int result = await dbHelper
                      .insertSupir(item); //maka akan dimasukkan pada list
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

  Future<Supir> navigateToEntryForm(BuildContext context, Supir supir) async {
    //menuju pada entry form pada supir
    //membuat variabel result
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(
          supir); //mengembalikan nilai dari method entryform dengan parameter supir yaitu isi dari supir
    }));
    return result; //mengembalikan nilai result
  }

  ListView createListView() {
    //listView
    TextStyle textStyle =
        Theme.of(context).textTheme.headline5; //mengedit style dari text
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          //card
          color: Colors.white, //warna card
          elevation: 2.0,
          child: ListTile(
            //listTile
            leading: CircleAvatar(
              backgroundColor: Colors.pink[200], //warna background leading
              child: Icon(Icons.person), //menambahkan icon person
            ),
            title: Text(
              //membuat text
              this
                  .supirList[index]
                  .nama, //isi text list supir berdasarkan index nama
              style: textStyle, //mengatur style text
            ),
            subtitle: Text(this
                .supirList[index]
                .umur), //membuat text subtitle dengan isi list umur berdasarkan index
            trailing: GestureDetector(
              child: Icon(Icons.delete), //menambahkan icon delete
              onTap: () async {
                //ketika icon di klik
//TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Item
                //membuat variabale result
                int result =
                    await dbHelper.deleteSupir(this.supirList[index].id);
                if (result > 0) {
                  updateListView(); //memanggil method updateListView
                }
              },
            ),
            onTap: () async {
              //ketika card di klik
              //membuat variabel untuk menampung list yang dihapus
              var item =
                  await navigateToEntryForm(context, this.supirList[index]);
//TODO 4 Panggil Fungsi untuk Edit data
              int result = await dbHelper.updateSupir(item); //mengahapus list
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
      Future<List<Supir>> supirListFuture = dbHelper.getSupirList();
      supirListFuture.then((supirList) {
        setState(() {
          this.supirList = supirList;
          this.count = supirList.length;
        });
      });
    });
  }
}
