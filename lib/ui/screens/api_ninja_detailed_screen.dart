import 'package:flutter/material.dart';
import 'package:stronglog/domain/models/api_ninja_model.dart';

class ApiNinjaDetailedScreen extends StatefulWidget {
  const ApiNinjaDetailedScreen({super.key, required this.exercise});

  final ApiNinja exercise;

  @override
  State<ApiNinjaDetailedScreen> createState() => _ApiNinjaDetailedScreenState();
}

class _ApiNinjaDetailedScreenState extends State<ApiNinjaDetailedScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    Size mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: const BoxDecoration(border: Border(top: BorderSide())),
        child: Column(
          children: [
            SizedBox(
              height: mediaQuery.height * 0.04,
            ),
            Padding(
              padding: EdgeInsets.only(left: mediaQuery.width * 0.06),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.exercise.name,
                  style: textTheme.titleLarge,
                ),
              ),
            ),
            SizedBox(height: mediaQuery.height * 0.04),
            Expanded(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: mediaQuery.width * 0.06),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          style: textTheme.bodyMedium,
                          children: [
                            const TextSpan(
                              text: 'Tipo: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: widget.exercise.type),
                          ],
                        ),
                      ),
                      SizedBox(height: mediaQuery.height * 0.01),
                      Text.rich(
                        TextSpan(
                          style: textTheme.bodyMedium,
                          children: [
                            const TextSpan(
                              text: 'Músculo: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: widget.exercise.muscle),
                          ],
                        ),
                      ),
                      SizedBox(height: mediaQuery.height * 0.01),
                      Text.rich(
                        TextSpan(
                          style: textTheme.bodyMedium,
                          children: [
                            const TextSpan(
                              text: 'Equipamiento: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: widget.exercise.equipment),
                          ],
                        ),
                      ),
                      SizedBox(height: mediaQuery.height * 0.01),
                      Text.rich(
                        TextSpan(
                          style: textTheme.bodyMedium,
                          children: [
                            const TextSpan(
                              text: 'Dificultad: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: widget.exercise.difficulty),
                          ],
                        ),
                      ),
                      SizedBox(height: mediaQuery.height * 0.01),
                      Text.rich(
                        TextSpan(
                          style: textTheme.bodyMedium,
                          children: [
                            const TextSpan(
                              text: 'Instrucciones: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: widget.exercise.instructions),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
