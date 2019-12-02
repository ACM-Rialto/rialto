import 'package:rialto/data/rialto_user.dart';

class Review {

  // String id;
  // String name;
  // String email;
  // String message;
  // String to;
  // String from;

  String id;
  RialtoUser user;
  double rating;
  String review;

  // Review({this.user, this.rating, this.review});
  Review({this.user, this.rating, this.review});

  Review.fromMap(Map snapshot, String id) :
        // id = id ?? '',
        // id = id ?? '',
        rating = snapshot['rating'] ?? '',
        review = snapshot['review'] ?? '';

  toJson() {
    return {
      "rating": rating.toString(),
      "review": review
      // "name": name,
      // "email": email,
      // "message": message,
      // "to": to,
      // "from": from
    };
  }
}
