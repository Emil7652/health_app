import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth/auth_service.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 120),

              const Icon(Icons.favorite, size: 80, color: Colors.redAccent),

              const SizedBox(height: 16),

              const Text(
                'LifePulse',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 32),

              TextField(
                controller: emailCtrl,
                decoration: const InputDecoration(
                  labelText: 'Почта',
                  prefixIcon: Icon(Icons.email),
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: passCtrl,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Пароль',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await context.read<AuthService>().resetPassword(
                    emailCtrl.text,
                  );
                },
                child: const Text("Забыли пароль?"),
              ),

              const SizedBox(height: 24),

              loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        try {
                          setState(() => loading = true);

                          await context.read<AuthService>().login(
                            emailCtrl.text.trim(),
                            passCtrl.text.trim(),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Ошибка входа')),
                          );
                        }

                        setState(() => loading = false);
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                        child: Text('ВОЙТИ'),
                      ),
                    ),
              ElevatedButton.icon(
                icon: const Icon(Icons.login),
                label: const Text("Войти через Google"),
                onPressed: () async {
                  await context.read<AuthService>().signInWithGoogle();
                },
              ),
              const SizedBox(height: 16),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  );
                },
                child: const Text('Нет аккаунта? Зарегистрироваться'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
