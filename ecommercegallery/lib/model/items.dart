/*
Future<http.Response> fetchAlbum() {
  return http.get(Uri.parse('https://fakestoreapi.com/products/'));
}*/

class Item {
  final int id;
  final String title;
  final String category;
  final String imageUrl;
  final double rate;
  final double price;

  const Item({
    required this.id,
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.rate,
    required this.price,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'title': String title,
        'category': String category,
        'image': String imageUrl,
        'rating': Map<String, dynamic> rating,
        'price': num price,
      } =>
        Item(
          id: id,
          title: title,
          category: category,
          imageUrl: imageUrl,
          rate: rating['rate'].toDouble(),
          price: price.toDouble(),
        ),
      _ => throw const FormatException('Fallo en la carga'),
    };
  }
}

/*final List<Item> items = [
  Item(
    title: 'Essential Men\'s T-shirt New Colection',
    category: 'Shirt',
    imageUrl: 'https://ss223.liverpool.com.mx/xl/1119270109.jpg',
    rating: 4.9,
    price: 240.0,
  ),
  Item(
    title: 'Essential Men\'s T-shirt New Colection',
    category: 'Shirt',
    imageUrl: 'https://ss223.liverpool.com.mx/xl/1119270109.jpg',
    rating: 4.9,
    price: 240.0,
  ),
  Item(
    title: 'Essential Men\'s T-shirt New Colection',
    category: 'Shirt',
    imageUrl: 'https://ss223.liverpool.com.mx/xl/1119270109.jpg',
    rating: 4.9,
    price: 240.0,
  ),
];
Item(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      imageUrl: json['image'],
      rating: json['rating'],
      price: json['price'],
    );*/
