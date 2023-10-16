import 'package:flutter_benders_beginner/pagination/item_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeNotifer extends StateNotifier<HomeNotiferState> {
  HomeNotifer(this._itemRepository) : super(HomeNotiferState.initial());
  final ItemRepository _itemRepository;

  Future<void> fetchItems({
    bool fetchMore = false,
  }) async {
    var page = state.itemResponse?.currentPage ?? 0;

    if (fetchMore && (state.itemResponse?.isLastPage ?? false)) return;
    if (fetchMore) {
      page += 1;
      state = state.copyWith(loadState: LoadState.fetchMore);
    }

    try {
      final response = await _itemRepository.fetchItems(page: page, limit: 20);

      if (!response.successFul) {
        throw response.errorMessage ?? 'Something went wrong';
      }

      final loadState = switch (response.data?.isLastPage) {
        true => LoadState.completed,
        _ => LoadState.loaded,
      };
      List<Item> data = switch (fetchMore) {
        true => [
            ...state.items,
            ...response.data?.items ?? <Item>[],
          ],
        _ => response.data?.items ?? <Item>[],
      };
      state = state.copyWith(
        loadState: loadState,
        items: data,
        itemResponse: response.data,
      );
    } catch (e) {
      state = state.copyWith(
        loadState: LoadState.error,
      );
    }
  }
}

class HomeNotiferState {
  final LoadState loadState;
  final ItemResponse? itemResponse;
  final List<Item> items;
  HomeNotiferState({
    required this.loadState,
    this.itemResponse,
    required this.items,
  });
  factory HomeNotiferState.initial() {
    return HomeNotiferState(
      loadState: LoadState.loading,
      items: const [],
    );
  }
  HomeNotiferState copyWith({
    LoadState? loadState,
    ItemResponse? itemResponse,
    List<Item>? items,
  }) {
    return HomeNotiferState(
      loadState: loadState ?? this.loadState,
      itemResponse: itemResponse ?? this.itemResponse,
      items: items ?? this.items,
    );
  }
}

final homeNotifer =
    StateNotifierProvider.autoDispose<HomeNotifer, HomeNotiferState>(
  (ref) => HomeNotifer(
    ref.read(itemRepository),
  ),
);

enum LoadState {
  loading,
  idle,
  loaded,
  error,
  fetchMore,
  completed,
}
