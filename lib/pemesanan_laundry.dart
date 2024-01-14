import 'package:flutter/material.dart';
import 'package:flutter_laundryapp/riwayat_pemesanan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PemesananLaundry extends StatefulWidget {
  static const routeName = '/pemesanan_laundry';

  @override
  _PemesananLaundryState createState() => _PemesananLaundryState();
}

class _PemesananLaundryState extends State<PemesananLaundry> {
  String nama = '';
  String? jenis_laundry;
  String? jenis_cuci;
  String tgl_masuk = '';
  String tgl_keluar = '';
  String berat = '';
  String total_harga = '';
  int totalPrice = 0;

  final TextEditingController namaController = new TextEditingController();
  List<String> laundryTypes = ['Cuci Baju', 'Cuci Sepatu', 'Setrika'];
  List<String> jenisCuciOptions = [
    "VVIP (1 Hari)",
    "VIP (2 hari)",
    "Reguler (3 hari)"
  ];
  final _key = GlobalKey<FormState>();
  final beratController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  void check() {
    final form = _key.currentState;
    if (form != null && form.validate()) {
      form.save();

      updateTotalHarga();
    }
  }

  void pesan(String uid) async {
    try {
      // Placeholder function to simulate API call for a specific user
      simulateApiCall(uid);

      // Save order details to Firestore
      postDetailsToFirestore();
    } catch (error) {
      print("Error: $error");
    }
  }

  void simulateApiCall(String uid) {
    // Replace this with your desired functionality
    print("Simulating API call for UID: $uid");
    // You can add any logic or functionality here that you want to simulate.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pemesanan Laundry",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _key,
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 50,
                    child: TextFormField(
                      controller: namaController,
                      validator: (e) {
                        if (e?.isEmpty ?? true) {
                          return "Masukan Nama";
                        }
                        return null;
                      },
                      onSaved: (e) => nama = e ?? "",
                      decoration: InputDecoration(
                        labelText: "Nama Lengkap",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text("Jenis Paket"),
                      SizedBox(width: 30),
                      DropdownButton<String>(
                        value: jenis_laundry,
                        items: laundryTypes.map((type) {
                          return DropdownMenuItem(
                            child: Text(type),
                            value: type,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            jenis_laundry = value;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text("Pilih Tipe"),
                      SizedBox(width: 30),
                      DropdownButton<String>(
                        value: jenis_cuci,
                        items: jenisCuciOptions.map((type) {
                          return DropdownMenuItem(
                            child: Text(type),
                            value: type,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            jenis_cuci = value;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    child: TextFormField(
                      controller: beratController,
                      validator: (e) {
                        if (e?.isEmpty ?? true) {
                          return "Masukan Berat";
                        }
                        return null;
                      },
                      onSaved: (e) => berat = e ?? "",
                      onChanged: (value) {
                        updateTotalHarga();
                      },
                      decoration: InputDecoration(labelText: "Berat"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text("Total Harga: Rp ${total_harga}",
                          style: TextStyle(fontSize: 16)),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          check();
                        },
                        child: Text("Check Harga"),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      postDetailsToFirestore();
                      check();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Berhasil Pesan'),
                          duration: Duration(seconds: 2),
                        ),
                      );

                      await Future.delayed(Duration(seconds: 2));

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RiwayatPemesanan(),
                        ),
                      );
                    },
                    child: Text("Pesan"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void updateTotalHarga() {
    int retrievedPrice = 0;

    if (jenis_laundry == 'Setrika') {
      if (jenis_cuci == 'VVIP') {
        retrievedPrice = 10000;
      } else if (jenis_cuci == 'VIP') {
        retrievedPrice = 5000;
      } else {
        retrievedPrice = 3000;
      }
    } else if (jenis_laundry == 'Cuci Baju') {
      if (jenis_cuci == 'VVIP') {
        retrievedPrice = 20000;
      } else if (jenis_cuci == 'VIP') {
        retrievedPrice = 10000;
      } else {
        retrievedPrice = 5000;
      }
    } else if (jenis_laundry == 'Cuci Sepatu') {
      if (jenis_cuci == 'VVIP') {
        retrievedPrice = 11000;
      } else if (jenis_cuci == 'VIP') {
        retrievedPrice = 8000;
      } else {
        retrievedPrice = 5000;
      }
    }
    totalPrice = retrievedPrice * int.parse(berat);

    setState(() {
      total_harga = totalPrice.toString();
    });
  }

  postDetailsToFirestore() async {
    var user = _auth.currentUser;
    CollectionReference ref =
        FirebaseFirestore.instance.collection('Laundrytot');
    await ref.add({
      'nama': namaController.text,
      'jenis_laundry': jenis_laundry,
      'jenis_cuci': jenis_cuci,
      'berat': beratController.text,
      'total_harga': totalPrice,
      'uid': user!.uid,
    });
  }
}
