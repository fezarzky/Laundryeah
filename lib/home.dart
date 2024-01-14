import 'package:flutter/material.dart';
import 'package:flutter_laundryapp/daftar_paket.dart';
import 'package:flutter_laundryapp/pemesanan_laundry.dart';
import 'package:flutter_laundryapp/profile.dart';
import 'package:flutter_laundryapp/riwayat_pemesanan.dart';
import 'package:flutter_laundryapp/about_screen.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';

  String userEmail;

  final List<String> catNames = [
    "Pemesanan Laundry",
    "Daftar Harga",
    "About", // Added "About" item
  ];
  final List<Color> catColors = [
    Color(0xFF61BDFD),
    Color(0xFF61DFBD),
    Colors.orange,
  ]; // Adjusted colors
  final List<Icon> catIcons = [
    Icon(Icons.shopping_cart, color: Colors.white, size: 20),
    Icon(Icons.money, color: Colors.white, size: 20),
    Icon(Icons.info, color: Colors.white, size: 20), // Added "About" icon
  ];

  final List<String> imgList = ['Laundry'];

  HomePage(this.userEmail, {Key? key}) : super(key: key);

  BoxDecoration buildGradientDecoration(Color startColor, Color endColor) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        colors: [startColor, endColor],
      ),
      borderRadius: BorderRadius.circular(15.0), // Adjust the border radius
    );
  }

  @override
  Widget build(BuildContext context) {
    String trimmedEmail = userEmail.split('@').first;
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 30),
            decoration: BoxDecoration(
              color: Color(0xFF674AEF),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(left: 3, bottom: 15),
                  child: Text(
                    "Selamat datang, $trimmedEmail!",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      wordSpacing: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50, left: 25, right: 25),
            child: Column(
              children: catNames.asMap().entries.map((entry) {
                int index = entry.key;
                String name = entry.value;
                Color color = catColors[index];
                Icon icon = catIcons[index];

                return GestureDetector(
                  onTap: () {
                    if (index == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PemesananLaundry(),
                        ),
                      );
                    } else if (index == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DaftarHarga(),
                        ),
                      );
                    } else if (index == 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AboutScreen(),
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 80,
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: catColors[index],
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 15),
                        icon,
                        SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        iconSize: 32,
        selectedItemColor: Color(0xFF674AEF),
        selectedFontSize: 18,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Riwayat pemesanan",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            // Home screen
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RiwayatPemesanan()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Profile()),
            );
          }
        },
      ),
    );
  }
}
