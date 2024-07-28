import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:image_picker/image_picker.dart';

import 'package:pollapp/domain/entities/user.dart';
import 'package:pollapp/presentation/pages/mobile/loginScreen.dart';
import 'package:pollapp/presentation/providers/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfilePage extends riverpod.ConsumerWidget {
  final User user;

  UserProfilePage({required this.user});

  @override
  Widget build(BuildContext context, riverpod.WidgetRef ref) {
    final updateUserUseCase = ref.watch(updateUserProvider);

    final formKey = GlobalKey<FormState>();
    final firstNameController = TextEditingController(text: user.firstName ?? '');
    final lastNameController = TextEditingController(text: user.lastName ?? '');
    final emailController = TextEditingController(text: user.email ?? '');
    final phoneNumberController = TextEditingController(text: user.phoneNumber ?? '');
    final avatarController = TextEditingController(text: user.avatarUrl ?? '');

    Future<void> logout() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  LoginScreen()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff4D7EFA),
        title: Text('User Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                SizedBox(height: 50),
                Center(
                  child: InkWell(
                    onTap: () async {
                      final picker = ImagePicker();
                      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        avatarController.text = pickedFile.path;
                      }
                    },
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: avatarController.text.isNotEmpty
                          ? FileImage(File(avatarController.text))
                          : (user.avatarUrl != null ? NetworkImage(user.avatarUrl!) : null) as ImageProvider?,
                      child: avatarController.text.isEmpty && user.avatarUrl == null
                          ? Icon(Icons.camera_alt)
                          : null,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2, color: Color(0xff0948EA)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                        hintText: "First Name",
                        border: UnderlineInputBorder(),
                        suffixIconColor: Color(0xff4D7EFA),
                        suffixIcon: Icon(
                          Icons.person,
                          color: Color(0xff4D7EFA),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2, color: Color(0xff0948EA)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextField(
                      controller: lastNameController,
                      decoration: InputDecoration(
                        hintText: "Last Name",
                        border: UnderlineInputBorder(),
                        suffixIconColor: Color(0xff4D7EFA),
                        suffixIcon: Icon(
                          Icons.person,
                          color: Color(0xff4D7EFA),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2, color: Color(0xff0948EA)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
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
                SizedBox(height: 16),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2, color: Color(0xff0948EA)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextField(
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                        hintText: "Phone Number",
                        border: UnderlineInputBorder(),
                        suffixIconColor: Color(0xff4D7EFA),
                        suffixIcon: Icon(
                          Icons.phone,
                          color: Color(0xff4D7EFA),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * .9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        final updatedUser = User(
                          id: user.id,
                          email: emailController.text,
                          password: user.password,
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          dateOfBirth: user.dateOfBirth,
                          gender: user.gender,
                          maritalState: user.maritalState,
                          education: user.education,
                          address: user.address,
                          socialState: user.socialState,
                          numberOfChildren: user.numberOfChildren,
                          phoneNumber: phoneNumberController.text,
                          hasAJob: user.hasAJob,
                          role: user.role,
                          avatarUrl: avatarController.text.isEmpty ? null : avatarController.text,
                          achievements: user.achievements,
                        );

                        try {
                          await updateUserUseCase.execute(updatedUser);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Profile updated successfully')),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: $e')),
                          );
                        }
                      }
                    },
                    child: Text(
                      'Update Profile',
                      style: TextStyle(
                        color: Color(0xffFFFFFF),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xFF4D7EFA),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      textStyle: TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * .9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ElevatedButton(
                    onPressed: logout,
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        color: Color(0xffFFFFFF),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
