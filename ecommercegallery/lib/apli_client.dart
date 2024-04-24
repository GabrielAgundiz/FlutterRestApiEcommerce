import 'dart:convert';
import 'dart:isolate';
import 'package:http/http.dart' as http;
import 'model/items.dart';

class ApiClient {
  static const baseUrl = "https://fakestoreapi.com/products/";

  Future<Item> getItem(int id) async {
    ReceivePort receivePort = ReceivePort();

    await Isolate.spawn(_getItemIsolate, [id, receivePort.sendPort]);
    Item item = await receivePort.first;

    return item;
  }

  static void _getItemIsolate(List<Object> args) async {
    dynamic id = args[0];
    dynamic sendPort = args[1];

    final response =
        await http.get(Uri.parse("${baseUrl}${id}")); //obtengo la info de un id

    if (response.statusCode == 200) {
      Item item = Item.fromJson(
          jsonDecode(response.body)); //convierto la respuesta en json
      sendPort.send(item); // Envía el item de vuelta al hilo principal
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