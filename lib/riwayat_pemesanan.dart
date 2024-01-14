import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RiwayatPemesanan extends StatefulWidget {
  static const routeName = '/riwayat';

  @override
  _RiwayatPemesananState createState() => _RiwayatPemesananState();
}

class _RiwayatPemesananState extends State<RiwayatPemesanan> {
  late Stream<List<dynamic>> _riwayatStream;

  @override
  void initState() {
    super.initState();
    _riwayatStream = _getRiwayatStream();
  }

  Stream<List<dynamic>> _getRiwayatStream() {
    var user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Stream.value([]);
    }

    CollectionReference ref =
        FirebaseFirestore.instance.collection('Laundrytot');

    Query query = ref.where('uid', isEqualTo: user.uid);

    return query.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Pemesanan'),
      ),
      body: StreamBuilder<List<dynamic>>(
        stream: _riwayatStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No orders available.'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> order = snapshot.data![index];

              return Card(
                elevation: 3,
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text('Nama order: ${order['nama']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Paket: ${order['jenis_laundry']}'),
                      SizedBox(height: 4),
                      Text('Tipe: ${order['jenis_cuci']}'),
                      SizedBox(height: 4),
                      Text('Berat: ${order['berat']} kg'),
                      SizedBox(height: 4),
                      Text('Total Harga: ${order['total_harga']}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
