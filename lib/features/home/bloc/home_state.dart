part of 'home_bloc.dart';

@immutable
sealed class HomeState {} // for ui build purpose

sealed class HomeActionState extends HomeState {} // for action purpose

// this is a state that is used to build the ui
final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<PoductDataModel> products;

  HomeLoadedSuccessState(this.products);
}

class HomeErrorState extends HomeState {}

// this is used to action purpose
class HomeProductItemWishlistedState extends HomeActionState {}

class HomeProductCartedState extends HomeActionState {}

class HomeNavigateToWishlistPage extends HomeActionState {}

class HomeNavigateToCartPage extends HomeActionState {}
