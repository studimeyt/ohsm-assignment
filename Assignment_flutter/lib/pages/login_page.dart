import 'package:assignment_flutter/components/my_button.dart';
import 'package:assignment_flutter/components/my_textfield.dart';
import 'package:assignment_flutter/components/my_textfield_heading.dart';
import 'package:assignment_flutter/pages/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({
    super.key, required this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  bool emailValidate = true;
  bool passwordValidate = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  // sign user in method
  void signUserIn() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try sign in
    try {

      if(emailController.text.isEmpty  && passwordController.text.isEmpty){
        setState(() {
          emailValidate = false;
          passwordValidate = true;
        });
      }
      else if(emailController.text.isEmpty){
        setState(() {
          emailValidate = false;
          passwordValidate = true;
        });
      }
      else if(passwordController.text.isEmpty){
        setState(() {
          emailValidate = true;
          passwordValidate = false;
        });
      }

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //   pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {

      //   pop the loading circle
      Navigator.pop(context);
      // Wrong email
      if (e.code == 'invalid-email' ){
        setState(() {
          emailValidate = false;
          passwordValidate=true;
          passwordController.text = "";
          emailController.text = "";
        });
      }
      else if( e.code == 'too-many-requests'|| e.code == 'invalid-credential'){
        setState(() {
          emailValidate = true;
          passwordValidate = false;
          passwordController.text = "";
        });
      }
      else{
        print(e.code);
        print(e.credential);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const SizedBox(height: 1),
            
                //   logo
                const Image(
                  image: AssetImage('assets/images/ohsm.png'),
                  height: 36,
                  width: 98,
                ),
            
                const SizedBox(height: 30),
            
                //   sign in to ohsm
                const Text(
                  'Sign in to OHSM',
                  style: TextStyle(
                    color: Color.fromRGBO(55, 65, 81, 1),
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 30),
            
                //   email
                const MyTextFieldHeading(heading: 'Email'),
                const SizedBox(height: 10),
            
                MyTextField(
                  valid: emailValidate,
                  controller: emailController,
                  hintText: 'Username or email',
                  obscureText: false,
                  errorText: "Invalid Username!",
                ),
            
                const SizedBox(height: 30),
                //   password
                const MyTextFieldHeading(heading: 'Password'),
                const SizedBox(height: 10),
                MyTextField(
                  valid: passwordValidate,
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  errorText: "Incorrect password!",
                ),
            
                //    forgot password
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot password',
                        style: TextStyle(
                            color: Color.fromRGBO(231, 49, 157, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
            
                //   sign in button
                MyButton(
                  onTap: signUserIn,
                  btnName: 'Sign In',
                ),
                const SizedBox(height: 30),
            
                //    or continue with
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                        thickness: 1,
                        color: Color.fromRGBO(230, 232, 236, 1),
                      )),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          'or continue with',
                          style:
                              TextStyle(color: Color.fromRGBO(209, 213, 219, 1)),
                        ),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 1,
                        color: Color.fromRGBO(230, 232, 236, 1),
                      ))
                    ],
                  ),
                ),
                const SizedBox(height: 30),
            
                //   continue with GOOGLE
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  padding: const EdgeInsets.all(12.5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 0.5),
                    color: const Color.fromRGBO(239, 246, 255, 1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/images/google.png',
                          height: 24,
                          filterQuality: FilterQuality.low,
                          color: Colors.black,
                        ),
                      ),
                      const Text(
                        'Continue with Google',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 65),
            
                //    Don't have an account! sign up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.0),
                      child: Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          color: Color.fromRGBO(231, 49, 157, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
