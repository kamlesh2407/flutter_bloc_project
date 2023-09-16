
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc_project/features/home/ui/product_tile_widgets.dart';
import '../../wishlist/ui/wishlist.dart';
import '../../cart/ui/cart.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Cart()));
        }
        if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Wishlist()));
        }
        else if( state is HomeProductItemCartlistedActionState){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item has been Added to the Cart')));
        }
        else if( state is HomeProductItemWishlistedActionState){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item has been Added to the Wishlist')));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );

          case HomeLoadedSuccessState:
            final  successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.teal,
                title: const Text(
                  'Grocery App',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeWishListButtonNavigateEvent());
                      },
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeCartButtonNavigateEvent());
                      },
                      icon: const Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.white,
                      )),
                ],
              ),
              body:ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context , index){
                return ProductTileWidget(
                    productDataModel: successState.products[index], homeBloc: homeBloc,);
              }) ,
            );

          case HomeErrorState:
            return const Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );

          default:
            return const SizedBox();
        }
      },
    );
  }
}
