import 'package:flutter/material.dart';
import 'package:stronglog/domain/models/record_model.dart' as r;
import 'package:stronglog/domain/services/record_service.dart';

class RecordProvider with ChangeNotifier {
  late Future<List<r.Record>> _records;
  final RecordService recordService = RecordService();

  Future<List<r.Record>> get records {
    return _records;
  }

  set records(Future<List<r.Record>> records) {
    _records = records;
    notifyListeners();
  }

  void shouldRefresh() {
    notifyListeners();
  }
}
