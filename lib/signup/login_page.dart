import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_devfest/universal/dev_scaffold.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "/loginpage";
  @override
  LoginPageState createState() {
    return LoginPageState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class LoginPageState extends State<LoginPage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<AlertLoginFormState>.
  final _formKey = GlobalKey<FormState>();

  String email;
  String password;
  TextEditingController _inputemail = TextEditingController();
  TextEditingController _inputpassword = TextEditingController();

  InputDecoration passwordDecoration(String label, IconData icon) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(0),
      labelStyle: TextStyle(
        color: Colors.black,
      ),
      hintStyle: TextStyle(
        color: Colors.black,
      ),
      fillColor: Colors.black,
      labelText: label,
      // hintText: hint,
      prefixIcon: Icon(
        icon,
        color: Colors.black,
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
    );
  }

  InputDecoration emailDecoration(String label, String hint, IconData icon) {
    return InputDecoration(
      labelStyle: TextStyle(
        color: Colors.black,
      ),
      hintStyle: TextStyle(
        color: Colors.black,
      ),
      fillColor: Colors.black,
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(
        icon,
        color: Colors.black,
      ),
      contentPadding: EdgeInsets.all(0),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return DevScaffold(
      title: "Login",
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration:
                    emailDecoration("Email", "Email", Icons.account_circle),
                controller: _inputemail,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  // return validateEmail(value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                keyboardType: TextInputType.text,
                obscureText: true,
                controller: _inputpassword,
                decoration: passwordDecoration("Password", Icons.lock),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  } else if (value.length < 6) {
                    return 'Must be more than 6 charater';
                  }
                  return null;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: OutlineButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          print("login");
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: _inputemail.text,
                            password: _inputpassword.text,
                          )
                              .then((user) {
                            Navigator.of(context).pop();

                            FirebaseAuth.instance
                                .currentUser()
                                .then((FirebaseUser user) {
                              String email = user.email;
                              String uid = user.uid;

                              print(email);
                              print(uid);
                            });
                          }).catchError((error) {
                             print(error);
                          });
                        }
                      },
                      child: Text("Login"),
                    ),
                  ),
                ),
                // Text("OR"),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: OutlineButton(
                      // padding: EdgeInsets.only(left: 5),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          print("create user");
                          print(_inputemail.text);
                          print(_inputpassword.text);
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: _inputemail.text,
                            password: _inputpassword.text,
                          )
                              .then((signedInUser) {
                                print(signedInUser);
                            // Navigator.of(context).pop();
                            // Scaffold.of(context).showSnackBar(new SnackBar(
                            //  content: new Text("User Signed up succusfully"),
                            // ));
                          }).catchError((error) {
                            print(error);
                          });
                        }
                      },
                      child: Text("Sign up"),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }
}
