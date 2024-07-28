import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pollapp/domain/entities/user.dart';
import 'package:pollapp/presentation/pages/mobile/loginScreen.dart';
import 'package:pollapp/presentation/providers/user_provider.dart';

class SignupScreen extends ConsumerStatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  final PageController pageController = PageController();

  // Form field controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  final avatarController = TextEditingController();

  String gender = 'Male';
  String maritalStatus = 'No military service required';
  String education = 'Engineering';
  String socialState = 'Single';
  int numberOfChildren = 0;
  bool hasJob = false;

  @override
  void dispose() {
    pageController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    dateOfBirthController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    avatarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Form(
          key: formKey,
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              buildFirstPage(),
              buildSecondPage(),
              buildThirdPage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFirstPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Step 1'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                fit: BoxFit.contain,
                'assets/images/back.png',
                height: MediaQuery.sizeOf(context).height * .3,
                width: MediaQuery.sizeOf(context).width,
              ),

              Row(
                children: [
                  Text(
                    'Registration',
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff000000)),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'First Name',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000),
                ),
              ),
              SizedBox(height: 10),
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
                      suffixIconColor: Color(0xff4D7EFA),
                      suffixIcon: Icon(Icons.person),
                      hintText: "First Name...",
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Last Name',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000),
                ),
              ),
              SizedBox(height: 10),
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
                      suffixIconColor: Color(0xff4D7EFA),
                      suffixIcon: Icon(Icons.person),
                      hintText: "Last Name...",
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000),
                ),
              ),
              SizedBox(height: 10),
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
                      hintText: "Email...",
                      border: UnderlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.alternate_email,
                        color: Color(0xff4D7EFA),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Password',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000),
                ),
              ),
              SizedBox(height: 10),
              PasswordField(controller: passwordController),
              SizedBox(height: 40),
              Container(
                height: 50,
                width: MediaQuery.sizeOf(context).width * .9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(
                        color: Color(0xffFFFFFF),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
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
    );
  }

  Widget buildSecondPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Step 2'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Image',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000),
                ),
              ),
              Center(
                child: InkWell(
                  onTap: () async {
                    final picker = ImagePicker();
                    final pickedFile =
                    await picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      avatarController.text = pickedFile.path;
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: Color(0xff0948EA),
                    radius: 100,
                    backgroundImage: avatarController.text.isNotEmpty
                        ? FileImage(File(avatarController.text))
                        : null,
                    child: avatarController.text.isEmpty
                        ? Icon(Icons.camera_alt)
                        : null,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Date of Birth',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: Color(0xff0948EA)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: buildDateField(dateOfBirthController, 'Date of Birth'),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Gender',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000),
                ),
              ),
              buildDropdown(' ', Icon(Icons.safety_divider), gender,
                  ['Male', 'Female'], (newValue) {
                    setState(() {
                      gender = newValue!;
                    });
                  }),
              SizedBox(height: 20),
              if (gender == 'Male')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Marital Status',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff000000),
                      ),
                    ),
                    buildDropdown(
                        '',
                        Icon(Icons.account_box),
                        maritalStatus,
                        [
                          'No military service required',
                          'Exempted',
                          'Delayed',
                          'Done the military service'
                        ], (newValue) {
                      setState(() {
                        maritalStatus = newValue!;
                      });
                    }),
                    SizedBox(height: 20),
                  ],
                ),
              Text(
                'Education',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000),
                ),
              ),
              buildDropdown(' ', Icon(Icons.newspaper), education, [
                'Engineering',
                'Medical',
                'Finance',
                'Other'
              ], (newValue) {
                setState(() {
                  education = newValue!;
                });
              }),
              SizedBox(height: 50),
              Container(
                height: 50,
                width: MediaQuery.sizeOf(context).width * .9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(
                        color: Color(0xffFFFFFF),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
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
    );
  }

  Widget buildThirdPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Step 3'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                fit: BoxFit.cover,
                'assets/images/back.png',
                height: MediaQuery.sizeOf(context).height * .2,
                width: MediaQuery.sizeOf(context).width,
              ),
              SizedBox(height: 20),
              Text(
                'Phone Number',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: Color(0xff0948EA)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 8),
                  child: TextField(
                    controller: phoneNumberController,
                    decoration: InputDecoration(
                      suffixIconColor: Color(0xFF4D7EFA),
                      suffixIcon: Icon(Icons.phone_android),
                      hintText: "Phone Number...",
                      border: UnderlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Address',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: Color(0xff0948EA)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 8),
                  child: TextField(
                    controller: addressController,
                    decoration: InputDecoration(
                      suffixIconColor: Color(0xFF4D7EFA),
                      suffixIcon: Icon(Icons.place),
                      hintText: "Address...",
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Social State',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000),
                ),
              ),
              buildDropdown(' ', Icon(Icons.social_distance), socialState,
                  ['Single', 'Married', 'Divorced'], (newValue) {
                    setState(() {
                      socialState = newValue!;
                      if (socialState == 'Single') {
                        numberOfChildren = 0;
                      }
                    });
                  }),
              if (socialState != 'Single')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Number of Children',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff000000),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2, color: Color(0xff0948EA)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 8),
                        child: TextField(
                          controller: TextEditingController(
                              text: numberOfChildren.toString()),
                          decoration: InputDecoration(
                            suffixIconColor: Color(0xFF4D7EFA),
                            suffixIcon: Icon(Icons.child_care),
                            hintText: "Number of Children...",
                            border: UnderlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              numberOfChildren = int.tryParse(value) ?? 0;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 30),
              SwitchListTile(
                activeColor: Color(0xff0948EA),
                title: Text('Has Job'),
                value: hasJob,
                onChanged: (bool value) {
                  setState(() {
                    hasJob = value;
                  });
                },
              ),
              SizedBox(height: 50),
              Container(
                height: 50,
                width: MediaQuery.sizeOf(context).width * .9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                  onPressed: signup,
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: Color(0xffFFFFFF),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
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
    );
  }

  Widget buildTextField(TextEditingController controller, String labelText,
      {bool obscureText = false,
        bool isNumber = false,
        void Function(String)? onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        obscureText: obscureText,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $labelText';
          }
          return null;
        },
        onChanged: onChanged,
      ),
    );
  }

  Widget buildDropdown(String label, Icon icon, String value, List<String> items,
      void Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: Color(0xff0948EA)),
        ),
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            hoverColor: Color(0xff0948EA),
            suffixIconColor: Color(0xFF4D7EFA),
            suffixIcon: icon,
            labelText: label,
            border: OutlineInputBorder(),
          ),
          value: value,
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(color: Color(0x82000000)),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget buildDateField(
      TextEditingController controller, String labelText) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: labelText,
        border: InputBorder.none,
      ),
      style: TextStyle(color: Colors.black),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          String formattedDate =
              "${pickedDate.year.toString().padLeft(4, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
          controller.text = formattedDate;
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $labelText';
        }
        return null;
      },
    );
  }

  Future<void> signup() async {
    if (formKey.currentState!.validate()) {
      final user = User(
        id: null, // Set to null to let the database handle it
        email: emailController.text,
        password: passwordController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        dateOfBirth: DateTime.parse(dateOfBirthController.text),
        gender: gender,
        maritalState: maritalStatus,
        education: education,
        address: addressController.text,
        socialState: socialState,
        numberOfChildren: numberOfChildren,
        phoneNumber: phoneNumberController.text,
        hasAJob: hasJob,
        role: 'user', // Default role to user (could be admin if necessary)
        avatarUrl: avatarController.text, // Add this field
        achievements: [], // Initialize with an empty list
      );

      try {
        final signUpUseCase = ref.read(signUpProvider);
        await signUpUseCase.execute(user);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Signup successful!')));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  LoginScreen()),
        );
      } catch (e) {
        // Handle errors here, e.g., show a Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }
}

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  PasswordField({required this.controller});

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
        border: Border.all(width: 2, color: Color(0xff0948EA)),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 10),
        child: TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: "Password...",
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
