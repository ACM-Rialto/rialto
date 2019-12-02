import 'package:rialto/data/rialto_user.dart';

class Review {

  // String id;
  // String name;
  // String email;
  // String message;
  // String to;
  // String from;

  // String id;
  // RialtoUser user;
  String buyer;
  String seller;
  String itemId;
  double rating;
  String review;

  // Review({this.user, this.rating, this.review});
  Review({this.buyer, this.seller, this.rating, this.review, this.itemId});

  Review.fromMap(Map snapshot, String id) :
        // id = id ?? '',
        // id = id ?? '',
        buyer = snapshot['buyer'] ?? '',
        seller = snapshot['seller'] ?? '',
        itemId = snapshot['itemId'] ?? '',
        rating = snapshot['rating'] ?? '',
        review = snapshot['review'] ?? '';

  toJson() {
    return {
      "itemId": itemId.toString(),
      "buyer": buyer,
      "seller": seller,
      "rating": rating.toString(),
      "review": review
    };
  }
}
