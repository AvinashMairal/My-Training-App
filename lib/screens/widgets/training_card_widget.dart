import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:my_trainings_app/model/training_model.dart';
import 'package:my_trainings_app/screens/training_detail_screen.dart';
import 'package:my_trainings_app/screens/widgets/text_widget_utility.dart';
import 'package:my_trainings_app/utils/app_constants.dart';

class TrainingCardWidget extends StatefulWidget {
  final TrainingResponse training;
  const TrainingCardWidget({super.key, required this.training});

  @override
  State<TrainingCardWidget> createState() => _TrainingCardWidgetState();
}

class _TrainingCardWidgetState extends State<TrainingCardWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => TrainingDetailScreen(
              selectedTraining: widget.training,
            ),
          ),
        );
      },
      child: Card(
        // Define the shape of the card
        color: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Add padding around the row widget
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Add an image widget to display an image
                  SizedBox(
                    //color: Colors.amber,
                    height: 120,
                    width: 100,
                    child: Column(
                      children: [
                        TextWidgetUtility.buildSubTitleText(
                          title: widget.training.date ?? "",
                        ),
                        SizedBox(width: 5),
                        TextWidgetUtility.buildSmallText(
                          title: widget.training.time ?? "",
                        ),
                        Expanded(child: SizedBox()),
                        TextWidgetUtility.buildSmallText(
                          title:
                              "${widget.training.country?.country}, ${widget.training.country?.abbreviation}",
                          isBold: true,
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: Dash(
                      direction: Axis.vertical,
                      length: 120,
                      // dashLength: 15,
                      dashColor: AppColors.verticalDividerColor,
                    ),
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        // Add some spacing between the top of the card and the title
                        Container(height: 5),
                        // Add a title widget
                        TextWidgetUtility.buildSmallText(
                          title: 'Filling Fast!',
                          color: AppColors.primaryColor,
                          isBold: true,
                        ),
                        TextWidgetUtility.buildSubTitleText(
                          title: widget.training.name ?? "",
                        ),

                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              maxRadius: 18,
                              backgroundImage: NetworkImage(
                                  'https://tse1.mm.bing.net/th?id=OIP.GHGGLYe7gDfZUzF_tElxiQHaHa&pid=Api&P=0&h=180'),
                              child: Text(
                                "${widget.training.id}",
                                style: TextStyle(color: Colors.transparent),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidgetUtility.buildNormalText(
                                    title:
                                        "${widget.training.trainer?.firstName} ${widget.training.trainer?.lastName}",
                                    isBold: true,
                                  ),
                                  TextWidgetUtility.buildSmallText(
                                    title: "${widget.training.trainer?.email}",
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          height: 30,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                              ),
                              child: TextWidgetUtility.buildNormalText(
                                title: 'Enroll Now',
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
