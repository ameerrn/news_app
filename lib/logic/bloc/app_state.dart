part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  final bool isLoading;
  final List<Articel> articels;
  final String selectedCategory;

  const AppState({
    required this.isLoading,
    required this.articels,
    required this.selectedCategory,
  });

  @override
  List<Object> get props => [isLoading, articels, selectedCategory];
}

@immutable
class AppStateNewsView extends AppState {
  const AppStateNewsView({
    required bool isLoading,
    required List<Articel> articels,
    required final String selectedCategory,
  }) : super(
          isLoading: isLoading,
          articels: articels,
          selectedCategory: selectedCategory,
        );
}

@immutable
class AppStateCountriesView extends AppState {
  const AppStateCountriesView({
    required bool isLoading,
    required List<Articel> articels,
    required final String selectedCategory,
  }) : super(
          isLoading: false,
          articels: articels,
          selectedCategory: selectedCategory,
        );
}

@immutable
class AppStateInDetailView extends AppState {
  final Articel articel;

  const AppStateInDetailView({
    required bool isLoading,
    required final String selectedCategory,
    required List<Articel> articels,
    required this.articel,
  }) : super(
          isLoading: false,
          articels: articels,
          selectedCategory: selectedCategory,
        );
  @override
  bool operator ==(other) {
    final otherClass = other;
    if ((otherClass is AppStateInDetailView)) {
      return isLoading == otherClass.isLoading && articel == otherClass.articel;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => articel.hashCode;
}

extension GetArticels on AppState {
  String get selectedCategory {
    final cls = this;
    if (cls is AppStateNewsView) {
      return cls.selectedCategory;
    } else {
      return '';
    }
  }
}

extension GetArticel on AppState {
  Articel? get articel {
    final cls = this;
    if (cls is AppStateInDetailView) {
      return cls.articel;
    } else {
      return null;
    }
  }
}
