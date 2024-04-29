import 'package:ecommercegallery/apli_client.dart';
import 'package:ecommercegallery/model/items.dart';
import 'package:ecommercegallery/screens/cart.dart';
import 'package:ecommercegallery/state.dart';
import 'package:ecommercegallery/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> _defaultItems = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingCarBloc, ShoppingCarState>(
        builder: (context, shoppingCarState) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Ecommerce Gallery',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text("4"),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CartPage(shoppingCarState.itemIds)),
                        );
                      },
                      icon: const Icon(Icons.shopping_cart))
                ],
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                    child: FutureBuilder<List<Item>>(
                  future: ApiClient().getItems(_defaultItems),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    List<Item>? item = snapshot.data;
                    if (item == null) {
                      return const Text("Error al obtener datos");
                    } else {
                      return ListView.builder(
                          itemCount: item.length,
                          itemBuilder: (context, index) {
                            return ItemCard(item: item[index]);
                          });
                    }
                  },
                )),
              ],
            ),
          ),
        ),
      );
    });
  }
}
