import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  //textfield state
  String email = ' ';
  String password = ' ';
  String error = ' ';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text("Sign Up Page"),
        actions: <Widget>[
          FlatButton.icon(onPressed: () {widget.toggleView();},icon: Icon(Icons.person), label: Text("Sign In")),
        ],
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Email can't be empty";
                      }
                      return null;
                    },
                  onChanged: (val) {
                    setState(() {email = val;});
                  },
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  validator: (val) {
                    if (val == null || val.length < 6) {
                        return "Enter a password 6+ chars long";
                      }
                      return null;
                  },
                  obscureText: true,
                  onChanged: (val) {
                    setState(() {password = val;});
                  },
                ),
                SizedBox(height: 20.0,),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color?>(Colors.pink[400]),),
                  child: const Text(
                    "Register",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formkey.currentState!.validate()){
                      setState(() => loading = true);
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      if(result == null){
                        setState(() { 
                          error = 'Please supply valid email';
                          loading = false;
                        });
                      } 
                    }
                  },
                ),
                SizedBox(height: 12.0,),
                Text(error, style: TextStyle(color: Colors.red,fontSize: 14.0),)
              ],
            ),
          )),
    );
  }
}
