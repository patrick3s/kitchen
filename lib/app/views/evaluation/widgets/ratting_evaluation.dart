import 'package:flutter/material.dart';
import 'package:multidelivery/presenters/evaluation.dart';
import 'package:multidelivery/shared/icons_platform.dart';
import 'package:rating_bar/rating_bar.dart';

class RattingEvaluation extends StatelessWidget {
  final EvaluationPresenter presenter;
  final Size size;
  const RattingEvaluation({Key key, this.size, this.presenter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('De sua nota aqui',
            style: TextStyle(
              fontSize: size.width * .045
            ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormField<double>(
              initialValue:presenter.controller.evaluation.averange,
              builder: (state) {
                presenter.controller.evaluation.averange = state.value;
                return RatingBar(
                  initialRating: state.value,
                  onRatingChanged: (rating) {
                    state.didChange(rating);
                  },
                  filledIcon: IconsPlatform.star,
                  emptyIcon: IconsPlatform.starBorder,
                  halfFilledIcon: IconsPlatform.starHalf,
                  isHalfAllowed: true,
                  filledColor: Colors.orange,
                  emptyColor: Colors.grey,
                  halfFilledColor: Colors.orangeAccent,
                  size: size.width * .08
                );
              }
            ),
          )
        ],
      ),
    );
  }
}
