part of 'home_bloc.dart';

@immutable
abstract class HomeState{}

abstract class HomeActionState extends HomeState{}


class HomeInitial extends HomeState{}

class HomeLoadingState extends HomeState{}

class HomeLoadedSuccessState  extends HomeState{
  final List<ProductDataModel> products ;
  HomeLoadedSuccessState({
    required this.products
  });
}

class HomeErrorState extends HomeEvent{}

class HomeNavigateToWishlistPageActionState extends HomeActionState{}

class HomeNavigateToCartPageActionState extends HomeActionState{}


class HomeProductItemWishlistedActionState extends HomeActionState{}


class HomeProductItemCartlistedActionState extends HomeActionState{}
