
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/component/component.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/state.dart';

class SportScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: ( context,  state) {
          var list = NewsCubit.get(context).sports;
          return list.isEmpty ? const Center(child: CircularProgressIndicator()): ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => articleItems(context,list[index]),
              separatorBuilder: (context, index) => myDivider (),
              itemCount: list.length);
        });
  }
}
