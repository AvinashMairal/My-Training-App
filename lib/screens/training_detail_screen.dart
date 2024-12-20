import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_trainings_app/model/training_model.dart';
import 'package:my_trainings_app/screens/widgets/show_less_more_text_text.dart';
import 'package:my_trainings_app/screens/widgets/text_widget_utility.dart';
import 'package:my_trainings_app/utils/app_constants.dart';

class TrainingDetailScreen extends StatefulWidget {
  final TrainingResponse selectedTraining;
  const TrainingDetailScreen({super.key, required this.selectedTraining});

  @override
  State<TrainingDetailScreen> createState() => _TrainingDetailScreenState();
}

class _TrainingDetailScreenState extends State<TrainingDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          //floatHeaderSlivers: true,
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                titleSpacing: 0,
                backgroundColor: AppColors.primaryColor,
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                expandedHeight: 180.0,
                stretchTriggerOffset: 300.0,
                leading: IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding: const EdgeInsets.only(left: 40, bottom: 15),
                  title: TextWidgetUtility.buildTitleText(
                      title: widget.selectedTraining.name ?? "",
                      color: AppColors.whiteColor),
                  background: buildImageBanar(),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidgetUtility.buildSubTitleText(
                      title: "Training Details"),
                  DescriptionTextWidget(
                      text:
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
                  TextWidgetUtility.buildSubTitleText(title: "Location"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          "${widget.selectedTraining.country?.country}, ${widget.selectedTraining.country?.abbreviation}",
                          style: StyleUtils.normalTextStyle(),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.location_pin,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                  TextWidgetUtility.buildSubTitleText(title: "Contact Details"),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidgetUtility.buildNormalText(
                          title:
                              "${widget.selectedTraining.trainer?.firstName} ${widget.selectedTraining.trainer?.lastName}",
                          color: AppColors.primaryColor),
                      RichText(
                        text: TextSpan(
                            text: 'Call : ',
                            style: StyleUtils.normalTextStyle(),
                            children: [
                              TextSpan(
                                text: "18001032420",
                                style: StyleUtils.normalTextStyle(
                                    color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // MapUtils.openUrl('tel:${18001032420}');
                                  },
                              ),
                            ]),
                      ),
                      RichText(
                        text: TextSpan(
                            text: 'Email : ',
                            style: StyleUtils.normalTextStyle(),
                            children: [
                              TextSpan(
                                text: "test@gmail.com",
                                style: StyleUtils.normalTextStyle(
                                    color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // MapUtils.openUrl('mailto:test@gmail.com');
                                  },
                              ),
                            ]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextWidgetUtility.buildSubTitleText(title: "Gallary"),
                  const SizedBox(height: 10),
                  buildImageGallary(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildImageBanar() {
    return ClipRRect(
      // borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      child: Stack(
        children: <Widget>[
          CachedNetworkImage(
            fit: BoxFit.fitHeight,
            imageUrl: widget.selectedTraining.imageUrl ??
                "http://via.placeholder.com/350x150", //
            placeholder: (context, url) => Image.asset(
              'assets/images/placeholder_image.png',
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            // width: 1000.0,
          ),
        ],
      ),
    );
  }

  buildImageGallary() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 15),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) => buildImageCard(index),
        itemCount: 4,
      ),
    );
  }

  buildImageCard(int index) {
    return Container(
      padding: const EdgeInsets.only(right: 15),
      width: 300,
      height: 200,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        child: CachedNetworkImage(
          fit: BoxFit.fitHeight,
          imageUrl: "http://via.placeholder.com/350x150",
          placeholder: (context, url) => Image.asset(
            'assets/images/placeholder_image.png',
          ),
          //const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
