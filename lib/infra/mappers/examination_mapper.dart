import 'package:shaped_test/domain/entities/examination.dart';

abstract class ExaminationMapper {
  static Examination fromMap(Map map) => Examination(
        id: map["id"],
        patientName: map["paciente"],
        status: map["status"] == "Finalizado"
            ? ExaminationStatus.finished
            : ExaminationStatus.processing,
        date: map["data"],
      );
}
