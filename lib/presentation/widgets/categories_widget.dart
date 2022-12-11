import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constant/categories.dart';
import '../../logic/bloc/app_bloc.dart';
import 'category_chip_widget.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget(this.opacity, this.size, {super.key});
  final Animation<double> opacity;
  final Animation<double> size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0),
      child: Column(
        children: [
          SizeTransition(
            sizeFactor: size,
            axis: Axis.vertical,
            child: FadeTransition(
              opacity: opacity,
              child: Container(
                padding: const EdgeInsets.only(left: 4, bottom: 5),
                color: Theme.of(context).colorScheme.surface,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      'Categories',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 22,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Icon(
                      Icons.category,
                      color: Colors.black87,
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 45,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(0),
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (ctx, i) => InkWell(
                onTap: () {
                  final countryData =
                      context.read<AppBloc>().state.articels.first.countryData;
                  context.read<AppBloc>().add(
                        AppEventLoadArticels(
                          country: countryData!['code'],
                          category: categories[i][0],
                        ),
                      );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: CategoryChip(categories: categories[i]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
