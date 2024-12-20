import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_trainings_app/model/country_model.dart';
import 'package:my_trainings_app/model/trainer_model.dart';
import 'package:my_trainings_app/model/training_model.dart';
import 'package:my_trainings_app/screens/widgets/text_widget_utility.dart';
import 'package:my_trainings_app/utils/app_constants.dart';
import 'package:my_trainings_app/view_model/country_view_model.dart';
import 'package:my_trainings_app/view_model/trainer_view_model.dart';
import 'package:my_trainings_app/view_model/training_view_model.dart';

class TrainingFilterScreen extends StatefulWidget {
  const TrainingFilterScreen({super.key});

  @override
  State<TrainingFilterScreen> createState() => _TrainingFilterScreenState();
}

class _TrainingFilterScreenState extends State<TrainingFilterScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  //main filter list
  List<Map> mainFilterList = [
    {'id': 0, 'name': 'Location'},
    {'id': 1, 'name': 'Training Name'},
    {'id': 2, 'name': 'Trainer'},
  ];

  List<Map> locationList = [];
  List<Map> trainingNameList = [];
  List<Map> trainerList = [];

//filtered data list
  List items = [0, 0, 0];

//filtered data vars
  List selectedLocationList = [];
  List selectedTrainingNameList = [];
  List selectedTrainerList = [];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    updateListData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> updateListData() async {
    setState(() {
      _isLoading = true;
    });

    await updateLocationList();
    await updateTrainingsList();
    await updateTrainerList();

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> updateLocationList() async {
    List<Country> country = await CountryViewModel.getCountry();
    for (int i = 0; i < country.length; i++) {
      var value = {
        'id': country[i].abbreviation,
        'name': "${country[i].country}",
        'value': false
      };
      locationList.add(value);
    }
  }

  Future<void> updateTrainingsList() async {
    List<TrainingResponse> trainings = await TrainingViewModel.getTrainingsData(
        selectedLocations: [], selectedTrainings: [], selectedTrainers: []);
    for (int i = 0; i < trainings.length; i++) {
      var value = {
        'id': trainings[i].id,
        'name': "${trainings[i].name}",
        'value': false
      };
      trainingNameList.add(value);
    }
  }

  Future<void> updateTrainerList() async {
    List<Trainer> trainers = await TrainerViewModel.getTrainers();
    for (int i = 0; i < trainers.length; i++) {
      var value = {
        'id': trainers[i].id,
        'name': "${trainers[i].firstName} ${trainers[i].lastName}",
        'value': false
      };
      trainerList.add(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.whiteColor,
          ),
        ),
        elevation: 0,
        centerTitle: false,
        //backgroundColor: Colors.transparent,
        //backgroundColor: AppColors.appBGGrey,
        title: TextWidgetUtility.buildAppBarTitleText(title: 'Filters'),

        actions: [
          TextButton(
            onPressed: _clearFilter,
            child: Text(
              'Clear filters',
              style: GoogleFonts.aBeeZee(
                color: isFilterSelected() == true
                    ? AppColors.whiteColor
                    : AppColors.greyColor,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
          )
        ],
      ),
      body: _isLoading
          ? const CircularProgressIndicator()
          : Row(
              children: [
                Container(
                  height: double.infinity,
                  width: 150,
                  color: Colors.transparent,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: mainFilterList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        contentPadding:
                            const EdgeInsets.only(left: 10, right: 5),
                        selectedTileColor:
                            AppColors.primaryColor.withOpacity(0.10),
                        // tileColor: Colors.transparent,
                        title: Text(
                          mainFilterList[index]['name'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.aBeeZee(
                            color: index == _selectedIndex
                                ? AppColors.primaryColor
                                : AppColors.blackColor,
                            fontWeight: index == _selectedIndex
                                ? FontWeight.w600
                                : FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                        selected: index == _selectedIndex,
                        trailing: items[index] != 0
                            ? Container(
                                width: 6.0,
                                height: 6.0,
                                decoration: const BoxDecoration(
                                  color: AppColors.primaryColor,
                                  shape: BoxShape.circle,
                                ),
                              )
                            : const SizedBox(),
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    color: AppColors.primaryColor.withOpacity(0.10),
                    child: Column(
                      children: [
                        Expanded(
                          child: _buildSelectedItemList(_selectedIndex),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 20),
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 8.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isFilterSelected()
                    ? AppColors.primaryColor
                    : AppColors.greyColor,
                minimumSize: const Size(120, 40),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              onPressed: () async {
                if (isFilterSelected()) {
                  _actionOnApplyButton(context);
                }
              },
              child: Text(
                "Apply",
                style: GoogleFonts.aBeeZee(
                  fontSize: 14,
                  color: isFilterSelected()
                      ? AppColors.whiteColor
                      : AppColors.lightGreyColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLocationList() {
    return locationList.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: locationList.length,
            itemBuilder: (BuildContext context, int i) {
              return CheckboxListTile(
                contentPadding: const EdgeInsets.all(0),
                activeColor: AppColors.primaryColor,

                controlAffinity: ListTileControlAffinity.leading, //
                title: Transform(
                  // you can forcefully translate values left side using Transform
                  transform: Matrix4.translationValues(-18.0, 0.0, 0.0),

                  child: Text(
                    locationList[i]['name'],
                    style: GoogleFonts.aBeeZee(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ),
                value: locationList[i]['value'],
                onChanged: (newValue) {
                  //set checkbox true/false value to the trainerList list
                  locationList[i]['value'] = newValue;

                  var value = {
                    "id": locationList[i]['id'],
                    "name": locationList[i]['name']
                  };
                  //if selected value is true
                  if (newValue == true) {
                    print("ADDING.....");
                    selectedLocationList.add(value);
                  } else {
                    print("REMOVING.....");
                    selectedLocationList
                        .removeWhere((item) => item["id"] == value['id']);
                  }

                  //set filter is selected
                  if (selectedLocationList.isNotEmpty) {
                    items[_selectedIndex] = 1;
                  } else {
                    items[_selectedIndex] = 0;
                  }
                  print("selectedLocationList :: $selectedLocationList");
                  isFilterSelected();
                },
              );
            })
        : TextWidgetUtility.buildNormalText(
            title: 'Not able to fetch Incident types. Please try again later.',
          );
  }

  Widget _buildTrainingNameList() {
    return trainingNameList.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: trainingNameList.length,
            itemBuilder: (BuildContext context, int i) {
              return CheckboxListTile(
                contentPadding: const EdgeInsets.all(0),
                activeColor: AppColors.primaryColor,

                controlAffinity: ListTileControlAffinity.leading, //
                title: Transform(
                  // you can forcefully translate values left side using Transform
                  transform: Matrix4.translationValues(-18.0, 0.0, 0.0),

                  child: Text(
                    trainingNameList[i]['name'],
                    style: GoogleFonts.aBeeZee(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ),
                value: trainingNameList[i]['value'],
                onChanged: (newValue) {
                  //set checkbox true/false value to the trainerList list
                  trainingNameList[i]['value'] = newValue;

                  var value = {
                    "id": trainingNameList[i]['id'],
                    "name": trainingNameList[i]['name']
                  };
                  //if selected value is true
                  if (newValue == true) {
                    print("ADDING.....");
                    selectedTrainingNameList.add(value);
                  } else {
                    print("REMOVING.....");
                    selectedTrainingNameList
                        .removeWhere((item) => item["id"] == value['id']);
                  }

                  //set filter is selected
                  if (selectedTrainingNameList.isNotEmpty) {
                    items[_selectedIndex] = 1;
                  } else {
                    items[_selectedIndex] = 0;
                  }
                  print(
                      "selectedTrainingNameList :: $selectedTrainingNameList");
                  isFilterSelected();
                },
              );
            })
        : TextWidgetUtility.buildNormalText(
            title: 'Not able to fetch Incident types. Please try again later.',
          );
  }

  Widget _buildTrainerList() {
    return trainerList.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: trainerList.length,
            itemBuilder: (BuildContext context, int i) {
              return CheckboxListTile(
                contentPadding: const EdgeInsets.all(0),
                activeColor: AppColors.primaryColor,

                controlAffinity: ListTileControlAffinity.leading, //
                title: Transform(
                  // you can forcefully translate values left side using Transform
                  transform: Matrix4.translationValues(-18.0, 0.0, 0.0),

                  child: Text(
                    trainerList[i]['name'],
                    style: GoogleFonts.aBeeZee(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ),
                value: trainerList[i]['value'],
                onChanged: (newValue) {
                  //set checkbox true/false value to the trainerList list
                  trainerList[i]['value'] = newValue;

                  var value = {
                    "id": trainerList[i]['id'],
                    "name": trainerList[i]['name']
                  };
                  //if selected value is true
                  if (newValue == true) {
                    print("ADDING.....");
                    selectedTrainerList.add(value);
                  } else {
                    print("REMOVING.....");
                    selectedTrainerList
                        .removeWhere((item) => item["id"] == value['id']);
                  }

                  //set filter is selected
                  if (selectedTrainerList.isNotEmpty) {
                    items[_selectedIndex] = 1;
                  } else {
                    items[_selectedIndex] = 0;
                  }
                  print("selectedTrainerListList :: $selectedTrainerList");
                  isFilterSelected();
                },
              );
            })
        : TextWidgetUtility.buildNormalText(
            title: 'Not able to fetch Incident types. Please try again later.',
          );
  }

  Widget _buildSelectedItemList(int listType) {
    Widget subList = const SizedBox();

    switch (listType) {
      case 0:
        {
          subList = _buildLocationList();
        }
        break;
      case 1:
        {
          subList = _buildTrainingNameList();
        }
        break;
      case 2:
        {
          subList = _buildTrainerList();
        }
        break;
      default:
        {
          subList = const SizedBox();
        }
        break;
    }
    return subList;
  }

  void _actionOnApplyButton(BuildContext context) {
    List _locations = [];
    List _trainingNames = [];
    List _trainers = [];

    if (selectedLocationList.isNotEmpty) {
      for (var i = 0; i < selectedLocationList.length; i++) {
        var value = {
          "id": selectedLocationList[i]["id"],
          "name": selectedLocationList[i]["name"]
        };
        _locations.add(value);
      }
    }

    if (selectedTrainingNameList.isNotEmpty) {
      for (var i = 0; i < selectedTrainingNameList.length; i++) {
        var value = {
          "id": selectedTrainingNameList[i]["id"],
          "name": selectedTrainingNameList[i]["name"]
        };
        _trainingNames.add(value);
      }
    }
    if (selectedTrainerList.isNotEmpty) {
      for (var i = 0; i < selectedTrainerList.length; i++) {
        var value = {
          "id": selectedTrainerList[i]["id"],
          "name": selectedTrainerList[i]["name"]
        };
        _trainers.add(value);
      }
    }

    var selectedFilter = {
      "locations": _locations,
      "trainingName": _trainingNames,
      "trainer": _trainers,
    };
    Navigator.pop(context, selectedFilter);
  }

  void _clearFilter() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => super.widget),
    );
  }

  bool isFilterSelected() {
    for (var i = 0; i < items.length; i++) {
      if (items[i] != 0) {
        setState(() {});
        return true;
      }
    }
    setState(() {});
    return false;
  }
}
