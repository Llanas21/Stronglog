import 'package:flutter/material.dart';
import 'package:stronglog/domain/models/record_model.dart' as r;

class RecordWidget extends StatelessWidget {
  const RecordWidget({super.key, required this.record});

  final r.Record record;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[300]!))),
      child: ListTile(
        title: Text("${record.lastWeight} libras"),
        subtitle: Text("${record.dateTime}"),
      ),
    );
  }
}
