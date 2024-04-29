import 'package:ecommercegallery/model/items.dart';
import 'package:ecommercegallery/state.dart';
import 'package:ecommercegallery/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../apli_client.dart';

class CartPage extends StatefulWidget {
  //obtengo listas de ids
  final List<int> items;
  const CartPage(this.items, {super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingCarBloc, ShoppingCarState>(
        builder: (context, shoppingCarState) {
      if (shoppingCarState.itemIds.isEmpty) {
        return Scaffold(
            appBar: AppBar(
              title: const Text("My Cart"),
            ),
            body: Center(
              child: Text("Aun no hay articulos en el carrito"),
            ));
      }
      return Scaffold(
          appBar: AppBar(
            title: const Text("My Cart"),
          ),
          body: carView(shoppingCarState.itemIds));
    });
  }
}

class carView extends StatelessWidget {
  final List<int> itemIds;

  const carView(this.itemIds, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingCarBloc, ShoppingCarState>(
        builder: (context, shoppingCarState) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder<List<Item>>(
                  future: ApiClient().getItems(itemIds),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    List<Item>? items = snapshot.data;
                    if (items == null) {
                      return const Text("Error al obtener datos");
                    } else {
                      double costo = items.fold<double>(
                          0,
                          (previousValue, element) =>
                              previousValue + element.price);
                      return Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return CartItem(item: items[index]);
                            },
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total: ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "\$$costo",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width / 2 * 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black,
                            ),
                            child: const Center(
                              child: Text(
                                "Buy now",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
