import 'package:dio/dio.dart';
import 'package:task/data/dataSourse/base_api.dart';
import 'package:task/data/model/joyla_model.dart';

class HomeApi {
final BaseApi _baseApi;

  HomeApi(this._baseApi);
  Future<JoylaModel> getProducts({String search="" ,int page=0 }) async {
    print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
    final response=await _baseApi.dio.get("api/products/v3?name=$search&size=10&page=$page&user_lat=41&user_lang=69");
    print("apiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii:${response.data}");
    return JoylaModel.fromJson(response.data);

}}
