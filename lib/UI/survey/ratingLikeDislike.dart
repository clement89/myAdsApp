import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class LikeRating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
        initialRating: 0,
        itemCount: 3,
        itemPadding: EdgeInsets.only(left: 40,top: 20),
        itemBuilder: (context, index) {
      switch (index) {
        case 0:
          return Icon(
            Icons.sentiment_very_dissatisfied,
            color: Colors.red,
          );
        case 1:
          return Icon(
            Icons.sentiment_neutral,
            color: Colors.amber,
          );

        case 2:
          return Icon(
            Icons.sentiment_very_satisfied,
            color: Colors.green,
          );
      }
    },
    onRatingUpdate: (rating) {
    print(rating);
    },
    );
  }
}
