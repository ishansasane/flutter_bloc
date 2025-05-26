part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

// for operations
class HomeInitialEvent extends HomeEvent {}

class HomeProductWishlistButtomClickedEvent extends HomeEvent {
  final PoductDataModel clickedProduct;

  HomeProductWishlistButtomClickedEvent({required this.clickedProduct});
}

class HomeProductCartButtomClickedEvent extends HomeEvent {
  final PoductDataModel clickedProduct;

  HomeProductCartButtomClickedEvent({required this.clickedProduct});
}

//for navigation
class HomeWishlishtButtonNavigateClickedEvent extends HomeEvent {}

class HomeCartButtonNavigateClickedEvent extends HomeEvent {}
