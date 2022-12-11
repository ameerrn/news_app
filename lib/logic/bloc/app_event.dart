part of 'app_bloc.dart';

abstract class AppEvent {
  const AppEvent();
}

@immutable
class AppEventLoadArticels implements AppEvent {
  final String country;
  final String category;

  const AppEventLoadArticels({
    required this.country,
    required this.category,
  });
}

@immutable
class AppEventGoToCountriesView implements AppEvent {
  const AppEventGoToCountriesView();
}

@immutable
class AppEventGoToDetailsView implements AppEvent {
  final int articelId;
  const AppEventGoToDetailsView({
    required this.articelId,
  });
}

@immutable
class AppEventGoToNewsView implements AppEvent {
  final Map<String, String>? countriesData;
  const AppEventGoToNewsView({
    required this.countriesData,
  });
}

@immutable
class AppEventOnDragHorizonaly implements AppEvent {
  final int i;
  // final String category;

  const AppEventOnDragHorizonaly({
    required this.i,
    // required this.category,
  });
}
