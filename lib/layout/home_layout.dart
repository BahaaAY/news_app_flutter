import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_flutter/modules/search_screen.dart';
import 'package:news_app_flutter/shared/cubit/states.dart';

import '../shared/cubit/cubit.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        print("home !@31");
        NewsCubit cubit = NewsCubit.get(context);
        //cubit.getBusinessNews();

        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                style: const ButtonStyle(),
                icon: const Icon(Icons.search),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchScreen()),
                  );
                },
              ),
              IconButton(
                style: const ButtonStyle(),
                icon: const Icon(Icons.brightness_4_outlined),
                onPressed: () {
                  cubit.switchMode();
                },
              ),
            ],
            title: const Text('News'),
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: cubit.navItems,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
          ),
        );
      },
    );
  }
}
