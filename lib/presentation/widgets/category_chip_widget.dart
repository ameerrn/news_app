import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/bloc/app_bloc.dart';

class CategoryChip extends StatelessWidget {
  final List categories;
  const CategoryChip({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.select((AppBloc bloc) => bloc.state);
    return Chip(
      shadowColor: state.selectedCategory == categories[0]
          ? Theme.of(context).colorScheme.secondary
          : null,
      elevation: 4,
      side: BorderSide(
        width: state.selectedCategory == categories[0] ? 1 : 0.0,
        color: state.selectedCategory == categories[0]
            ? Theme.of(context).colorScheme.secondary
            : Colors.black,
      ),
      backgroundColor: state.selectedCategory == categories[0]
          ? Theme.of(context).colorScheme.secondary
          : Theme.of(context).colorScheme.shadow,
      label: Row(
        children: [
          Text(
            categories[0],
            style: TextStyle(
              color: state.selectedCategory == categories[0]
                  ? Theme.of(context).colorScheme.background
                  : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Icon(
            categories[1],
            color: state.selectedCategory == categories[0]
                ? Theme.of(context).colorScheme.background
                : Colors.black,
          )
        ],
      ),
    );
  }
}
