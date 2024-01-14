import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  _launchURL(
      String nama, String jenisCuci, String paketTipe, String berat) async {
    var message =
        '==== Laundry ==== \nPembatalan Pemesanan Laundry\nNama: $nama\nJenis Cuci: $jenisCuci\nPaket Tipe: $paketTipe\nBerat: $berat';
    var encodedMessage = Uri.encodeFull(message);
    var url = 'https://wa.me/+6281931730748?text=$encodedMessage';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchLocation() async {
    var latitude = -7.094583; // Replace with the actual latitude
    var longitude = 110.419639; // Replace with the actual longitude

    var url = 'https://maps.google.com/?q=$latitude,$longitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var nama = "nama"; // Ganti dengan nama pengguna yang sesuai
    var jenisCuci = "jenis_cuci"; // Ganti dengan jenis cuci yang sesuai
    var paketTipe = "paket_tipe"; // Ganti dengan tipe paket yang sesuai
    var berat = "berat"; // Ganti dengan berat laundry yang sesuai

    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'LaundryApp',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Version 1.0.0',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Aplikasi LaundryApp adalah aplikasi yang memfasilitasi pengelolaan dan pengalaman pelanggan dalam layanan laundry. Dibuat dengan Flutter dan database Firestore, dan dengan antarmuka yang ramah pengguna, aplikasi ini memungkinkan pengguna untuk dengan mudah memesan layanan laundry, serta melacak status pesanan mereka secara real-time.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Contact Person:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () => _launchURL(nama, jenisCuci, paketTipe, berat),
              child: Row(
                children: [
                  Icon(
                    Icons.message,
                    color: Colors.green,
                    size: 24.0,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Call Now',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Location:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: _launchLocation,
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.blue,
                    size: 24.0,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'View Location',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
