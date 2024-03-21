import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserInfoItem(label: 'Name', value: 'vvn'),
            UserInfoItem(label: 'Phone Number', value: '+1234567890'),
            UserInfoItem(label: 'Email', value: 'vvn@example.com'),
            UserInfoItem(label: 'Change Password', value: 'Change', onTap: () {
              // Handle the change password action
              // Navigate to the change password page or show a dialog
              // You can add the necessary logic here
            }),
          ],
        ),
      ),
    );
  }
}

class UserInfoItem extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback? onTap;

  const UserInfoItem({
    required this.label,
    required this.value,
    this.onTap,
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
      onTap: onTap,
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: UserInfo(),
  ));
}
