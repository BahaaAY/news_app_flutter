import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components/article.dart';
import '../shared/components/divider.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Search'),
        ),
        body: BlocConsumer<NewsCubit, NewsStates>(
            listener: (BuildContext context, Object? state) {},
            builder: (context, state) {
              NewsCubit cubit = NewsCubit.get(context);

              return Column(children: [
                Padding(
                    padding: const EdgeInsets.only(
                       left: 8.0, right: 8.0 ,top: 12.0),
                    child:
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        border: const OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        cubit.getSearchNews(query: value);
                      },
                    )),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ConditionalBuilder(
                      condition: cubit.searchNews.isNotEmpty,
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
                              return ArticleBuilder(
                                  cubit.searchNews[index], context);
                            },
                            separatorBuilder: (context, index) {
                              return myDivider();
                            },
                            itemCount: cubit.searchNews.length);
                      })
                  ,
                )
                ,
              ]
              );
            }));
  }
}
