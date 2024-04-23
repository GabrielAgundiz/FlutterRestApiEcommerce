import 'dart:convert';

import 'package:http/http.dart' as http;

import 'model/items.dart';

class ApiClient {
  static const baseUrl = "https://fakestoreapi.com/products/";

  Future<Item> getItem(int id) async {
    final response =
        await http.get(Uri.parse("${baseUrl}${id}")); //obtengo la info de un id

    if (response.statusCode == 200) {
      return Item.fromJson(
          jsonDecode(response.body)); //convierto la respuesta en json
    } else {
      throw Exception("Error al obtener el item");
    }
  }

  Future<List<Item>> getItems(List<int> ids) async {
    List<Item> items = [];
    for (int id in ids) {
      items.add((await getItem(id)));
    }
    return items;
  }
}
