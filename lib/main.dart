import 'package:clothes_shop/logo_loading.dart';
import 'package:clothes_shop/modules/admin/cubit/cubit.dart';
import 'package:clothes_shop/modules/home/cubit/cubit.dart';
import 'package:clothes_shop/on_board.dart';
import 'package:clothes_shop/shared/cache.dart';
import 'package:clothes_shop/shared/const.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'bottomnav.dart';
import 'components/shared.dart';
import 'firebase_options.dart';
import 'modules/login/cubit/cubit.dart';
import 'modules/login/login_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  bool? onboard = CacheHelper.getdata(key: 'onboard');
  String? userid = CacheHelper.getdata(key: 'userid');
  if (onboard == null) {
    widget = OnBoard();
  } else if (userid != null) {
    widget = BottomNav();
  } else {
    widget = ShopLogin();
  }
  runApp(MyApp(
    userid: userid,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({this.userid});

  final String? userid;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AdminCubit()
              ..getProducts()
              ..getArticles()
              ..getUsers()),
        BlocProvider(
            create: (context) =>
                LoginCubit()..getUserData(CacheHelper.getdata(key: 'userid'))),
        BlocProvider(
            create: (context) => HomeCubit()
              ..getProducts()
              ..getArticles()
              ..getFavid(userid)
              ..getFav(userid)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: AppBarTheme(color: Colors.white, elevation: 0),
          primaryColor: Colors.lightGreenAccent,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'cairo',
          primarySwatch: Colors.blue,
        ),
        home: Loading(),
      ),
    );
  }
}
