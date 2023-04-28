class Product {
  int? _totalSize;
  int? _typeId;
  int? _offset;
  late List<ProductModel> _products;
  List<ProductModel> get products => _products;
  Product(
      {required totalSize,
      required typeId,
      required offset,
      required products}) {
    this._totalSize = totalSize;
    this._products = products;
    this._typeId = typeId;
    this._offset = offset;
  }

  Product.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _products = <ProductModel>[];
      json['products'].forEach((v) {
        _products.add(new ProductModel.fromJson(v));
      });
    }
  }
}

class ProductModel {
  int? id;
  String? name;
  String? description;
  String? price;
  String? stars;
  String? img;
  String? rating;
  String? reviews;
  bool? replacable;
  int? typeId;
  String? off;

  ProductModel(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.stars,
      this.img,
      this.rating,
      this.reviews,
      this.replacable,
      this.off,
      this.typeId});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    rating = json['rating'];
    reviews = json['reviews'];
    replacable = json['replacable'];
    typeId = json['type_id'];
    off = json['off'];
  }
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "price": this.price,
      "img": this.img,
      "rating": this.rating,
      "reviews": this.reviews,
      "replacable": this.replacable,
      "typeId": this.typeId,
      "off":this.off
    };
  }
}
