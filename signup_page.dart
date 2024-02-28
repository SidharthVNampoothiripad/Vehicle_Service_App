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
                keyboardType: TextInputType.phone,
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
                  if (_validateForm()) {
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
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _validateForm() {
    if (_nameController.text.isEmpty ||
        _phoneNumberController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _usernameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      _showErrorDialog('All fields are required');
      return false;
    } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(_nameController.text)) {
      _showErrorDialog('Name should not contain numbers');
      return false;
    } else if (_phoneNumberController.text.length != 10 ||
        int.tryParse(_phoneNumberController.text) == null) {
      _showErrorDialog('Phone number should have only 10 digits');
      return false;
    } else if (_passwordController.text != _confirmPasswordController.text) {
      _showErrorDialog('Passwords do not match');
      return false;
    }

    // Add more specific validation if needed

    return true;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
