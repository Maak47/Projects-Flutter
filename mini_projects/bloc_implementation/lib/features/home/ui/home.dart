import 'package:bloc_implementation/features/cart/ui/cart.dart';
import 'package:bloc_implementation/features/home/ui/product_tile_widget.dart';
import 'package:bloc_implementation/features/wishlist/ui/wishlist.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';
// import '../bloc/home_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Wishlist()));
        } else if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cart()));
        } else if (state is HomeProductItemCartedActionState) {
          // print('BUtton pressed');
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Item\'s in cart.')));
        } else if (state is HomeProductItemWishlistedActionState) {
          // print('BUtton pressed');
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Item added to wishlist.')));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(
              body: Center(child: LinearProgressIndicator()),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: const Text('Home'),
                actions: [
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeWishlistButtonNavigateEvent());
                    },
                    icon: const Icon(Icons.favorite_border_outlined),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeCartButtonNavigateEvent());
                    },
                    icon: const Icon(Icons.shopping_cart_outlined),
                  ),
                ],
              ),
              body: ListView.builder(
                itemCount: successState.products.length,
                itemBuilder: ((context, index) {
                  return ProductTileWidget(
                    homeBloc: homeBloc,
                    productModel: successState.products[index],
                  );
                }),
              ),
            );

          case HomeErrorState:
          default:
            return SizedBox();
        }
      },
    );
  }
}
