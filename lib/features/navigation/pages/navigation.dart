import 'package:essential/features/home/data/repositories/post_repository.dart';
import 'package:essential/features/home/presentation/manager/get_posts_cubit.dart';
import 'package:essential/features/home/presentation/pages/home_screen.dart';
import 'package:essential/features/navigation/manager/navigation_cubit.dart';
import 'package:essential/features/profile/presentation/manager/get_user_posts_cubit.dart';
import 'package:essential/features/profile/presentation/pages/profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigationCubit()),
        BlocProvider(create: (context) => GetPostsCubit(PostRepositoryImpl())),
        BlocProvider(create: (context) => GetUserPostsCubit(PostRepositoryImpl())),
      ],
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(
              index: state,
              children: const [
                HomeScreen(),
                ProfileScreen(),
              ],
            ),
            bottomNavigationBar: NavigationBar(
              selectedIndex: state,
              onDestinationSelected: context.read<NavigationCubit>().setIndex,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
