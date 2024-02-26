import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone, // Set keyboard type to numeric
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Location',
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Perform signup logic
                  // For example, you can use Firebase Authentication

                  // For demonstration purposes, we will print the form data
                  print('Name: ${_nameController.text}');
                  print('Phone Number: ${_phoneNumberController.text}');
                  print('Location: ${_locationController.text}');
                  print('Username: ${_usernameController.text}');
                  print('Password: ${_passwordController.text}');
                  print('Confirm Password: ${_confirmPasswordController.text}');

                  // Handle successful signup, e.g., navigate to home page
                  Navigator.pop(context);
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
