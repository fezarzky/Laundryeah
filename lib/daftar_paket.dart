import 'package:flutter/material.dart';

class DaftarHarga extends StatelessWidget {
  static const routeName = '/daftar_paket';

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      centerTitle: true,
      title: Text(
        "DAFTAR HARGA",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );

    final List<Widget> priceTables = [
      buildPriceTable('Paket Cuci Baju', [
        {'name': 'VVIP', 'price': 'Rp 20,000'},
        {'name': 'VIP', 'price': 'Rp 10,000'},
        {'name': 'Reguler', 'price': 'Rp 5,000'},
      ]),
      buildPriceTable('Paket Cuci Sepatu', [
        {'name': 'VVIP', 'price': 'Rp 11,000'},
        {'name': 'VIP', 'price': 'Rp 8,000'},
        {'name': 'Reguler', 'price': 'Rp 5,000'},
      ]),
      buildPriceTable('Paket Setrika', [
        {'name': 'VVIP', 'price': 'Rp 10,000'},
        {'name': 'VIP', 'price': 'Rp 5,000'},
        {'name': 'Reguler', 'price': 'Rp 3,000'},
      ]),
    ];

    final body = ListView(
      children: priceTables,
    );

    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }

  Widget buildPriceTable(String title, List<Map<String, String>> data) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      shadowColor: Colors.black,
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Divider(),
          Column(
            children: data
                .map((item) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(item['name'] ?? ''),
                          SizedBox(
                              width: 10), // Add space between name and price
                          Text(item['price'] ?? ''),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
