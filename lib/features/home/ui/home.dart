import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/features/cart/ui/cart.dart';
import 'package:shop_app/features/home/bloc/home_bloc.dart';
import 'package:shop_app/features/home/ui/product_tile.dart';
import 'package:shop_app/features/wishlist/ui/Wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc(); // Move this above initState

  @override
  void initState() {
    super.initState(); // Always call super.initState() first
    homeBloc.add(HomeInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToWishlistPage) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Wishlist()),
          );
        } else if (state is HomeProductItemWishlistedState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Itme Wishlisted")));
        } else if (state is HomeProductCartedState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Itme Added to Cart")));
        } else if (state is HomeNavigateToCartPage) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Cart()),
          );
        }
      },
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is HomeLoadedSuccessState) {
          final succes = state as HomeLoadedSuccessState;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Shop App",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    homeBloc.add(HomeWishlishtButtonNavigateClickedEvent());
                  },
                  icon: const Icon(Icons.favorite_border, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {
                    homeBloc.add(HomeCartButtonNavigateClickedEvent());
                  },
                  icon: const Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
              backgroundColor: Colors.teal,
            ),
            body: ListView.builder(
              itemCount: succes.products.length,
              itemBuilder: (context, index) {
                return ProductTile(
                  productDataModel: succes.products[index],
                  homeBloc: homeBloc,
                );
              },
            ),
          );
        } else if (state is HomeErrorState) {
          return const Scaffold(body: Center(child: Text("Error")));
        }

        return const SizedBox.shrink(); // Fallback in case no case matches
      },
    );
  }
}
