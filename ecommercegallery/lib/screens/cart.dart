import 'package:ecommercegallery/model/items.dart';
import 'package:ecommercegallery/state.dart';
import 'package:ecommercegallery/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/hotmail.dart';

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
            body: const Center(
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

  void sendMail(double costo) {
    EmailSender.sendMailFromOutlook(costo);
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
                      return const Center(child: CircularProgressIndicator());
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
                            child: Center(
                              child: TextButton(
                                onPressed: () {
                                  _CartPageState().sendMail(costo);
                                },
                                child: const Text(
                                  "Buy now",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
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

class EmailSender {
  static final outlookSmtp =
      hotmail(dotenv.env["OUTLOOK_EMAIL"]!, dotenv.env["OUTLOOK_PASSWORD"]!);

  static Future<void> sendMailFromOutlook(double costo) async {
    final message = Message()
      ..from = Address(dotenv.env["OUTLOOK_EMAIL"]!, 'Confirmation Bot')
      ..recipients.add('agzz2003@gmail.com')
      ..subject = 'Recibo de pago Ecommers'
      ..html =
          '<body style="text-align: center; font-family: Tahoma, Geneva, Verdana, sans-serif;"> <div style="margin:auto; border-radius: 10px; width: 300px; padding: 10px; box-shadow: 1px 1px 1px 1px rgb(174, 174, 174);"> <h2>Hola, el costo de su pedido es el siguiente</h2> <p>\$$costo</p></div></body>';

    try {
      final sendReport = await send(message, outlookSmtp);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
