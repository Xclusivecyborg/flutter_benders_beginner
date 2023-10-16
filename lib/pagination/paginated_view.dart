

import 'package:flutter/material.dart';
import 'package:flutter_benders_beginner/pagination/home_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PaginatedView extends ConsumerStatefulWidget {
  const PaginatedView({super.key, required this.title});
  final String title;

  @override
  ConsumerState<PaginatedView> createState() => _PaginatedViewState();
}

class _PaginatedViewState extends ConsumerState<PaginatedView> {
  @override
  void initState() {
    ref.read(homeNotifer.notifier).fetchItems();
    super.initState();
  }

//Paginate our data such that we are able to fetch in sequence from our database.
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeNotifer);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: switch (state.loadState) {
        LoadState.loading => const Center(
            child: CircularProgressIndicator(),
          ),
        LoadState.error => const Center(
            child: Text('Something went wrong'),
          ),
        _ when state.items.isEmpty => const Center(
            child: Text('No items found'),
          ),
        _ => NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollEndNotification &&
                  notification.metrics.extentAfter == 0) {
                ref.read(homeNotifer.notifier).fetchItems(fetchMore: true);
              }
              return true;
            },
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text(item.description),
                        leading: Image.network(item.image),
                      );
                    },
                  ),
                ),
                if (state.loadState == LoadState.fetchMore)
                  const Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          )
      },
    );
  }
}
