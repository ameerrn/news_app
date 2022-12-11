import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_news_api/constant/categories.dart';
import 'package:flutter_news_api/data/data_provider/news_api_data.dart';

import '../../data/models/articel.dart';
import '../../data/repository_provider/repository.dart';
part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc()
      : super(
          const AppStateNewsView(
              articels: [], isLoading: false, selectedCategory: 'general'),
        ) {
    on<AppEventLoadArticels>(
      (event, emit) async {
        final category = event.category;
        RepositoryNewsApi repository = RepositoryNewsApi();
        emit(
          AppStateNewsView(
            articels: state.articels,
            isLoading: true,
            selectedCategory: category,
          ),
        );

        final articelsList =
            await repository.fetchAndStoreArticels(event.country, category);
        emit(
          AppStateNewsView(
            articels: articelsList,
            isLoading: false,
            selectedCategory: category,
          ),
        );
      },
    );

    on<AppEventGoToDetailsView>(
      (event, emit) {
        final articelId = event.articelId;
        final articel = state.articels.firstWhere((art) => art.id == articelId);
        emit(
          AppStateInDetailView(
            isLoading: false,
            articels: state.articels,
            articel: articel,
            selectedCategory: state.selectedCategory,
          ),
        );
      },
    );

    on<AppEventGoToCountriesView>(
      (event, emit) {
        emit(
          AppStateCountriesView(
            isLoading: false,
            articels: state.articels,
            selectedCategory: state.selectedCategory,
          ),
        );
      },
    );
    on<AppEventGoToNewsView>(
      (event, emit) async {
        final countryData = event.countriesData;
        final currentArticels = state.articels;
        if (countryData == null ||
            countryData == currentArticels.first.countryData) {
          emit(
            AppStateNewsView(
              articels: state.articels,
              isLoading: false,
              selectedCategory: state.articel!.category!,
            ),
          );
        } else {
          for (var art in currentArticels) {
            art.countryData = countryData;
          }

          final category = currentArticels.first.category!;

          emit(
            AppStateNewsView(
                articels: currentArticels,
                isLoading: true,
                selectedCategory: category),
          );
          final articelsList = await RepositoryNewsApi().fetchAndStoreArticels(
            countryData['code']!,
            category,
          );
          emit(
            AppStateNewsView(
              articels: articelsList,
              isLoading: false,
              selectedCategory: category,
            ),
          );
        }
      },
    );

    on<AppEventOnDragHorizonaly>(
      (event, emit) async {
        final index = event.i;
        // final currentCategory = state.selectedCategory;
        // late int newIndex;
        // for (int i = 0; i < categories.length; i++) {
        //   if (categories[i][0] == currentCategory) {
        //     newIndex = i;
        //     if (dx > 0 && i > 0) {
        //       newIndex = i - 1;
        //       break;
        //     } else if (dx < 0 && i < categories.length - 1) {
        //       newIndex = i + 1;
        //       break;
        //     } else {
        //       return;
        //     }
        //   }
        // }
        emit(
          AppStateNewsView(
            isLoading: true,
            articels: state.articels,
            selectedCategory: categories[index][0],
          ),
        );
        final articels = await RepositoryNewsApi().fetchAndStoreArticels(
            state.articels.first.countryData!['code'], categories[index][0]);

        emit(
          AppStateNewsView(
            isLoading: false,
            articels: articels,
            selectedCategory: categories[index][0],
          ),
        );
      },
    );
  }
}
