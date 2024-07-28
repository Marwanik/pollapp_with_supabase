import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pollapp/domain/entities/user.dart';
import 'package:pollapp/presentation/pages/mobile/formScreen.dart';
import 'package:pollapp/presentation/pages/mobile/prizeScreen.dart';
import 'package:pollapp/presentation/pages/mobile/profileScreen.dart';

import 'package:pollapp/presentation/providers/form_provider.dart';
import 'package:pollapp/presentation/widgets/LocalStorageService.dart';


class HomeScreen extends ConsumerStatefulWidget {
  final User user;

  HomeScreen({required this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int selectedIndex = 1;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = <Widget>[
      PrizeScreen(),
      HomePage(user: widget.user),
      UserProfilePage(user: widget.user),
    ];

    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Prize',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Pr'
                ''
                'ofile',
          ),
        ],
        selectedItemColor: Color(0xff4D7EFA),
      ),
    );
  }
}

class HomePage extends ConsumerWidget {
  final User user;

  HomePage({required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String category;
    if (user.education.toLowerCase() == 'finance' && user.gender.toLowerCase() == 'male') {
      category = 'finance';
    } else if (user.education.toLowerCase() == 'engineering') {
      category = 'eng';
    } else {
      category = 'other';
    }

    final formsAsyncValue = ref.watch(fetchFormsProvider(category));
    final localStorageService = LocalStorageService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${user.firstName}!'),
        backgroundColor: Color(0xff4D7EFA),
      ),
      body: formsAsyncValue.when(
        data: (forms) {
          return ListView(
            padding: EdgeInsets.all(8.0),
            children: [
              ...forms.map((form) {
                return FutureBuilder<bool>(
                  future: localStorageService.isFormCompleted(form.id),
                  builder: (context, snapshot) {
                    bool isCompleted = snapshot.data ?? false;
                    return CategoryCard(
                      title: form.name,
                      color: isCompleted ? Colors.grey : Color(0xff0948EA),
                      onTap: isCompleted
                          ? null
                          : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FormPage(user: user, formId: form.id, formName: form.name),
                          ),
                        );
                      },
                    );
                  },
                );
              }).toList(),
            ],
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback? onTap;

  const CategoryCard({
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.2), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
