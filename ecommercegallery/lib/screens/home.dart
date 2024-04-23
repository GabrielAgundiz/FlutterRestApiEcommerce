import 'package:ecommercegallery/apli_client.dart';
import 'package:ecommercegallery/model/items.dart';
import 'package:ecommercegallery/widgets/card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ecommerce Gallery',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
                  child: FutureBuilder<Item>(
                future: ApiClient().getItem(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  Item? item = snapshot.data;
                  if (item == null) {
                    return const Text("Error al obtener datos");
                  } else {
                    return ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return ItemCard(item: item);
                        });
                  }
                },
              )

                  /*GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                  shrinkWrap: true,
                  childAspectRatio: 190 / 330,
                  children: items.map((Item) => ItemCard(item: Item)).toList(),
                ),*/
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
