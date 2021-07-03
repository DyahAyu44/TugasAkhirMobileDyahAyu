import 'package:flutter/material.dart';
import 'package:tugas_akhir_dyah_ayu/homeMobil.dart';
import 'package:tugas_akhir_dyah_ayu/homeSupir.dart';

//package letak folder Anda
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //class MyApp
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //menghilangkan debugshow
      title: 'sewa mobil', //judul projek flutter
      theme: ThemeData(
        primarySwatch: Colors.pink, //warna untuk appBar
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              //appBar
              title: Text("PENYEWAAN MOBIL"), //judul appBar
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: "MOBIL", //text pertama
                  ),
                  Tab(
                    text: "SUPIR", //text kedua
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                HomeMobil(), //memanggil class HomeMobil
                HomeSupir(), //memanggil class HomeSupir
              ],
            )),
      ),
    );
  }
}
