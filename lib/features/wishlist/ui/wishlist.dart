import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:flutter_bloc_project/features/wishlist/ui/wishlist_tile_widget.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}


class _WishlistState extends State< Wishlist> {
  final WishlistBloc wishlistBloc = WishlistBloc();

  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist Items'),
      ),
      body:BlocConsumer<WishlistBloc,WishlistState>(
        bloc: wishlistBloc,
        listenWhen:(previous ,current) => current is WishlistActionState ,
        buildWhen: (previous ,current) => current is !WishlistActionState ,
        listener:(context,state){
          if(state is WishlistProductRemovedActionState){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item has been Removed from the Wishlist')));
          }

        } ,
        builder: (context,state){
          switch(state.runtimeType){
            case WishlistSuccessState:
              final successState = state as WishlistSuccessState;
              return ListView.builder(
                  itemCount: successState.wishlistItems.length,
                  itemBuilder: (context , index){
                    return WishlistTileWidget(
                        wishlistBloc: wishlistBloc,
                        productDataModel: successState.wishlistItems[index]);
                  });


            default:
              return Container();
          }

        } ,
      ),
    );
  }
}