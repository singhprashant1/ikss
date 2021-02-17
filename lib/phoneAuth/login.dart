import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ikss/phoneAuth/loginotp.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController numberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void readData(String number) async {
    var dbRef = await FirebaseDatabase.instance.reference().child("Cust");
    dbRef
        .orderByChild("number")
        .equalTo(number)
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        Toast.show("User not registerd", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      } else {
        final formState = _formKey.currentState;
        if (formState.validate()) {
          formState.save();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LoginOtp(number: number)));
        }
      }
    });
  }

  @override
  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Image(
        //   image: AssetImage("ASSETS/logo.png"),
        // ),
        // backgroundColor: Hexcolor("#f9692d"),
        backgroundColor: Colors.grey,
      ),
      body: Form(
          key: _formKey,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 50, right: 210),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Phone number',
                          prefixIcon: Icon(Icons.phone),
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(25.0),
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        controller: numberController,
                        validator: (input) {
                          if (input.length < 10)
                            return 'Please enter proper number';
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 280,
                      ),
                      MaterialButton(
                        height: 52,
                        minWidth: 323,
                        color: Colors.blue[900],
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        onPressed: () {
                          var number_entered =
                              "+91" + numberController.text.trim();
                          readData(number_entered);
                        },
                        splashColor: Colors.redAccent,
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
