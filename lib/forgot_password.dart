import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController _emailController = TextEditingController();
  String _email = '';

  void _submitForm() async {
    String email = _emailController.text.trim();

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // Password reset email sent successfully
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password reset email sent successfully.'),
        ),
      );
    } catch (error) {
      // Error occurred while sending password reset email
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(18.0),
              decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: <Widget>[
                 Container(
  padding: EdgeInsets.symmetric(horizontal: 16.0),
  decoration: BoxDecoration( // Background color for the email textbox
    borderRadius: BorderRadius.circular(8),
  ),
  child: TextFormField(
    controller: _emailController,
    onChanged: (value) {
      setState(() {
        _email = value;
      });
    },
    decoration: InputDecoration(
      labelText: 'Email',
      border: InputBorder.none,
      prefixIcon: Icon(Icons.email),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Email is required';
      } else if (!RegExp(
              r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
          .hasMatch(value)) {
        return 'Enter a valid email address';
      }
      return null;
    },
    autovalidateMode: AutovalidateMode.onUserInteraction,
  ),
),
                  SizedBox(height: 17.0),
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 23), // Adjust button padding here
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      backgroundColor: Colors.purple,
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(fontSize: 16, color: Colors.white), // Adjust button text size here
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ForgotPasswordPage(),
  ));
}
