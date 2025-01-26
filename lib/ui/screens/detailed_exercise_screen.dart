import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stronglog/domain/models/exercise_model.dart';
import 'package:stronglog/domain/models/note_model.dart';
import 'package:stronglog/domain/models/record_model.dart' as r;
import 'package:stronglog/domain/services/auth_service.dart';
import 'package:stronglog/domain/services/note_service.dart';
import 'package:stronglog/domain/services/record_service.dart';
import 'package:stronglog/ui/providers/note_provider.dart';
import 'package:stronglog/ui/widgets/note_widget.dart';
import 'package:stronglog/ui/widgets/record_widget.dart';

class DetailedExerciseScreen extends StatefulWidget {
  const DetailedExerciseScreen({super.key, required this.exercise});

  final Exercise exercise;

  @override
  State<DetailedExerciseScreen> createState() => _DetailedExerciseScreenState();
}

class _DetailedExerciseScreenState extends State<DetailedExerciseScreen> {
  int _currentIndex = 0; // Índice de la pestaña seleccionada

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: const BoxDecoration(border: Border(top: BorderSide())),
        child: getContent(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Info'),
          BottomNavigationBarItem(
              icon: Icon(Icons.query_stats), label: 'Estadísticas'),
          BottomNavigationBarItem(icon: Icon(Icons.notes), label: 'Notas'),
        ],
      ),
    );
  }

  Widget getContent() {
    switch (_currentIndex) {
      case 0:
        return _buildInfoScreen();
      case 1:
        return _buildStatisticsScreen();
      case 2:
        return _buildNotesScreen();
      default:
        return const Center();
    }
  }

  Widget _buildStatisticsScreen() {
    return FutureBuilder(
      future: loadStatisticsData(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        List<r.Record> records = snapshot.data!;

        // Convertir registros en puntos del gráfico
        final List<FlSpot> spots = records
            .asMap()
            .entries
            .map((entry) => FlSpot(
                  entry.key.toDouble(),
                  entry.value.lastWeight.toDouble(),
                ))
            .toList();

        if (records.isEmpty) {
          return const Center(
            child: Text("No existen registros aún"),
          );
        }

        return Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: true),
                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 48,
                          getTitlesWidget: (value, meta) {
                            final date = records[value.toInt()].dateTime;
                            return Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: Text(DateFormat('dd/MM').format(date),
                                  style: const TextStyle(fontSize: 11)),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 48,
                          getTitlesWidget: (value, meta) {
                            return Text('${value.toInt()} lb',
                                style: const TextStyle(fontSize: 11));
                          },
                        ),
                      ),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        color: Colors.black,
                        spots: spots,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: ListView.builder(
                    itemCount: records.length,
                    itemBuilder: (context, i) {
                      return RecordWidget(record: records[i]);
                    }))
          ],
        );
      },
    );
  }

  Widget _buildInfoScreen() {
    TextTheme textTheme = Theme.of(context).textTheme;

    Size mediaQuery = MediaQuery.of(context).size;

    return Column(
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
            padding: EdgeInsets.symmetric(horizontal: mediaQuery.width * 0.06),
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
    );
  }

  Widget _buildNotesScreen() {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Consumer(builder: (context, NoteProvider noteProvider, child) {
        return FutureBuilder(
          future: loadNotesData(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            List<Note> notes = snapshot.data!;

            if (notes.isEmpty) {
              return const Center(
                child: Text("No existen notas aún"),
              );
            }

            return ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, i) {
                  return NoteWidget(
                    note: notes[i],
                  );
                });
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            TextEditingController noteController = TextEditingController();

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Theme(
                    data: Theme.of(context).copyWith(
                      inputDecorationTheme: const InputDecorationTheme(
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    child: TextField(
                      onTapOutside: (_) =>
                          FocusScope.of(context).requestFocus(FocusNode()),
                      controller: noteController,
                      style: textTheme.bodyMedium,
                      decoration: const InputDecoration(
                        hintText: 'Nueva Nota',
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Descartar",
                        style: textTheme.labelSmall,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        NoteService noteService = NoteService();
                        AuthService authService = AuthService();
                        String uidUser = authService.currentUser!.uid;
                        Note note = Note(
                            note: noteController.text,
                            idExercise: widget.exercise.id!,
                            uidUser: uidUser);

                        await noteService.addNote(note);
                        Provider.of<NoteProvider>(context, listen: false)
                            .shouldRefresh();
                        context.pop();
                      },
                      child: Text(
                        "Agregar",
                        style:
                            textTheme.labelSmall?.copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                );
              },
            );
          }),
    );
  }

  Future<List<r.Record>> loadStatisticsData() async {
    RecordService recordService = RecordService();
    return await recordService.getRecordsByExercise(widget.exercise.id!);
  }

  Future<List<Note>> loadNotesData() async {
    NoteService noteService = NoteService();
    return await noteService.getNotesByExercise(widget.exercise.id!);
  }
}
