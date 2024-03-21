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
            .doc(FirebaseAuth.instance.currentUser!.email) // Use display name as document ID
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('No user data found'));
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  child: Text('Sign Out'),
                ),
              ],
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
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
      subtitle: Text(
        value,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: UserInfo(),
  ));
}
