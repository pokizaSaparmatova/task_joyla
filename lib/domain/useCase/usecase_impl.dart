import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task/core/error/failure.dart';
import 'package:task/core/usecase/usecase.dart';
import 'package:task/data/model/joyla_model.dart';
import 'package:task/domain/repository/repository.dart';

class JoylaUsecase implements UseCase<JoylaModel, ProductParams> {
  final JoylaRepository repository;

  JoylaUsecase(this.repository);

  @override
  Future<Either<Failure, JoylaModel>> call(ProductParams params) async {
    return await repository.getAllProducts(params.search, params.page);
  }
}

class ProductParams extends Equatable {
  final String search;

  final int page;

  ProductParams(this.search, this.page);

  @override
  List<Object?> get props => [search, page];
}
