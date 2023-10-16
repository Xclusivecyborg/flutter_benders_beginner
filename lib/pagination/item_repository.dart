import 'package:hooks_riverpod/hooks_riverpod.dart';

class Item {
  final String name;
  final String description;
  final String price;
  final String image;

  Item({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });
}

class ItemResponse {
  final List<Item> items;
  final int totalItems;
  final int totalPages;
  final int currentPage;

  ItemResponse({
    required this.items,
    required this.totalItems,
    required this.totalPages,
    required this.currentPage,
  });

  bool get isLastPage => currentPage == totalPages;
}

abstract class ItemRepository {
  Future<AppResponse<ItemResponse>> fetchItems({
    required int page,
    required int limit,
  });
}

class ItemRepositoryImpl implements ItemRepository {
  @override
  Future<AppResponse<ItemResponse>> fetchItems({
    required int page,
    required int limit,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    try {
      final items = List.generate(
        limit,
        (index) => Item(
          name: 'Item $index',
          description: 'Description $index',
          price: '\$${index * 100}',
          image: 'https://picsum.photos/200/300?random=$index',
        ),
      );

      final moreItems = List.generate(
        limit,
        (index) => Item(
          name: 'More Item Item $index $page',
          description: 'Description $index',
          price: '\$${index * 100}',
          image: 'https://picsum.photos/200/300?random=$index',
        ),
      );
      return AppResponse<ItemResponse>(
        successFul: true,
        data: ItemResponse(
          items: switch (page > 0) {
            true => moreItems,
            false => items,
          },
          totalItems: 100,
          totalPages: 5,
          currentPage: page,
        ),
      );
    } catch (e) {
      return AppResponse<ItemResponse>(
          successFul: false, errorMessage: 'Something went wrong');
    }
  }
}

final itemRepository = Provider((ref) => ItemRepositoryImpl());

class AppResponse<T> {
  final bool successFul;
  T? data;
  final String? errorMessage;

  AppResponse({
    required this.successFul,
    this.data,
    this.errorMessage,
  });
}
