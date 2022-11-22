import 'package:shaped_test/core/base_domain/base_entity.dart';

enum ExaminationStatus {
  finished,
  processing;
}

class Examination implements BaseEntity {
  Examination({
    required this.id,
    required this.patientName,
    required this.status,
    required this.date,
  });

  final int id;
  final String patientName;
  final ExaminationStatus status;
  final String date;
}
