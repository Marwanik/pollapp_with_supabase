import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pollapp/presentation/pages/mobile/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pollapp/presentation/pages/web/admin_page.dart';
import 'package:pollapp/presentation/providers/user_provider.dart';
import 'signupScreen.dart';

class LoginScreen extends ConsumerWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signInUseCase = ref.watch(signInProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 20),
                Image.asset(
                  fit: BoxFit.cover,
                  'assets/images/back.png',
                  height: MediaQuery.sizeOf(context).height * .3,
                  width: MediaQuery.sizeOf(context).width,
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff000000)),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Row(
                  children: [
                    Text(
                      'Email',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff000000)),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2, color: Color(0xff0948EA))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Email..",
                        border: UnderlineInputBorder(),
                        suffixIconColor: Color(0xff4D7EFA),
                        suffixIcon: Icon(
                          Icons.alternate_email,
                          color: Color(0xff4D7EFA),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Password',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff000000)),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                PasswordField(passwordController),
                SizedBox(height: 50),
                Container(
                  height: 50,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  width: MediaQuery.sizeOf(context).width * .9,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        final user = await signInUseCase.execute(
                          emailController.text,
                          passwordController.text,
                        );

                        if (user != null) {
                          // Save user session
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setString('userEmail', user.email);
                          await prefs.setString('userRole', user.role);

                          if (user.role == 'admin') {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => AdminPage()),
                            );
                          } else {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => HomeScreen(user: user)),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Invalid email or password')),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      }
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Color(0xffFFFFFF)),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4D7EFA),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    // Handle forgot password action
                  },
                  child: Text(
                    'Forget Password',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff4D7EFA)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff000000)),
                    ),
                    SizedBox(width: 5),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => SignupScreen()));
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff4D7EFA)),
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

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  PasswordField(this.controller);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  void toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: Color(0xff0948EA))),
      child: Padding(
        padding: EdgeInsets.only(left: 10),
        child: TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: "Password..",
            border: UnderlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: Color(0xff4D7EFA),
              ),
              onPressed: toggleVisibility,
            ),
          ),
          obscureText: _obscureText,
        ),
      ),
    );
  }
}
