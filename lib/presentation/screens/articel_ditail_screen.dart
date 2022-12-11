import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../logic/bloc/app_bloc.dart';
import '../widgets/article_detail_container_widget.dart';

class ArticelDetailsScreen extends HookWidget {
  static const routeName = 'articel-detail';
  const ArticelDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    useEffect(() {
      scrollController.addListener(() {
        if (scrollController.position.haveDimensions) {
          // Navigator.of(context).pop();
        }
      });
      return null;
    }, [scrollController]);
    final articel = context.read<AppBloc>().state.articel!;
    return
        // onVerticalDragCancel: () {
        //   Navigator.of(context).pop();
        // },
        Scaffold(
      backgroundColor: Theme.of(context).colorScheme.shadow,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(
                    80,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).colorScheme.surface,
                          size: 30,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Share.share(articel.articalUrl);
                        },
                        icon: Icon(
                          Icons.share,
                          color: Theme.of(context).colorScheme.surface,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Hero(
                tag: articel.id!,
                child: Container(
                  height: 220,
                  width: double.infinity,
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurStyle: BlurStyle.solid,
                            spreadRadius: 2,
                            blurRadius: 3,
                            color: Colors.grey.shade800)
                      ],
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                          image: NetworkImage(articel.imageUrl),
                          fit: BoxFit.fill)),
                ),
              ),
              DetailsContainer(
                text: articel.title,
              ),
              const SizedBox(
                height: 20,
              ),
              DetailsContainer(
                text: articel.description,
              ),
              DetailsContainer(
                text: articel.content,
              ),
              Container(
                height: 60,
                width: 340,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(width: 2)),
                child: ElevatedButton(
                  onPressed: () {
                    launchUrl(
                      Uri.parse(articel.articalUrl),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(
                      const Size(330, 50),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.surface,
                    ),
                    elevation: MaterialStateProperty.all(8),
                    side: MaterialStateProperty.all(
                      const BorderSide(
                        strokeAlign: StrokeAlign.center,
                      ),
                    ),
                  ),
                  child: const Text('Open The Articel in Web Site'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }
}
