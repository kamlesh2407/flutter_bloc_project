import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_project/data/cart_items.dart';
import 'package:flutter_bloc_project/data/grocery_data.dart';
import 'package:flutter_bloc_project/data/wishlist_items.dart';
import 'package:meta/meta.dart';

import '../models/home_product_data.dart';

part 'home_event.dart';
part 'home_state.dart';

class   HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {

    on<HomeInitialEvent>(homeInitialEvent);

    on<HomeProductWishListButtonClickedEvent>(homeProductWishListButtonClickedEvent);

    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    
    on<HomeWishListButtonNavigateEvent>(homeWishListButtonNavigateEvent);
    
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
    
    
  }


  Future<FutureOr<void>> homeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 3));
    emit(HomeLoadedSuccessState(products: Grocerydata.groceryProducts.map((e) =>
        ProductDataModel(
            id:e['id'],
            name: e['name'],
            description: e['description'],
            price: e['price'],
            imageUrl: e['imageUrl'])).toList()
    ));
  }

  FutureOr<void> homeProductWishListButtonClickedEvent(HomeProductWishListButtonClickedEvent event, Emitter<HomeState> emit) {
    print('Wishlist product');
    wishlistItems.add(event.clickedProduct);
    emit(HomeProductItemWishlistedActionState());
  }

  FutureOr<void> homeProductCartButtonClickedEvent(HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    print('Shopping product');
    cartItems.add(event.clickedProduct);
    emit(HomeProductItemCartlistedActionState());

  }

  FutureOr<void> homeCartButtonNavigateEvent(HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    print(' cart navigate clicked');
    emit(HomeNavigateToCartPageActionState());
  }

  FutureOr<void> homeWishListButtonNavigateEvent(HomeWishListButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('Wishlist navigate clicked');
    emit(HomeNavigateToWishlistPageActionState());
  }


}
