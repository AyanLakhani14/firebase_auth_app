import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'profile_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthService _auth = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isLogin = true;
  String message = "";

  // VALIDATION
  bool isValidEmail(String email) {
    return email.contains('@') && email.contains('.');
  }

  bool isValidPassword(String password) {
    return password.length >= 6;
  }

  void handleAuth() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // VALIDATION CHECK
    if (!isValidEmail(email)) {
      setState(() => message = "Enter a valid email");
      return;
    }

    if (!isValidPassword(password)) {
      setState(() => message = "Password must be at least 6 characters");
      return;
    }

    var user;

    if (isLogin) {
      user = await _auth.signIn(email, password);
    } else {
      user = await _auth.register(email, password);
    }

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ProfileScreen()),
      );
    } else {
      setState(() => message = "Authentication failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? "Login" : "Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: handleAuth,
              child: Text(isLogin ? "Login" : "Register"),
            ),

            TextButton(
              onPressed: () {
                setState(() {
                  isLogin = !isLogin;
                  message = "";
                });
              },
              child: Text(
                isLogin
                    ? "Don't have an account? Register"
                    : "Already have an account? Login",
              ),
            ),

            const SizedBox(height: 10),
            Text(
              message,
              style: const TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}