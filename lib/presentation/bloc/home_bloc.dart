import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task/core/error/failure.dart';
import 'package:task/core/usecase/usecase.dart';
import 'package:task/data/dataSourse/remote_datasource.dart';
import 'package:task/data/model/joyla_model.dart';
import 'package:task/di.dart';
import 'package:task/domain/repository/repository.dart';
import 'package:task/domain/useCase/usecase_impl.dart';

part 'home_event.dart';

part 'home_state.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_MESSAGE = 'Cache Failure';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final JoylaUsecase _homeApi;

  HomeBloc(this._homeApi) : super(HomeState()) {
    on<HomeInitEvent>((event, emit) async {
      emit(state.copyWith(
        status: Status.loading,
        list: [],
        page: 0,
      ));
      final product = await _homeApi(ProductParams(state.search, state.page));
      product.fold(
          (l) => emit(state.copyWith(
              status: Status.fail, message: _mapFailureToMessage(l))),
          (r) => emit(state.copyWith(
              status: Status.success,
              list: r.content,
              page: r.number,
              totalPage: r.totalPages)));

    });
    on<HomeNextEvent>((event, emit) async {
      if (state.page >= state.totalPage) return;

      print("pageeee: ${state.page}");
      print("totalPageeeee:: ${state.totalPage}");
      emit(state.copyWith(status: Status.loading));

      final product = await _homeApi(ProductParams(state.search, state.page+1));

      print("current page : ${product.fold((l) => [], (r) => r.number)}");
      print("tottalPage page : ${product.fold((l) => [], (r) => r.totalPages)}");
      print("listttttt : ${product.fold((l) => [], (r) => r.content)}");

      product.fold(
          (l) => emit(state.copyWith(
              status: Status.fail, message: _mapFailureToMessage(l))),
          (r) => emit(state.copyWith(
              status: Status.success,
              list: [...state.list ,... r.content],
              page: r.number,
              totalPage: r.totalPages)));

    });
    on<HomeSearchEvent>((event, emit) async {
      emit(state.copyWith(
        status: Status.loading,
        search: event.text,
        page: 0,
        list: [],
      ));

      final product = await _homeApi(ProductParams(state.search, state.page));
      product.fold(
              (l) => emit(state.copyWith(
              status: Status.fail, message: _mapFailureToMessage(l))),
              (r) => emit(state.copyWith(
              status: Status.success,
              list: r.content,
              page: r.number,
              totalPage: r.totalPages)));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
