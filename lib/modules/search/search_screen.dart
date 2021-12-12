import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinda_chees/layout/cubit/cubit.dart';
import 'package:kinda_chees/layout/cubit/states.dart';


class SearchScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreAppCubit, StoreAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body:Text('SearchScreen'),
          );
        });
  }
}

