import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_trainings_app/model/training_model.dart';
import 'package:my_trainings_app/screens/training_detail_screen.dart';
import 'package:my_trainings_app/screens/widgets/text_widget_utility.dart';
import 'package:my_trainings_app/utils/app_constants.dart';

class CarouselBannarWidget extends StatefulWidget {
  final List<TrainingResponse> trainings;
  const CarouselBannarWidget({super.key, required this.trainings});

  @override
  State<CarouselBannarWidget> createState() => _CarouselBannarWidgetState();
}

class _CarouselBannarWidgetState extends State<CarouselBannarWidget> {
  final CarouselSliderController _controller = CarouselSliderController();
  List<Widget> imageSliders = [];

  @override
  void initState() {
    _buildImageSliderList();
    super.initState();
  }

  void _buildImageSliderList() {
    print("${widget.trainings[0].imageUrl}");
    imageSliders = // AppConstants.IMG_DATA
        widget.trainings
            .map(
              (training) => InkWell(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: Stack(
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl: training.imageUrl ??
                            "http://via.placeholder.com/350x150",
                        placeholder: (context, url) => Image.asset(
                          'assets/images/placeholder_image.png',
                        ),
                        // const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        // width: 2000.0,
                        // fit: BoxFit.fitWidth,
                      ),

                      //Image.network(item, fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidgetUtility.buildSubTitleText(
                                title: training.name ?? "",
                                color: AppColors.whiteColor,
                              ),
                              TextWidgetUtility.buildNormalText(
                                title:
                                    "${training.country?.country}, ${training.country?.abbreviation}",
                                color: AppColors.whiteColor,
                              ),
                              Text.rich(
                                TextSpan(
                                  text: "",
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: training.oldPrice ?? "",
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: 12,
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: AppColors.primaryColor,
                                        decorationStyle:
                                            TextDecorationStyle.solid,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " ${training.newPrice}",
                                      style: GoogleFonts.aBeeZee(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => TrainingDetailScreen(
                        selectedTraining: training,
                      ),
                    ),
                  );
                },
              ),
            )
            .toList();
  }

  @override
  Widget build(BuildContext context) {
    print("calling carousel build");
    return
        //slider images
        Stack(children: [
      Container(
        height: 120,
        color: AppColors.primaryColor,
      ),
      Positioned(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15, bottom: 8),
              child: TextWidgetUtility.buildTitleText(
                  title: 'Highlights', color: AppColors.whiteColor),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    print("on tap back");
                    _controller.previousPage();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.blackColor.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.all(Radius.circular(
                              5.0) //                 <--- border radius here
                          ),
                    ),
                    height: 80,
                    width: 25,
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 18,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: CarouselSlider(
                      items: imageSliders,
                      carouselController: _controller,
                      options: CarouselOptions(
                          autoPlay: false,
                          enlargeCenterPage: true,
                          viewportFraction: 1,
                          // aspectRatio: 2,
                          height: 180,
                          onPageChanged: (index, reason) {}),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print("on tap next");
                    _controller.nextPage();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.blackColor.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.all(Radius.circular(
                              5.0) //                 <--- border radius here
                          ),
                    ),
                    height: 80,
                    width: 25,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    ]);
  }
}
