import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/common/reusableComponents/textWidget.dart';
import 'package:chefsandmeals_customer/src/common/sharedPreference.dart';
import 'package:chefsandmeals_customer/src/common/strings.dart';
import 'package:chefsandmeals_customer/src/models/requests/update_hub_recommendation_score_request.dart';
import 'package:chefsandmeals_customer/src/models/responses/filteredHubList.dart';
import 'package:chefsandmeals_customer/src/modules/appIntroduction/onBoardingSliders/controller/onBoardingPageController.dart';
import 'package:chefsandmeals_customer/src/repositories/hub_repository.dart';

import 'landingScreen.dart';

class HubSelectionScreen extends StatefulWidget {
  final String? filterType;

  HubSelectionScreen({Key? key, this.filterType}) : super(key: key);

  @override
  HubSelectionScreenState createState() => new HubSelectionScreenState();
}

class HubSelectionScreenState extends State<HubSelectionScreen> {
  final HubRepository _hubRepository = HubRepository();
  SharedPref sharedPref = SharedPref();
  FilteredHubList filteredHubList = FilteredHubList();
  final TextEditingController _filter = TextEditingController();
  String _searchText = "";
  Icon _searchIcon = Icon(Icons.search);
  Widget _appBarTitle = customTextWidget(
      "Select City", 18, FontWeight.w600, AppCustomColors.whiteColor);
  FilteredHubList fullList = FilteredHubList();
  FilteredHubList filteredList = FilteredHubList();

  HubSelectionScreenState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredList = filteredHubList;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  final controller = Get.put(OnBoardingController());

  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Scaffold(
        appBar: _buildBar(context),
        body: Container(
          child: _buildList(context),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildBar(BuildContext context) {
    return new AppBar(
      backgroundColor: AppCustomColors.primaryColor,
      automaticallyImplyLeading: false,
      //titleSpacing: 0.0,
      actions: <Widget>[
        IconButton(
          icon: _searchIcon,
          onPressed: _searchPressed,
        ),
      ],
      centerTitle: true,
      title: GestureDetector(
        onTap: _searchPressed,
        child: _appBarTitle,
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: 12,
        ),
        Expanded(
          child: FutureBuilder<FilteredHubList>(
              future: _hubRepository.getFilteredHubList(
                  _searchText, widget.filterType!),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  filteredHubList = snapshot.data;
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.builder(
                        itemCount: filteredHubList.result!.length,
                        itemBuilder: (context, index) {
                          return Material(
                            child: InkWell(
                              onTap: () async {
                                await sharedPref.setUserAppData(
                                    SharedPrefStrings.hubName,
                                    filteredHubList
                                        .result![index].displayName!);
                                await sharedPref.setUserAppData(
                                    SharedPrefStrings.hubId,
                                    filteredHubList.result![index].id
                                        .toString());
                                await controller.setRout(2);

                                await controller.updateHubRecommendationScore(
                                    filteredHubList.result![index].id!);

                                Get.to(() => LandingScreen());
                              },
                              child: Container(
                                padding: EdgeInsets.only(bottom: 16),
                                child: Card(
                                  margin: EdgeInsets.symmetric(horizontal: 8),
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 12),
                                    child: customTextWidget(
                                        "" +
                                            filteredHubList
                                                .result![index].displayName!,
                                        16,
                                        FontWeight.w600,
                                        AppCustomColors.blackColor),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                } else {
                  return Center(child: new CircularProgressIndicator());
                }
              }),
        ),
        SizedBox(
          height: 22,
        ),
      ],
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          style: new TextStyle(color: Colors.white),
          controller: _filter,
          decoration: new InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white),
          ),
          cursorColor: Colors.white,
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = customTextWidget(
            "Select Hub", 18, FontWeight.w600, AppCustomColors.whiteColor);
        //filteredEmployees = names;
        _filter.clear();
      }
    });
  }
}
