import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinda_chees/modules/Login_screen/login_screen.dart';
import 'package:kinda_chees/modules/home.dart';
import 'package:kinda_chees/shared/bloc_observer.dart';
import 'package:kinda_chees/styles/themes/themes.dart';
import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';
import 'local/cache_helper.dart';
import 'modules/Login_screen/cubit/cubit.dart';
import 'modules/sign_up_screen/cubit/cubit.dart';
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  bool isDark = CacheHelper.getBoolean(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => StoreAppCubit()..changeThemeMode(fromShared: isDark)..getProduct(),
        ),
        BlocProvider(
          create: (BuildContext context) => SignUpCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => LoginCubit(),
        ),
      ],
      child: BlocConsumer<StoreAppCubit,StoreAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            darkTheme: darkTheme,
            theme: lightTheme,
            themeMode: ThemeMode.light,
            home: LoginScreen(),
          );
        },
      ),
    );
  }
}

