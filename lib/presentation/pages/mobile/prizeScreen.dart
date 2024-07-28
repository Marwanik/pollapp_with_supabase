import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pollapp/service/achievement_service.dart';

class PrizeScreen extends StatelessWidget {
  const PrizeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final achievementService = AchievementService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Prizes and Achievements'),
        backgroundColor: Color(0xff4D7EFA),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FutureBuilder<List<String>>(
              future: achievementService.getAchievements('User.id'), // Replace with actual user ID
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final achievements = snapshot.data ?? [];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Achievements:', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30)),
                      ...achievements.map((achievement) => Text(achievement)).toList(),
                    ],
                  );
                }
              },
            ),
            SizedBox(height: 16),

          ],
        ),
      ),
    );
  }
}
