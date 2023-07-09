import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final double starSize;
  final Color filledColor;
  final Color emptyColor;

  const RatingStars({
    super.key,
    required this.rating,
    this.starSize = 24,
    this.filledColor = Colors.amber,
    this.emptyColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        double ratingPerStar = 10 / 5;
        double starRating = (index + 1) * ratingPerStar;
        if (rating >= starRating) {
          // 전체 별 채우기
          return Icon(
            Icons.star,
            size: starSize,
            color: filledColor,
          );
        } else if (rating > starRating - ratingPerStar / 2) {
          // 부분 별 채우기 (반쪽 별)
          return Icon(
            Icons.star_half,
            size: starSize,
            color: filledColor,
          );
        } else {
          // 빈 별
          return Icon(
            Icons.star,
            size: starSize,
            color: emptyColor,
          );
        }
      }),
    );
  }
}
