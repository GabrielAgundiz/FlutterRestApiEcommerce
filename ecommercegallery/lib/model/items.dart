/*
Future<http.Response> fetchAlbum() {
  return http.get(Uri.parse('https://fakestoreapi.com/products/'));
}*/

class Item {
  final String id;
  final String title;
  final String category;
  final String imageUrl;
  final double rating;
  final double price;

  const Item({
    required this.id,
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.rating,
    required this.price,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      imageUrl: json['image'],
      rating: json['rating']['rate'].toDouble(),
      price: json['price'].toDouble(),
    );
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
];*/
