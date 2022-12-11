import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constant/categories.dart';
import '../../logic/bloc/app_bloc.dart';

class CountriesScreen extends StatelessWidget {
  static const routeName = 'country';
  const CountriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.shadow,
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.shadow,
        foregroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text(
          'Choose Country',
          style: TextStyle(
              fontWeight: FontWeight.w700, fontStyle: FontStyle.italic),
        ),
      ),
      body: GridView.builder(
        itemCount: countriesData.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (ctx, i) => InkWell(
          onTap: () {
            // Navigator.of(context).pop(countriesData[i]);
            context.read<AppBloc>().add(
                  AppEventGoToNewsView(
                    countriesData: countriesData[i],
                  ),
                );
            Navigator.of(context).pop();
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            height: 200,
            width: double.infinity,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.shadow,
                  radius: 35,
                  child: Hero(
                    tag: countriesData[i]['code'].toString(),
                    child: FadeInImage(
                      image: NetworkImage(countriesData[i]['flag']!),
                      placeholder: const AssetImage('assets/images/flag.jpg'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  countriesData[i]['name']!,
                  style: const TextStyle(color: Colors.black, fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
