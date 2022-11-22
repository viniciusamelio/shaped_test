import 'package:fpdart/fpdart.dart';
import 'package:shaped_test/domain/entities/user.dart';

import 'package:shaped_test/core/shared/types.dart';
import 'package:shaped_test/infra/mappers/examination_mapper.dart';

import '../../domain/repositories/examination_repository.dart';

class ExaminationRepositoryImpl implements ExaminationRepository {
  @override
  Output<ExaminationList> get(User input) async {
    await Future.delayed(const Duration(seconds: 2));

    final result = {
      "resultados": {
        "exames": [
          {
            "id": 1,
            "paciente": "João Pedro",
            "status": "Processando",
            "data": "08/08/2022"
          },
          {
            "id": 2,
            "paciente": "Marcelo Miguel",
            "status": "Finalizado",
            "data": "09/08/2022"
          },
          {
            "id": 3,
            "paciente": "Marcos Pontes",
            "status": "Processando",
            "data": "05/08/2022"
          }
        ]
      }
    };
    final examinations = (result["resultados"]!["exames"] as List<Map>)
        .map((e) => ExaminationMapper.fromMap(e))
        .toList();

    return Right(examinations);
  }
}
