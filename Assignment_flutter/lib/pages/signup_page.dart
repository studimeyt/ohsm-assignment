import 'package:assignment_flutter/components/my_button.dart';
import 'package:assignment_flutter/components/my_textfield.dart';
import 'package:assignment_flutter/components/my_textfield_heading.dart';
import 'package:assignment_flutter/pages/login_or_signup_page.dart';
import 'package:assignment_flutter/pages/login_page.dart';
import 'package:assignment_flutter/pages/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  final Function()? onTap;
  const SignUpPage({
    super.key, required this.onTap,
  });

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final ScrollController _scrollController = ScrollController();
  // text editing controllers
  bool _acceptTerms = false;
  bool _acceptEmail = false;
  bool emailValidate = true;
  bool passwordValidate = true;
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();


  // sign user up method
  void signUserUp() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try sign up
    try {
      // if password is confirmed
      if (emailController.text.isEmpty) {
        Navigator.pop(context);
        showErrorMessage('email-empty');
      } else if (passwordController.text.isEmpty) {
        Navigator.pop(context);
        showErrorMessage('password-empty');
      } else if (confirmPasswordController.text != passwordController.text) {
        Navigator.pop(context);
        showErrorMessage("password-not-confirmed");
      } else if (!_acceptTerms) {
        Navigator.pop(context);
        showErrorMessage('accept-terms');
      } else {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Navigator.pop(context);
        // Success: Do anything needed after user creation
      }

    } on FirebaseAuthException catch (e) {

      Navigator.pop(context);

      if (e.code == 'email-already-in-use') {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else if (e.code == 'channel-error') {
        showErrorMessage('channel-error');
      } else {
        showErrorMessage(e.code);
      }

    }
  }

  void showErrorMessage(String message){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Color.fromRGBO(231, 49, 157, 1),
            ),
          ),
        ));
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            controller: _scrollController,
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
                  'Create an account',
                  style: TextStyle(
                    color: Color.fromRGBO(55, 65, 81, 1),
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 30),

                //   name
                const MyTextFieldHeading(heading: 'Full Name'),
                const SizedBox(height: 10),

                MyTextField(
                  valid: true,
                  controller: fullNameController,
                  hintText: 'Full Name',
                  obscureText: false,
                  errorText: 'Can\'t have empty name',
                ),

                const SizedBox(height: 30),

                // email
                const MyTextFieldHeading(heading: 'Email'),
                const SizedBox(height: 10),

                MyTextField(
                  valid: emailValidate,
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                  errorText: 'Please provide you email!aa',
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
                  errorText: 'Password cant\'t be empty!',
                ),

                const SizedBox(height: 30),

                //   confirm password
                const MyTextFieldHeading(heading: 'Confirm Password'),
                const SizedBox(height: 10),
                MyTextField(
                  valid: confirmPasswordController.text == passwordController.text,
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                  errorText: 'Passwords don\'t match',
                ),

                const SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        checkColor: const Color.fromRGBO(231, 49, 157, 1),
                        activeColor: Colors.white,
                        value: _acceptEmail,
                        onChanged: (value) {
                          setState(() {
                            _acceptEmail = value!;
                          });
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.0),
                        child: Text(
                          'Yes, I want to receive email',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        checkColor: const Color.fromRGBO(231, 49, 157, 1),
                        activeColor: Colors.white,
                        value: _acceptTerms,
                        onChanged: (value) {
                          setState(() {
                            _acceptTerms = value!;
                          });
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.0),
                        child: Text(
                          'I agree to all',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Text(
                        'Terms & Privacy Policy',
                        style: TextStyle(
                          color: Color.fromRGBO(231, 49, 157, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 45),
                //   sign in button
                MyButton(
                  onTap: signUserUp,
                  btnName: 'Sign Up',
                ),

                const SizedBox(height: 69),

                //    already have an account! sign in
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.0),
                      child: Text(
                        'Already have an account?',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          color: Color.fromRGBO(231, 49, 157, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 65),
                  ],
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
