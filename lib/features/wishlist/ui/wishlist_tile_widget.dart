import 'package:flutter/material.dart';
import 'package:flutter_bloc_project/features/home/models/home_product_data.dart';
import 'package:flutter_bloc_project/features/wishlist/bloc/wishlist_bloc.dart';



class WishlistTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel ;
  final WishlistBloc wishlistBloc ;
  const WishlistTileWidget({super.key, required this.productDataModel, required this.wishlistBloc});

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(productDataModel.imageUrl))
            ),
          ),
          const SizedBox(height: 20,),
          Text(productDataModel.name , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 18),),
          Text(productDataModel.description),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$' + productDataModel.price.toString() , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 18),),
              Row(
                children:[
                  IconButton(
                      onPressed: () {
                        wishlistBloc.add(WishlistRemoveFromWishlistEvent(
                            productDataModel: productDataModel));
                      },
                      icon: const Icon(
                        Icons.favorite,

                      )),
                  IconButton(
                      onPressed: () {},

                      icon: const Icon(
                        Icons.shopping_bag_outlined,

                      )),
                ] ,
              )
            ],
          ),

        ],
      ),
    );
  }
}
