import 'package:fpdart/fpdart.dart';

import '../../domain/entities/examination.dart';

typedef Output<R> = Future<Either<Exception, R>>;

typedef ExaminationList = List<Examination>;
