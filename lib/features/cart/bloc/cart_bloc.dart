import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_project/data/cart_items.dart';

import '../../home/models/home_product_data.dart';


part 'cart_event.dart';
part 'cart_state.dart';


class CartBloc extends Bloc<CartEvent ,CartState>{
  CartBloc(): super(CartInitial()){
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemoveFromCartEvent>(cartRemoveFromCartEvent);

  }


  FutureOr<void> cartInitialEvent(CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartSuccessState(cartItems: cartItems));
  }

  FutureOr<void> cartRemoveFromCartEvent(CartRemoveFromCartEvent event, Emitter<CartState> emit) {
    cartItems.remove(event.productDataModel);
    emit(CartRemovedActionState(cartItems: cartItems));
    emit(CartSuccessState(cartItems: cartItems));
  }
}