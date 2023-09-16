import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_project/data/wishlist_items.dart';

import '../../home/models/home_product_data.dart';


part 'wishlist_event.dart';
part 'wishlist_state.dart';



class WishlistBloc extends Bloc<WishlistEvent ,WishlistState>{
  WishlistBloc(): super(WishlistInitial()){
    on<WishlistInitialEvent>(wishlistInitialEvent);
    on<WishlistRemoveFromWishlistEvent>(wishlistRemoveFromWishlistEvent);

  }


  FutureOr<void> wishlistInitialEvent(WishlistInitialEvent event, Emitter<WishlistState> emit) {
    emit(WishlistSuccessState(wishlistItems: wishlistItems));
  }

  FutureOr<void> wishlistRemoveFromWishlistEvent(WishlistRemoveFromWishlistEvent event, Emitter<WishlistState> emit) {
    wishlistItems.remove(event.productDataModel);
    emit(WishlistRemovedActionState(wishlistItems: wishlistItems));
    emit(WishlistSuccessState(wishlistItems: wishlistItems));

  }
}
