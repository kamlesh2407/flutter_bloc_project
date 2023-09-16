import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/features/cart/ui/cart_tile_widget.dart';
import '../bloc/cart_bloc.dart';




class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Items'),
      ),
      body:BlocConsumer<CartBloc,CartState>(
        bloc: cartBloc,
        listenWhen:(previous ,current) => current is CartActionState ,
        buildWhen: (previous ,current) => current is !CartActionState ,
        listener:(context,state){
          if( state is CartProductRemovedActionState){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item has been Removed from the Cart')));
          }

        } ,
        builder: (context,state){
          switch(state.runtimeType){
            case CartSuccessState:
              final successState = state as  CartSuccessState;
              return ListView.builder(
                  itemCount: successState.cartItems.length,
                  itemBuilder: (context , index){
                    return CartTileWidget(
                      cartBloc: cartBloc,
                      productDataModel: successState.cartItems[index]);
                  });


            default:
              return Container();
          }

        } ,
      ),
    );
  }
}