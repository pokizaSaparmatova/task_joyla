import 'package:dartz/dartz.dart';
import 'package:task/core/error/failure.dart';
import 'package:task/data/model/joyla_model.dart';

abstract class JoylaRepository {
  Future<Either<Failure, JoylaModel>> getAllProducts(String search, int page);
}
