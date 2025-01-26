import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stronglog/domain/models/note_model.dart';
import 'package:stronglog/domain/services/note_service.dart';
import 'package:stronglog/ui/providers/note_provider.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({super.key, required this.note});

  final Note note;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    Size mediaQuery = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[300]!))),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: mediaQuery.width * 0.04,
            vertical: mediaQuery.height * 0.02),
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Text(
                  note.note,
                  style: textTheme.bodyMedium,
                )),
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context) => [
                PopupMenuItem<String>(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Text(
                          "¿Estás seguro de que deseas eliminar esta nota?",
                          style: textTheme.bodyMedium,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => context.pop(),
                            child: Text(
                              "Cancelar",
                              style: textTheme.labelSmall,
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              NoteService noteService = NoteService();

                              await noteService.deleteNote(note.id!);
                              Provider.of<NoteProvider>(context, listen: false)
                                  .shouldRefresh();

                              context.pop();
                            },
                            child: Text(
                              "Aceptar",
                              style: textTheme.labelSmall
                                  ?.copyWith(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text(
                    'Borrar',
                    style: textTheme.bodyMedium,
                  ),
                ),
              ],
              icon: const Icon(Icons.more_vert_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
