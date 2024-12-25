import 'package:flutter/material.dart';
import 'package:stronglog/domain/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    Size mediaQuery = MediaQuery.of(context).size;

    AuthService authService = AuthService();

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.grey[300],
              height: 200,
              alignment: Alignment.topCenter,
            ),
            SizedBox(height: mediaQuery.height * 0.04),
            SizedBox(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Stronglog",
                      style: textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(height: mediaQuery.height * 0.06),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: 'tu email',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este campo es obligatorio';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: mediaQuery.height * 0.04),
                        TextFormField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            labelText: 'tu contraseña',
                            border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este campo es obligatorio';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: mediaQuery.height * 0.06),
                        SizedBox(
                          height: 48,
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () async {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState!.validate()) {
                                try {
                                  User? user =
                                      await authService.signInWithEmail(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                  );
                                  if (user != null) {
                                    print("Usuario autenticado: ${user.email}");
                                  }
                                } catch (e) {
                                  print("Error al iniciar sesión: $e");
                                }
                              }
                            },
                            child: const Text(
                              'Iniciar sesión',
                            ),
                          ),
                        ),
                        SizedBox(height: mediaQuery.height * 0.04),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () {},
                            child: Text("¿Olvidaste la contraseña?",
                                style: textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                          ),
                        ),
                        SizedBox(
                          height: mediaQuery.height * 0.08,
                        ),
                        SizedBox(
                          height: 48,
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () async {},
                            child: const Text(
                              'Crea una nueva cuenta',
                            ),
                          ),
                        ),
                      ],
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
