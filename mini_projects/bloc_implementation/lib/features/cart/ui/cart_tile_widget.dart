import 'package:bloc_implementation/features/home/models/home_product_model.dart';
import 'package:flutter/material.dart';

import '../bloc/cart_bloc.dart';

class CartTileWidget extends StatelessWidget {
  CartTileWidget({
    super.key,
    required this.cartBloc,
    required this.productModel,
  });
  final ProductModel productModel;
  final CartBloc cartBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  productModel.imageUrl,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            productModel.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(productModel.description),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$ ${productModel.price}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // cartBloc.add(HomeProductWishlistButtonClickedEvent(
                      //   // clickedProduct: productModel,
                      // ));
                    },
                    icon: Icon(Icons.favorite_border),
                  ),
                  IconButton(
                    onPressed: () {
                      cartBloc.add(
                          CartRemoveFromCartEvent(productModel: productModel));
                      // cartBloc.add(HomeProductCartButtonClickedEvent(
                      //   clickedProduct: productModel,
                      // ));
                    },
                    icon: Icon(Icons.shopping_cart),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
