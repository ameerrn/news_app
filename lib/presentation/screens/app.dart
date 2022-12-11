import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/bloc/app_bloc.dart';
import 'articel_ditail_screen.dart';
import 'countries_screen.dart';
import 'news_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      create: (_) => AppBloc()
        ..add(
          const AppEventLoadArticels(
            country: 'us',
            category: 'general',
          ),
        ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: const ColorScheme.dark(
            background: Color.fromARGB(239, 239, 239, 255),
            secondary: Color.fromARGB(255, 210, 0, 26),
            shadow: Color.fromARGB(255, 255, 250, 231),
            surface: Color.fromARGB(255, 255, 222, 0),
          ),
        ),
        home: NewsScreen(),
        routes: {
          ArticelDetailsScreen.routeName: (_) => const ArticelDetailsScreen(),
          CountriesScreen.routeName: (_) => const CountriesScreen(),
        },
      ),
    );
  }
}
