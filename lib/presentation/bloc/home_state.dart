part of 'home_bloc.dart';

@immutable
class HomeState {
  final Status status;
  final String message;
  final String search;
  final List<Product> list;
  final int page;
  final int totalPage;

  HomeState({
    this.status = Status.initial,
    this.message = "",
    this.search = "",
    this.list = const [],
    this.page = 0,
    this.totalPage = 0
  });

  HomeState copyWith({
    Status? status,
    String? message,
    String? search,
    List<Product>? list,
    int? page,
    int? totalPage,
  }) {
    return HomeState(
      status: status ?? this.status,
      message: message ?? this.message,
      search: search ?? this.search,
      list: list ?? this.list,
      page: page ?? this.page,
      totalPage: totalPage ?? this.totalPage,
    );
  }

}

enum Status { initial, loading, success, fail }