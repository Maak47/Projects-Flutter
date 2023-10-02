import 'package:flutter/material.dart';

import '../bloc/home_bloc.dart';
import '../models/home_product_model.dart';

class ProductTileWidget extends StatelessWidget {
  final HomeBloc homeBloc;

  final ProductModel productModel;
  ProductTileWidget({
    super.key,
    required this.productModel,
    required this.homeBloc,
  });

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
                fit: BoxFit.fitWidth,
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
                      homeBloc.add(HomeProductWishlistButtonClickedEvent(
                        clickedProduct: productModel,
                      ));
                    },
                    icon: Icon(Icons.favorite_border),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeProductCartButtonClickedEvent(
                        clickedProduct: productModel,
                      ));
                    },
                    icon: Icon(Icons.shopping_cart_outlined),
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
