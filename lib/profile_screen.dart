import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'auth_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService auth = AuthService();
    final user = auth.currentUser;

    final TextEditingController passwordController =
        TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Logged in as: ${user?.email ?? "No user"}"),

            const SizedBox(height: 20),

            TextField(
              controller: passwordController,
              decoration:
                  const InputDecoration(labelText: "New Password"),
              obscureText: true,
            ),

            ElevatedButton(
              onPressed: () async {
                bool success =
                    await auth.changePassword(passwordController.text);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        success ? "Password updated" : "Update failed"),
                  ),
                );
              },
              child: const Text("Change Password"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                await auth.signOut();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const AuthScreen()),
                );
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}