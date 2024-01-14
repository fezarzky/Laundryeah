import 'package:flutter/material.dart';
import 'package:flutter_laundryapp/daftar_paket.dart';
import 'package:flutter_laundryapp/home.dart';
import 'package:flutter_laundryapp/login.dart';
import 'package:flutter_laundryapp/pemesanan_laundry.dart';
import 'package:flutter_laundryapp/register.dart';
import 'package:flutter_laundryapp/riwayat_pemesanan.dart';
import 'package:flutter_laundryapp/profile.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // Ensure that Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Laundry',
      theme: ThemeData(
        primaryColor: Colors.purple,
      ),
      home: IntroPage(),
      routes: {
        DaftarHarga.routeName: (context) => DaftarHarga(),
        HomePage.routeName: (context) => HomePage(''),
        PemesananLaundry.routeName: (context) => PemesananLaundry(),
        RiwayatPemesanan.routeName: (context) => RiwayatPemesanan(),
        Login.routeName: (context) => Login(),
        Register.routeName: (context) => Register(),
        Profile.routeName: (context) => Profile(),
      },
    );
  }
}
