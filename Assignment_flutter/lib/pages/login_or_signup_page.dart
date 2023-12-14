import 'package:assignment_flutter/pages/login_page.dart';
import 'package:assignment_flutter/pages/signup_page.dart';
import 'package:flutter/material.dart';

class LoginOrSignupPage extends StatefulWidget {
  const LoginOrSignupPage({super.key});

  @override
  State<LoginOrSignupPage> createState() => _LoginOrSignupPageState();
}

class _LoginOrSignupPageState extends State<LoginOrSignupPage> {
  // initially show login page
  bool showLoginPage = true;

  // toggle between login and signup page
  void togglePages(){
    setState(() {
      showLoginPage=!showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage){
      return LoginPage(
        onTap: togglePages,
      );
    }
    else{
      return SignUpPage(
        onTap: togglePages,
      );
    }
  }
}
