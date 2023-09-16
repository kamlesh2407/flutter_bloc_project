import 'package:flutter/material.dart';
import 'package:flutter_bloc_project/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc_project/features/home/models/home_product_data.dart';


class ProductTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel ;
  final HomeBloc homeBloc ;
  const ProductTileWidget({super.key, required this.productDataModel, required this.homeBloc});

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$' + productDataModel.price.toString() , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 18),),
              Row(
                children:[
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeProductWishListButtonClickedEvent(
                          clickedProduct : productDataModel
                        ));
                      },
                      icon: const Icon(
                        Icons.favorite_border,

                      )),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeProductCartButtonClickedEvent(
                            clickedProduct: productDataModel));
                      },
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
