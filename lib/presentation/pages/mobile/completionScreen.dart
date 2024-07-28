import 'package:flutter/material.dart';

import 'package:pollapp/domain/entities/user.dart';
import 'package:pollapp/presentation/pages/mobile/HomeScreen.dart';


class CompletionPage extends StatelessWidget {
  final User user;
  final int formId;
  final String formName;
  static int formsAnswered = 0;

  CompletionPage({required this.user, required this.formId, required this.formName});

  @override
  Widget build(BuildContext context) {
    formsAnswered++;

    return Scaffold(
      appBar: AppBar(title: Text('Completion')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You have completed the form!', style: TextStyle(fontSize: 18.0)),
            SizedBox(height: 16.0),
            Text('Forms answered: $formsAnswered', style: TextStyle(fontSize: 18.0)),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen(user: user)),
                );
              },
              child: Text('Answer More Forms'),
            ),
          ],
        ),
      ),
    );
  }
}
