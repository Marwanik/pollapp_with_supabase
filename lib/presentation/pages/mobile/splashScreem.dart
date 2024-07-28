import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pollapp/presentation/pages/mobile/HomeScreen.dart';
import 'package:pollapp/presentation/pages/mobile/loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pollapp/domain/entities/user.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> leftLineAnimation;
  late Animation<Offset> rightLineAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    leftLineAnimation = Tween<Offset>(
      begin: Offset(-2, 0),
      end: Offset(0.5, 0),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ));

    rightLineAnimation = Tween<Offset>(
      begin: Offset(2, 0),
      end: Offset(-0.5, 0),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ));

    controller.forward();

    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        final prefs = GetIt.instance<SharedPreferences>();
        final email = prefs.getString('userEmail');
        final role = prefs.getString('userRole');

        if (email != null && role != null) {
          // Create a dummy User object with the stored data
          User user = User(email: email, role: role, firstName: '', password: '', lastName: '', dateOfBirth: DateTime.now(), gender: '', maritalState: '', education: '', address: '', socialState: '', numberOfChildren: 0, phoneNumber: '', hasAJob: false, achievements: []); // Adjust according to your User class
          var pushReplacement = Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen(user: user)),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF80A1F5), Color(0xFF1F3F8E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SlideTransition(
                    position: leftLineAnimation,
                    child: Container(
                      width: 100,
                      height: 7.5,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Pollingo',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SlideTransition(
                    position: rightLineAnimation,
                    child: Container(
                      width: 100,
                      height: 7.5,
                      color: Colors.white.withOpacity(0.6),
                    ),
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
