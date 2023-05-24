import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_flutter/modules/webview_screen.dart';
import 'package:news_app_flutter/shared/cubit/states.dart';

import '../cubit/cubit.dart';

Widget ArticleBuilder(article, context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8.0),
    child: InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WebViewScreen(article['title'], article['url'])),
        );
      },
      child: Row(
        children: [
          Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(article['urlToImage'] ??=
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png'),
              ),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: BlocBuilder<NewsCubit, NewsStates>(
                        builder: (context, state) {
                      return Text(
                        "${article['title']}",
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge,
                      );
                    }),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                      alignment: Alignment.bottomRight,
                      child: BlocBuilder<NewsCubit, NewsStates>(
                          builder: (context, state) {
                        return Text(
                          "${article['publishedAt']}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                          ),
                        );
                      })),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
