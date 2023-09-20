import 'dart:convert';

class JoylaModel {
  final List<Product> content;
  final Pageable pageable;
  final int totalElements;
  final int totalPages;
  final bool last;
  final int size;
  final int number;
  final Sort sort;
  final bool first;
  final int numberOfElements;
  final bool empty;

  JoylaModel({
    required this.content,
    required this.pageable,
    required this.totalElements,
    required this.totalPages,
    required this.last,
    required this.size,
    required this.number,
    required this.sort,
    required this.first,
    required this.numberOfElements,
    required this.empty,
  });

  factory JoylaModel.fromJson(Map<String, dynamic> json) => JoylaModel(
        content: List<Product>.from(
            (json["content"]?? []).map((x) => Product.fromJson(x))),
        pageable: Pageable.fromJson(json["pageable"] ?? {}),
        totalElements: json["totalElements"] ?? 0,
        totalPages: json["totalPages"] ?? 0,
        last: json["last"] ?? false,
        size: json["size"] ?? 0,
        number: json["number"] ?? 0,
        sort: Sort.fromJson(json["sort"] ?? {}),
        first: json["first"] ?? false,
        numberOfElements: json["numberOfElements"] ?? 0,
        empty: json["empty"] ?? false,
      );

  factory JoylaModel.empty() {
    return JoylaModel.fromJson({});
  }

  Map<String, dynamic> toJson() => {
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
        "pageable": pageable.toJson(),
        "totalElements": totalElements,
        "totalPages": totalPages,
        "last": last,
        "size": size,
        "number": number,
        "sort": sort.toJson(),
        "first": first,
        "numberOfElements": numberOfElements,
        "empty": empty,
      };
}

class Product {
  int id;
  String name;
  String description;
  String state;
  String lat;
  String lan;
  DateTime createdAt;
  String imageMode;
  String imageUrl;
  String imagePath;
  String price;
  int createdBy;
  String currencyType;
  int favoriteId;
  double destination;
  String type;
  String slug;
  String categorySlug;
  String categorySlugRu;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.state,
    required this.lat,
    required this.lan,
    required this.createdAt,
    required this.imageMode,
    required this.imageUrl,
    required this.imagePath,
    required this.price,
    required this.createdBy,
    required this.currencyType,
    required this.favoriteId,
    required this.destination,
    required this.type,
    required this.slug,
    required this.categorySlug,
    required this.categorySlugRu,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        description: json["description"] ?? "",
        state: json["state"] ?? "",
        lat: json["lat"] ?? "",
        lan: json["lan"] ?? "",
        createdAt: DateTime.parse(json["createdAt"]),
        imageMode: json["imageMode"] ?? "",
        imageUrl: json["imageUrl"] ?? "",
        imagePath: json["imagePath"] ?? "",
        price: json["price"] ?? "",
        createdBy: json["createdBy"] ?? 0,
        currencyType: json["currencyType"] ?? "",
        favoriteId: json["favoriteId"]?? 0 ,
        // dynamic changed to int
        destination: json["destination"]?.toDouble() ?? 0.0,
        // bu yerda doubleni tekshiriw kk
        type: json["type"] ?? "",
        slug: json["slug"] ?? "",
        categorySlug: json["categorySlug"] ?? "",
        categorySlugRu: json["categorySlugRu"] ?? "",
      );


  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "state": state,
        "lat": lat,
        "lan": lan,
        "createdAt": createdAt.toIso8601String(),
        "imageMode": imageMode,
        "imageUrl": imageUrl,
        "imagePath": imagePath,
        "price": price,
        "createdBy": createdBy,
        "currencyType": currencyType,
        "favoriteId": favoriteId,
        "destination": destination,
        "type": type,
        "slug": slug,
        "categorySlug": categorySlug,
        "categorySlugRu": categorySlugRu,
      };
}

class Pageable {
  Sort sort;
  int offset;
  int pageNumber;
  int pageSize;
  bool paged;
  bool unpaged;

  Pageable({
    required this.sort,
    required this.offset,
    required this.pageNumber,
    required this.pageSize,
    required this.paged,
    required this.unpaged,
  });

  factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
        sort: Sort.fromJson(json["sort"]),
        offset: json["offset"] ?? 0,
        pageNumber: json["pageNumber"] ?? 0,
        pageSize: json["pageSize"] ?? 0,
        paged: json["paged"] ?? false,
        unpaged: json["unpaged"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "sort": sort.toJson(),
        "offset": offset,
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "paged": paged,
        "unpaged": unpaged,
      };
}

class Sort {
  bool sorted;
  bool unsorted;
  bool empty;

  Sort({
    required this.sorted,
    required this.unsorted,
    required this.empty,
  });

  factory Sort.fromJson(Map<String, dynamic> json) => Sort(
        sorted: json["sorted"] ?? false,
        unsorted: json["unsorted"] ?? false,
        empty: json["empty"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "sorted": sorted,
        "unsorted": unsorted,
        "empty": empty,
      };
}
