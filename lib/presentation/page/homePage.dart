import 'dart:async';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:task/core/error/failure.dart';
import 'package:task/di.dart';
import 'package:task/presentation/bloc/home_bloc.dart';
import 'package:task/presentation/widgets/product_cache_image_widget.dart';
import 'package:task/presentation/widgets/product_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bloc = di.get<HomeBloc>();
  final controller = RefreshController();

 late StreamSubscription<InternetConnectionStatus> _subscription;

  Widget appBarTitle = const Text(
    "Joyla",
    style: TextStyle(color: Colors.black),
  );
  Icon actionIcon = const Icon(
    Icons.search,
    color: Colors.black,
  );
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    _subscription = InternetConnectionChecker().onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.disconnected) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Network Disconnected'),
            content: const Text(
                'Your device is not connected to the internet. Please check your connection and try again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
      else if(status==InternetConnectionStatus.connected) {
        bloc.add(HomeInitEvent());
      }
    });
    bloc.add(HomeInitEvent());
    _searchQuery.addListener(() {
      EasyDebounce.debounce("debounce", const Duration(seconds: 2), () {
        bloc.add(HomeSearchEvent(_searchQuery.text));
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    print("dispose: Joyla");
    _subscription.cancel();
    bloc.close();
    controller.dispose();
    _searchQuery.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.status == Status.success) {
            controller.refreshCompleted();
            controller.loadComplete();
          }

        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Scaffold(
              appBar: buildBar(context),
              body: Builder(builder: (context) {
                _subscription = InternetConnectionChecker().onStatusChange.listen((status) {
                  if (status == InternetConnectionStatus.disconnected && state.list.isEmpty) {
                    const Center(
                        child: Text(
                          "Empty Data",
                          style: TextStyle(color: Colors.black, fontSize: 40),
                        ));
                  }
                  else if(status==InternetConnectionStatus.connected) {
                    bloc.add(HomeInitEvent());
                  }
                });
                if (state.status == Status.loading && state.list.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                else if (state.list.isEmpty) {
                  return const Center(
                      child: Text(
                    "Empty Data",
                    style: TextStyle(color: Colors.black, fontSize: 40),
                  ));
                }
                else if ( state.status==Status.fail) {
                  Center(
                      child: Text(state.message,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 40)));
                }
                return SmartRefresher(
                  controller: controller,
                  enablePullDown: true,
                  enablePullUp: true,
                  onRefresh: () {
                    bloc.add(HomeInitEvent());
                  },
                  onLoading: () {
                    bloc.add(HomeNextEvent());
                  },
                  child: ListView.builder(
                    itemCount: state.list.length,
                    itemBuilder: (BuildContext context, int index) {
                      var model = state.list[index];
                      return ProductCard(
                        imagUrl:
                            'https://mobile-api.joyla.uz/mobile/${model.imageUrl}',
                        name: model.name,
                        price: model.price,
                        currencyType: model.currencyType,
                        type: model.type,
                      );
                    },
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }

  AppBar buildBar(BuildContext context) {
    return AppBar(
        title: appBarTitle,
        backgroundColor: Colors.white12,
        actions: <Widget>[
          IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (actionIcon.icon == Icons.search) {
                  actionIcon = const Icon(
                    Icons.close,
                    color: Colors.black,
                  );
                  appBarTitle = TextField(
                    controller: _searchQuery,
                    style: const TextStyle(color: Colors.black87, fontSize: 18),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.black87),
                        hintText: "Search...",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.black12)),
                  );
                  _handleSearchStart();
                } else {
                  _handleSearchEnd();
                }
              });
            },
          ),
        ]);
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      actionIcon = const Icon(
        Icons.search,
        color: Colors.black87,
      );
      appBarTitle = const Text(
        "Joyla",
        style: TextStyle(color: Colors.black87),
      );
      _isSearching = false;
      _searchQuery.clear();
    });
  }
}
