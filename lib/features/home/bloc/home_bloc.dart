import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/data/cart_items.dart';
import 'package:shop_app/data/grocery_data.dart';
import 'package:shop_app/data/wishlist_items.dart';
import 'package:shop_app/features/home/models/home_product_data.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    //for operations
    on<HomeProductWishlistButtomClickedEvent>(
      homeProductWishlistButtomClickedEvent,
    );

    on<HomeProductCartButtomClickedEvent>(homeProductCartButtomClickedEvent);
    // initial eveny
    on<HomeInitialEvent>(homeInitialEvent);
    // registering a event for a wishlist
    on<HomeWishlishtButtonNavigateClickedEvent>(
      homeWishlishtButtonNavigateClickedEvent,
    );

    // register event for a cart
    on<HomeCartButtonNavigateClickedEvent>(homeCartButtonNavigateClickedEvent);
  }
  FutureOr<void> homeInitialEvent(
    HomeInitialEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());

    await Future.delayed(Duration(seconds: 3));

    final products =
        GroceryData.groceryProducts
            .map(
              (e) => PoductDataModel(
                e['id'],
                e['name'],
                e['description'],
                e['price'],
                e['imageUrl'],
              ),
            )
            .toList();

    emit(HomeLoadedSuccessState(products));
  }

  // making a methods for a registered events
  FutureOr<void> homeWishlishtButtonNavigateClickedEvent(
    HomeWishlishtButtonNavigateClickedEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(HomeNavigateToWishlistPage());
  }

  FutureOr<void> homeCartButtonNavigateClickedEvent(
    HomeCartButtonNavigateClickedEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(HomeNavigateToCartPage());
  }

  // operation event handelings

  FutureOr<void> homeProductWishlistButtomClickedEvent(
    HomeProductWishlistButtomClickedEvent event,
    Emitter<HomeState> emit,
  ) {
    print("Like product");
    WishlistItems.add(event.clickedProduct);
    emit(HomeProductItemWishlistedState());
  }

  FutureOr<void> homeProductCartButtomClickedEvent(
    HomeProductCartButtomClickedEvent event,
    Emitter<HomeState> emit,
  ) {
    print("Add to cart");
    cartItems.add(event.clickedProduct);
    emit(HomeProductCartedState());
  }
}
