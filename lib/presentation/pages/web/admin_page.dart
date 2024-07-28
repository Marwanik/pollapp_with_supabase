import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pollapp/presentation/pages/web/edit_question_page.dart';
import 'package:pollapp/presentation/pages/web/loginadminScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'statistics_page.dart';
import 'question_management_page.dart';
import 'package:pollapp/presentation/providers/admin_provider.dart' as admin;

class AdminPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionsAsyncValue = ref.watch(admin.fetchQuestionsProvider);

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Color(0xFF343A40),
      ),
      body: Row(
        children: [
          // Side Navigation Menu
          Expanded(
            flex: 2,
            child: Container(
              color: Color(0xFF343A40),
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/images/q.png'),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Admin',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        '@Admin',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                  Divider(color: Colors.white, height: 30),
                  ListTile(
                    leading: Icon(Icons.dashboard, color: Colors.white),
                    title: Text('Dashboard', style: TextStyle(color: Colors.white)),
                    onTap: () {
                      // Handle navigation
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.bar_chart, color: Colors.white),
                    title: Text('Statistics', style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StatisticsPage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings, color: Colors.white),
                    title: Text('Settings', style: TextStyle(color: Colors.white)),
                    onTap: () {
                      // Handle navigation
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.white),
                    title: Text('Logout', style: TextStyle(color: Colors.white)),
                    onTap: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.clear();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Loginadminscreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // Main Content Area
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dashboard',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text('Votes', style: TextStyle(fontSize: 20)),
                                SizedBox(height: 10),
                                Text('122+', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
                                Text("You're Votes", style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text('Upcoming Votes', style: TextStyle(fontSize: 20)),
                                SizedBox(height: 10),
                                Text('Candidate 1, Candidate 2', style: TextStyle(fontSize: 16)),
                                Text('Starts in:', style: TextStyle(fontSize: 16)),
                                Text('7 November 2023 07:00 pm', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Latest Votes',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => QuestionManagementPage()),
                          );
                        },
                        child: Text('View All',style: TextStyle(color: Color(
                            0xffd5a876)),),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: questionsAsyncValue.when(
                      data: (questions) {
                        final displayedQuestions = questions.take(3).toList();
                        return ListView.builder(
                          itemCount: displayedQuestions.length,
                          itemBuilder: (context, index) {
                            final question = displayedQuestions[index];
                            return Container(height: 120,
                              child: Card(

                                margin: EdgeInsets.symmetric(vertical: 8.0),
                                child: ListTile(
                                  leading: Icon(Icons.meeting_room, color: Color(0xFFD7A977)),
                                  title: Text(question.questionText),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditQuestionPage(question: question),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                      loading: () => Center(child: CircularProgressIndicator()),
                      error: (error, stack) => Center(child: Text('Error: $error')),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Handle create new vote
                    },
                    icon: Icon(Icons.add, color: Color(0xFFD7A977)),
                    label: Text('Create New Vote'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Color(0xFFD7A977),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
