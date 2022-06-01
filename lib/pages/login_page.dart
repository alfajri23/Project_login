import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';
import 'dart:convert' show json;
import 'dart:async';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String password = "";
  bool isLoginSuccess = false;
  late SharedPreferences logindata;
  late bool newuser;

  void initState() {
    // TODO: implement initState
    super.initState();
    check_if_already_login();
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    //newuser = (logindata.getBool('login') ?? true);
    // print(newuser);

    // if (newuser == false) {
    // Navigator.pushReplacement(
    // context, new MaterialPageRoute(builder: (context) => HomePage()));
    // }
  }

  getApi (String email, String password) async {
    String apiURL = "https://rent-cars-api.herokuapp.com/customer/auth/login";
    // ignore: unused_local_variable
    var api = await http.post(
      Uri.parse(apiURL),
      body:{"email": email, "password": password}
    );

    var obj = await json.decode(api.body);

    var kol = {
      "id": 1,
      "email": "admin@mail.com",
      "password": "o89h9dJu3EVLHlSd4CnOS",
      "role": "admin",
      "createdAt": "2022-03-09T15:49:41.975Z",
      "updatedAt": "2022-03-09T15:49:41.975Z"
    };

    print(kol);

    print(obj);

    // Timer(Duration(seconds: 3), () {
    //   if(obj.id == 1){
    //     logindata.setBool('login', true);
    //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
    //             return HomePage();
    //       }));
    //   }else{
    //     SnackBar snackBar = SnackBar(
    //           content: Text("password dan email salah"),
    //     );
    //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //   }
    // });


   

    // if(obj.id == 1){
    //   logindata.setBool('login', true);
    //    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
    //           return HomePage();
    //     }));
    // }else{
    //   SnackBar snackBar = SnackBar(
    //         content: Text("password dan email salah"),
    //   );
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login Page"),
        ),
        body: Column(children: [
          _usernameField(),
          _passwordField(),
          _loginButton(context),
        ]),
      ),
    );
  }

  Widget _usernameField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        enabled: true,
        onChanged: (value) {
          email = value;
        },
        decoration: InputDecoration(
          hintText: 'Username',
          contentPadding: const EdgeInsets.all(8.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.blue),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide:
                BorderSide(color: (isLoginSuccess) ? Colors.blue : Colors.red),
          ),
        ),
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        enabled: true,
        obscureText: true,
        onChanged: (value) {
          password = value;
        },
        decoration: InputDecoration(
          hintText: 'Password',
          contentPadding: const EdgeInsets.all(8.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.blue),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide:
                BorderSide(color: (isLoginSuccess) ? Colors.blue : Colors.red),
          ),
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: (isLoginSuccess) ? Colors.blue : Colors.red, // background
          onPrimary: Colors.white, // foreground
        ),
        onPressed: () {
          String text = "";
          if (password == "123") {
            setState(() {
              text = "Login Success";
              isLoginSuccess = true;
            });
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
              return HomePage();
            }));
          } else {
            setState(() {
              text = "Login Failed";
              isLoginSuccess = false;
            });
          }
          SnackBar snackBar = SnackBar(
            content: Text("password salah"),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: const Text('Login'),
      ),
    );
  }
}