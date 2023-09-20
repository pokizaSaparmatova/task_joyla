import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task/core/error/exception.dart';
import 'package:task/core/error/failure.dart';
import 'package:task/core/network/network_info.dart';
import 'package:task/data/dataSourse/remote_datasource.dart';
import 'package:task/data/model/joyla_model.dart';
import 'package:task/domain/repository/repository.dart';

class JoylaRepositoryImpl implements JoylaRepository {
  final HomeApi _homeApi;
  final NetworkInfo networkInfo;

  JoylaRepositoryImpl(this._homeApi, this.networkInfo);

  @override
  Future<Either<Failure, JoylaModel>> getAllProducts(
      String search, int page) async {
    return await _getAllProduct(() {
      return _homeApi.getProducts(search: search, page: page);
    });
  }

  Future<Either<Failure, JoylaModel>> _getAllProduct(
      Future<JoylaModel> Function() getAllProducts) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await getAllProducts();
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}

// @override
// Future<Either<Failure, JoylaModel>> getAllProducts (String search,int page) async { // xatolikka tekshiriw
//   var isConnected = await networkInfo.isConnected;
//
//   if (isConnected) {
//     var response = await _homeApi.getProducts();
//     print("responseeeeeeeeeeeeeeee: ${response.content.toString()}");
//     try {
//
//       return Right(response);
//
//     } on DioException catch (error){
//       return Left(ServerFailure(error.message.toString()));
//     }
//   }
//   else {
//     return Left(ConnectionFailure());
//   }
//
// }
//}
