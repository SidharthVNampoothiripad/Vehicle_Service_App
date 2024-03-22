import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_page.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Information'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.email) // Use email as document ID
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('No user data found'));
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.7,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    UserInfoItem(label: 'Name', value: userData['Name'] ?? ''),
                    UserInfoItem(label: 'Email', value: userData['Email'] ?? ''),
                    UserInfoItem(label: 'Phone Number', value: userData['Phone Number'] ?? ''),
                    UserInfoItem(label: 'Location', value: userData['location'] ?? ''),
                    ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        backgroundColor: Colors.purple, // Violet color
                        foregroundColor: Colors.white, // White text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // Rounded edges
                        ),
                      ),
                      child: Text('Sign Out', style: TextStyle(fontSize: 14.0)),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class UserInfoItem extends StatelessWidget {
  final String label;
  final String value;

  const UserInfoItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17.0, // Increased font size
          ),
        ),
        SizedBox(height:15.0),
        Text(
          value,
          style: TextStyle(fontSize: 15.0), // Increased font size
        ),
        SizedBox(height: 10.0),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: UserInfo(),
  ));
}
