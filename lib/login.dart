import 'package:flutter/material.dart';
import 'package:flutter_laundryapp/daftar_paket.dart';
import 'package:flutter_laundryapp/home.dart';
import 'package:flutter_laundryapp/register.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;

  Future<void> login() async {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(userCredential.user?.email ?? ""),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Email atau Password Anda Salah!'),
            action: SnackBarAction(
              label: 'Tutup',
              onPressed: () {},
            ),
          ),
        );

        print("Error: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Positioned(
                top: 0,
                child: Image1(
                  imgHeight: MediaQuery.of(context).size.height * 0.4,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan Email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.key),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan Password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 35),
              MaterialButton(
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                onPressed: login,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Register()),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't Have Account? "),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                    child: const Text('Registrasi'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Image1 extends StatelessWidget {
  final double? imgHeight;

  Image1({this.imgHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset('assets/Group_1yeah-removebg-preview.png'),
      width: MediaQuery.of(context).size.width,
      height: imgHeight,
    );
  }
}

class CustomButton extends StatelessWidget {
  final String btnText;
  final VoidCallback onBtnPressed; // Mengganti 'Function' dengan 'VoidCallback'

  CustomButton({required this.btnText, required this.onBtnPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              btnText,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(width: 10),
            Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ],
        ),
      ),
      onPressed: onBtnPressed,
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  child: Image1(
                    imgHeight: MediaQuery.of(context).size.height * 0.7,
                  ),
                ),
                Positioned(
                  bottom: 3,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.37,
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Aplikasi ini hadir untuk memberikan kemudahan bagi anda yang sibuk bekerja dan Kuliah maupun kegiatan lain dalam Mencuci Baju,Mencuci Sepatu Dan Setrika ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge, // Mengganti bodyText1 dengan bodyLarge
                        ),
                        SizedBox(height: 40),
                        CustomButton(
                          btnText: 'Getting Started',
                          onBtnPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
