import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_news_api/presentation/screens/countries_screen.dart';
import 'package:flutter_news_api/presentation/widgets/categories_widget.dart';
import '../../logic/bloc/app_bloc.dart';
import '../widgets/news_widget.dart';

extension Normalize on num {
  num normalized(
    num selfRangeMin,
    num selfRangeMax, [
    num normalizedRangeMin = 0.0,
    num normalizedRangeMax = 1.0,
  ]) =>
      (normalizedRangeMax - normalizedRangeMin) *
          ((this - selfRangeMin) / (selfRangeMax - selfRangeMin)) +
      normalizedRangeMin;
}

class NewsScreen extends HookWidget {
  static const routeName = 'news';
  NewsScreen({super.key});

  final containerHeight = 50.0;
  double dx = 0.0;
  @override
  Widget build(BuildContext context) {
    final opacity = useAnimationController(
      duration: const Duration(seconds: 1),
      initialValue: 1.0,
      upperBound: 1.0,
      lowerBound: 0.0,
    );
    final size = useAnimationController(
      duration: const Duration(seconds: 1),
      initialValue: 1.0,
      upperBound: 1.0,
      lowerBound: 0.0,
    );
    final controller = useScrollController();
    useEffect(() {
      controller.addListener(() {
        final newOpacity = max(containerHeight - controller.offset, 0.0);
        final normalized =
            newOpacity.normalized(0.0, containerHeight).toDouble();
        opacity.value = normalized;
        size.value = normalized;
      });

      return null;
    }, [controller]);

    return DefaultTabController(
      length: 7,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.shadow,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          foregroundColor: Theme.of(context).colorScheme.secondary,
          title: BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
              const textStyle = TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
              );
              // final articels = state.articels;
              if (state.articels.isEmpty) {
                return const Text(
                  'Top News',
                  style: textStyle,
                );
              } else {
                return Text(
                  '${state.articels.first.countryData!['name']} Top News',
                  style: textStyle,
                );
              }
            },
          ),
          elevation: 0,
          actions: [
            BlocBuilder<AppBloc, AppState>(
              builder: (context, state) {
                if (state.articels.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: InkWell(
                      onTap: () async {
                        context.read<AppBloc>().add(
                              const AppEventGoToCountriesView(),
                            );
                        Navigator.of(context).pushNamed(
                          CountriesScreen.routeName,
                        );
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        width: 50,
                        height: 40,
                        alignment: Alignment.center,
                        child: Hero(
                          tag: state.articels.first.countryData!['code'],
                          child: FadeInImage(
                            fit: BoxFit.fitHeight,
                            placeholder:
                                const AssetImage('assets/images/flag.jpg'),
                            image: NetworkImage(
                              state.articels.first.countryData!['flag'],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              CategoriesWidget(size, opacity),
              BlocBuilder<AppBloc, AppState>(
                builder: ((context, state) => state.isLoading
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 300.0),
                          child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      )
                    : Expanded(
                        child: SizedBox(
                          child: BlocBuilder<AppBloc, AppState>(
                            buildWhen: (previous, current) =>
                                previous.articels != current.articels,
                            builder: (context, state) {
                              return ListView.builder(
                                controller: controller,
                                itemExtent: 150,
                                itemBuilder: (ctx, i) => NewsWidget(
                                  state.articels[i],
                                ),
                                itemCount: state.articels.length,
                              );
                            },
                          ),
                        ),
                      )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
