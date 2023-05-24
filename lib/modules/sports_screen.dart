import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components/article.dart';
import '../shared/components/divider.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        builder: (context, state) {
          NewsCubit cubit = NewsCubit.get(context);
          return ConditionalBuilder(
              condition: cubit.sportsNews.isNotEmpty,
              fallback: (context) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepOrange,
                  ),
                );
              },
              builder: (context) {
                return ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ArticleBuilder(cubit.sportsNews[index],context);
                    },
                    separatorBuilder: (context, index) {
                      return myDivider();
                    },
                    itemCount: cubit.sportsNews.length);
              });
        },
        listener: (BuildContext context, Object? state) {});

  }
}
