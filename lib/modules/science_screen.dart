import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_flutter/shared/components/divider.dart';

import '../shared/components/article.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        builder: (context, state) {
          NewsCubit cubit = NewsCubit.get(context);
          return ConditionalBuilder(
              condition: cubit.scienceNews.isNotEmpty,
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
                      return ArticleBuilder(cubit.scienceNews[index],context);
                    },
                    separatorBuilder: (context, index) {
                      return myDivider();
                    },
                    itemCount: cubit.scienceNews.length);
              });
        },
        listener: (BuildContext context, Object? state) {});

  }
}
