import 'package:ecommercegallery/model/items.dart';
import 'package:ecommercegallery/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemCard extends StatelessWidget {
  final Item item;

  const ItemCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 20),
      child: Container(
        color: Colors.white,
        height: 330,
        width: 190,
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Image(
                  height: 190,
                  width: 210,
                  fit: BoxFit.cover,
                  image: NetworkImage(item.imageUrl),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.category,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.orange,
                              ),
                              Text(
                                '${item.rate}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '\$${item.price.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
                                color: Colors.grey[600]),
                          ),
                          ShoppingActionsWidget(item.id),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShoppingActionsWidget extends StatelessWidget {
  final int idItem;

  const ShoppingActionsWidget(this.idItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingCarBloc, ShoppingCarState>(
        builder: (context, shoppingCarState) {
      if (shoppingCarState.itemIds.contains(idItem)) {
        return TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.black,
          ),
          onPressed: () {
            _removeFromCar(context, idItem);
          },
          child: const Text('Quitar del Carrito'),
        );
      } else {
        return TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.black,
          ),
          onPressed: () {
            _addToCar(context, idItem);
          },
          child: Text('Agregar al Carrito'),
        );
      }
    });
  }

  void _addToCar(BuildContext context, int idItem) {
    var shoppingCarBloc =
        context.read<ShoppingCarBloc>(); //que es lo que quiero leer
    shoppingCarBloc.add(AddItemToCar(idItem));
  }

  void _removeFromCar(BuildContext context, int idItem) {
    var shoppingCarBloc =
        context.read<ShoppingCarBloc>(); //que es lo que quiero leer
    shoppingCarBloc.add(RemoveItemFromCar(idItem));
  }
}
