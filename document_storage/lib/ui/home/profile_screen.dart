import 'package:flutter/material.dart';
import 'package:document_storage/data/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var user = AuthService().getCurrentUser();
    var profileUrl = user?.photoURL ??
        'https://st.depositphotos.com/2218212/2938/i/600/depositphotos_29387653-stock-photo-facebook-profile.jpg';
    var username = user?.displayName ?? 'User';
    return SizedBox.expand(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60, // Image radius
            backgroundImage: NetworkImage(profileUrl),
          ),
          const SizedBox(height: 30),
          Text(username),
          const SizedBox(height: 80),
          TextButton(
            onPressed: () async {
              AuthService().logout();
            },
            child: const Text('Logout'),
          ),
          TextButton(
            onPressed: () async {
              AuthService().deleteUser();
            },
            child: const Text('Delete Account'),
          )
        ],
      ),
    );
  }
}
