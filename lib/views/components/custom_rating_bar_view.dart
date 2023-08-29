import 'package:flutter/material.dart';
import 'package:simple_products/config/theme/theme.dart';

// Source: https://learnflutter.co/flutter-rating-widget-star-rating-bar/

class RatingBarView extends StatelessWidget {
  final double rating;
  final double size;
  final Color color;
  final int? ratingCount;
  const RatingBarView({
    super.key,
    required this.rating,
    this.color = Colors.yellow,
    this.size = 18,
    this.ratingCount,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> starList = [];

    int realNumber = rating.floor();
    int partNumber = ((rating - realNumber) * 10).ceil();

    for (int i = 0; i < 5; i++) {
      if (i < realNumber) {
        starList.add(Icon(Icons.star, color: color, size: size));
      } else if (i == realNumber) {
        starList.add(SizedBox(
          height: size,
          width: size,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Icon(Icons.star, color: color, size: size),
              ClipRect(
                clipper: _Clipper(part: partNumber),
                child: Icon(Icons.star, color: Colors.grey, size: size),
              )
            ],
          ),
        ));
      } else {
        starList.add(Icon(Icons.star, color: Colors.grey, size: size));
      }
    }
    starList.add(
      Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            '(${ratingCount ?? double.parse(rating.toStringAsFixed(1))})',
            style: AppTheme.mediumText.copyWith(
              fontSize: size * 0.7,
            ),
          )),
    );

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: starList,
    );
  }
}

class _Clipper extends CustomClipper<Rect> {
  final int part;

  _Clipper({required this.part});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(
      (size.width / 10) * part,
      0.0,
      size.width,
      size.height,
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => true;
}
