import 'package:flutter/material.dart';
import 'package:my_trainings_app/model/training_model.dart';
import 'package:my_trainings_app/screens/training_filter_screen.dart';
import 'package:my_trainings_app/screens/widgets/carousel_bannar_widget.dart';
import 'package:my_trainings_app/screens/widgets/text_widget_utility.dart';
import 'package:my_trainings_app/screens/widgets/training_card_widget.dart';
import 'package:my_trainings_app/utils/app_constants.dart';
import 'package:my_trainings_app/view_model/training_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;

  List<TrainingResponse> trainings = [];

  List _locations = [];
  List _trainingNames = [];
  List _trainers = [];

  Future<void> getTraingsData() async {
    setState(() {
      _isLoading = true;
    });
    trainings = await TrainingViewModel.getTrainingsData(
        selectedLocations: _locations,
        selectedTrainings: _trainingNames,
        selectedTrainers: _trainers);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getTraingsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CircularProgressIndicator()
        : Container(
            color: Colors.transparent,
            child: SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  scrolledUnderElevation: 0,
                  iconTheme: IconThemeData(
                    color: AppColors.whiteColor,
                  ),
                  title: TextWidgetUtility.buildAppBarTitleText(
                      title: 'Trainings'),
                  backgroundColor: AppColors.primaryColor,
                ),
                endDrawer: Drawer(
                  child: ListView(
                    // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                        ),
                        child: TextWidgetUtility.buildTitleText(
                            title: "Hello, User Name!",
                            color: AppColors.whiteColor),
                      ),
                      ListTile(
                        title: TextWidgetUtility.buildNormalText(
                          title: "Home",
                          color: AppColors.primaryColor,
                          isBold: true,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: TextWidgetUtility.buildNormalText(
                          title: "My Trainings",
                          color: AppColors.blackColor,
                          isBold: true,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: TextWidgetUtility.buildNormalText(
                          title: "Settings",
                          color: AppColors.blackColor,
                          isBold: true,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                // Populate the Drawer in the next step.

                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselBannarWidget(
                      trainings: trainings,
                    ),
                    _buildTitleRow(),
                    Expanded(
                      child: Container(
                        color: AppColors.lightGreyColor,
                        child: _buildListView(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget _buildTitleRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidgetUtility.buildSubTitleText(
              title: "Trainings (${trainings.length})"),
          Expanded(child: SizedBox()),
          if (_locations.isNotEmpty ||
              _trainingNames.isNotEmpty ||
              _trainers.isNotEmpty)
            TextButton(
              onPressed: () {
                _locations = [];
                _trainingNames = [];
                _trainers = [];
                getTraingsData();
              },
              child: TextWidgetUtility.buildNormalText(
                  title: "Clear", color: AppColors.primaryColor),
            ),
          Container(
            margin: EdgeInsets.only(left: 0, top: 15, bottom: 8),
            height: 30,
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrainingFilterScreen(),
                  ),
                ).then((value) {
                  if (value == null || value == "") {
                    return;
                  }

                  _locations = value['locations'];
                  _trainingNames = value['trainingName'];
                  _trainers = value['trainer'];
                  getTraingsData();
                });
              },
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                side: BorderSide(
                  // width: 5.0,
                  color: AppColors.greyColor,
                  style: BorderStyle.solid,
                ),
              ),
              icon: Image.asset(
                'assets/images/filter_icon.jpg',
                height: 15,
                width: 15,
                color: AppColors.greyColor,
              ), //Icon(Icons.sort),
              label: TextWidgetUtility.buildNormalText(
                  title: 'Filter', color: AppColors.greyColor),
            ),
          ),
        ],
      ),
    );
  }

  _buildListView() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      itemCount: trainings.length,
      itemBuilder: (context, index) {
        return TrainingCardWidget(
          training: trainings[index],
        );
      },
    );
  }
}
