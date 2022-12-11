import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/articel.dart';
import '../../logic/bloc/app_bloc.dart';
import '../screens/articel_ditail_screen.dart';

// ignore: must_be_immutable
class NewsWidget extends StatefulWidget {
  Articel articel;
  NewsWidget(this.articel, {super.key});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  bool imageError = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Link(widget.articel.articalUrl);
        context.read<AppBloc>().add(
              AppEventGoToDetailsView(articelId: widget.articel.id!),
            );
        Navigator.of(context).pushNamed(ArticelDetailsScreen.routeName,
            arguments: widget.articel.id);
      },
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.shadow),
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Hero(
              tag: widget.articel.id!,
              child: Container(
                height: 130,
                width: 180,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 5,
                      spreadRadius: 3,
                      color: Colors.grey,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(23),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: imageError
                          ? const AssetImage('assets/images/placeholder.png')
                          : NetworkImage(widget.articel.imageUrl)
                              as ImageProvider,
                      onError: (o, s) {
                        setState(() {
                          imageError = true;
                        });
                      }),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: SizedBox(
                child: Text(
                  widget.articel.title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.italic,
                      fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
