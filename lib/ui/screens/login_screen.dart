import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stronglog/domain/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    Size mediaQuery = MediaQuery.of(context).size;

    AuthService authService = AuthService();

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
                          onTapOutside: (_) =>
                              FocusScope.of(context).requestFocus(FocusNode()),
                          controller: emailController,
                          style: textTheme.bodyMedium,
                          decoration: const InputDecoration(
                            labelText: 'tu email',
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
                          onTapOutside: (_) =>
                              FocusScope.of(context).requestFocus(FocusNode()),
                          controller: passwordController,
                          style: textTheme.bodyMedium,
                          decoration: const InputDecoration(
                            labelText: 'tu contraseña',
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
                                    context.goNamed("/home");
                                  }
                                } catch (e) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Error de autenticación',
                                          style: textTheme.bodyMedium,
                                        ),
                                        content: Text(
                                          "Email o contraseña incorrectos",
                                          style: textTheme.bodySmall,
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'Aceptar',
                                              style: textTheme.labelSmall
                                                  ?.copyWith(
                                                      color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
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
