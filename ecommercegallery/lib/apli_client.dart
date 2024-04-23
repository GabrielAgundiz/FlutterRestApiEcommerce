import 'dart:convert';

import 'package:http/http.dart' as http;

import 'model/items.dart';

class ApiClient {
  static const baseUrl = "https://fakestoreapi.com/products/";

  Future<Item> getItem(String id) async {
    final response = await http.get(Uri.parse("${baseUrl}${id}"));

    if (response.statusCode == 200) {
      return Item.fromJson(
          jsonDecode(response.body)); //convierto la respuesta en json
    } else {
      throw Exception("Error al obtener el item");
    }
  }
}
