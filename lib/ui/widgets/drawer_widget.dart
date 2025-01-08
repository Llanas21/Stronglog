import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stronglog/domain/services/auth_service.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    Size mediaQuery = MediaQuery.of(context).size;

    return Drawer(
      child: SingleChildScrollView(
          child: Column(
        children: [
          Wrap(
            runSpacing: mediaQuery.height * 0.02,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                    top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
                color: Colors.black,
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 52,
                      backgroundImage:
                          AssetImage('assets/images/Untitled-1.png'),
                    ),
                    SizedBox(
                      height: mediaQuery.height * 0.02,
                    ),
                    Text(
                      "José Llanas",
                      style:
                          textTheme.titleMedium?.copyWith(color: Colors.white),
                    ),
                    SizedBox(
                      height: mediaQuery.height * 0.01,
                    ),
                    Text(
                      "joseluisllanas21@gmail.com",
                      style: textTheme.bodySmall?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: Text(
                  'Inicio',
                  style: textTheme.bodyMedium,
                ),
                onTap: () {
                  context.goNamed("/home");
                },
              ),
              ListTile(
                leading: const Icon(Icons.fitness_center),
                title: Text(
                  'Rutinas',
                  style: textTheme.bodyMedium,
                ),
                onTap: () {
                  context.goNamed("/workouts");
                },
              ),
              ListTile(
                  leading: const Icon(Icons.settings),
                  title: Text(
                    'Ajustes',
                    style: textTheme.bodyMedium,
                  ),
                  onTap: () {}),
              ListTile(
                  leading: const Icon(Icons.logout),
                  title: Text(
                    'Cerrar sesión',
                    style: textTheme.bodyMedium,
                  ),
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'Cerrar sesión',
                            style: textTheme.bodyMedium,
                          ),
                          content: Text(
                            "¿Estás seguro de que deseas cerrar la sesión?",
                            style: textTheme.bodySmall,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                AuthService authService = AuthService();
                                await authService.signOut();
                                context.goNamed('/login');
                              },
                              child: Text(
                                'Aceptar',
                                style: textTheme.labelSmall,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: Text(
                                'Cancelar',
                                style: textTheme.labelSmall
                                    ?.copyWith(color: Colors.black),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }),
            ],
          ),
        ],
      )),
    );
  }
}
