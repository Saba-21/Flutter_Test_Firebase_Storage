import 'package:flutter/material.dart';
import 'package:document_storage/data/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  String username = '';
  String profileUrl = '';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var user = AuthService().getCurrentUser();
    widget.profileUrl = user?.photoURL ??
        'https://st.depositphotos.com/2218212/2938/i/600/depositphotos_29387653-stock-photo-facebook-profile.jpg';
    widget.username = user?.displayName == null || user!.displayName!.isEmpty
        ? 'Username'
        : user.displayName!;
    return SizedBox.expand(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          CircleAvatar(
            radius: 60, // Image radius
            backgroundImage: NetworkImage(widget.profileUrl),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.username),
              IconButton(
                icon: const Icon(Icons.edit_note_rounded),
                onPressed: () {
                  showUpdateUsernameDialog(context, widget.username);
                },
              ),
            ],
          ),
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

  showUpdateUsernameDialog(BuildContext context, String username) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var textController = TextEditingController();
        return AlertDialog(
          title: const Text('Enter username'),
          content: TextField(controller: textController),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  var newUsername = textController.text;
                  await AuthService()
                      .getCurrentUser()
                      ?.updateDisplayName(newUsername);
                  setState(() {
                    username = newUsername;
                    Navigator.of(context).pop();
                  });
                } catch (error) {
                  print(error);
                }
              },
              child: const Text('Save'),
            )
          ],
        );
      },
    );
  }
}
