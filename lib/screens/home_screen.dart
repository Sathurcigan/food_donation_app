import 'package:dotted_border/dotted_border.dart';
import 'package:food_donation_app/screens/login_screen.dart';
import 'package:food_donation_app/widgets/Footer.dart';
import 'package:food_donation_app/widgets/headingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../APIs/feedback/feedback-api.dart';
import '../APIs/feedback/feedback.dart';
import '../APIs/home/homeBadge-api.dart';
import '../APIs/home/homeBadge.dart';
import '../APIs/home/homeChart-api.dart';
import '../APIs/home/homeChart.dart';
import '../APIs/home/homeDonation-api.dart';
import '../APIs/home/homeDonation.dart';
import '../APIs/home/homePredict-api.dart';
import '../APIs/home/homePrediction.dart';
import '../APIs/home/homeRequest-api.dart';
import '../APIs/home/homeRequest.dart';
import '../constants.dart';
import '../widgets/FormButton.dart';
import '../widgets/appBarWidget.dart';
import '../widgets/feedbackWidgets.dart';
import '../widgets/homeWidgets.dart';

import 'package:intl/intl.dart';
import 'feedback_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final _formKey = GlobalKey<FormBuilderState>();

class _HomeScreenState extends State<HomeScreen> {
  String currentDate = DateFormat('dd-MM-y').format(DateTime.now()).toString();
  late String stDate, enDate;
  String userType = 'user';
  bool suggetion = false;

  loginVerification() async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String? id = sharedPreferences.getString('uId');
      final String? usertype = sharedPreferences.getString('userType');

      setState(() {
        userType = usertype.toString();
      });

      debugPrint("user id: $id");

      if (id == null) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        });
      }
    } catch (e) {
      debugPrint("caught error: $e");
    }
  }

  List<RequestClass> request = [];
  List<FoodClass> foods = [];

  @override
  void initState() {
    super.initState();
    loginVerification();
    getRequestData().then((requestCount) => request = requestCount);
    getFoodData().then((foodCount) => foods = foodCount);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double homeHeightOut = 0;
    double homeHeightIn = 0;

    if (userType == 'Donor') {
      setState(() {
        homeHeightOut = screenHeight * 2.05;
        homeHeightIn = screenHeight * 1.99;
      });
    } else {
      setState(() {
        homeHeightOut = screenHeight * 1.62;
        homeHeightIn = screenHeight * 1.57;
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bg_color,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: appbarWidget(name: 'Home'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          height: homeHeightOut,
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: homeHeightIn,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          Container(
                            height: screenHeight * 0.35,
                            width: screenWidth,
                            alignment: AlignmentDirectional.center,
                            child: FutureBuilder(
                              future: fetchBadge(),
                              builder:
                                  (
                                    context,
                                    AsyncSnapshot<List<HomeBadge>> snapshot,
                                  ) {
                                    if (snapshot.hasData) {
                                      return ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: snapshot.data?.length,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                              HomeBadge hBadge =
                                                  snapshot.data![index];
                                              return Wrap(
                                                children: [
                                                  homeBadgeWidget(
                                                    screenWidth: screenWidth,
                                                    color: const Color.fromRGBO(
                                                      82,
                                                      178,
                                                      29,
                                                      1,
                                                    ),
                                                    title: 'Foods',
                                                    count: hBadge.food,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  homeBadgeWidget(
                                                    screenWidth: screenWidth,
                                                    color: const Color.fromRGBO(
                                                      0,
                                                      120,
                                                      254,
                                                      1,
                                                    ),
                                                    title: 'Donors',
                                                    count: hBadge.donor,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  homeBadgeWidget(
                                                    screenWidth: screenWidth,
                                                    color: const Color.fromRGBO(
                                                      230,
                                                      107,
                                                      78,
                                                      1,
                                                    ),
                                                    title: 'Recipients',
                                                    count: hBadge.recipient,
                                                  ),
                                                  homeBadgeWidget(
                                                    screenWidth: screenWidth,
                                                    color: const Color.fromRGBO(
                                                      50,
                                                      81,
                                                      95,
                                                      1,
                                                    ),
                                                    title: 'Requests',
                                                    count: hBadge.request,
                                                  ),
                                                ],
                                              );
                                            },
                                      );
                                    }
                                    return const CircularProgressIndicator();
                                  },
                            ),
                          ),
                          if (userType == 'Donor') ...[
                            SizedBox(
                              height: screenHeight * 0.41,
                              child: Column(
                                children: [
                                  const headingWidget(heading: "Analyze"),
                                  DottedBorder(
                                    options: RectDottedBorderOptions(
                                      dashPattern: [5, 5],
                                      strokeWidth: 2,
                                      padding: EdgeInsets.all(16),
                                      color: theme_color,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: screenHeight * 0.05,
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          child: Row(
                                            children: [
                                              Container(
                                                width: screenWidth * 0.22,
                                                alignment:
                                                    AlignmentDirectional.center,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        right: 2,
                                                      ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      if (suggetion == false) {
                                                        setState(() {
                                                          suggetion = true;
                                                        });
                                                      } else {
                                                        setState(() {
                                                          suggetion = false;
                                                        });
                                                      }
                                                    },
                                                    child: Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        SizedBox(
                                                          height: 25,
                                                          width: 100,
                                                          child: ElevatedButton(
                                                            onPressed: () {},
                                                            style: ElevatedButton.styleFrom(
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      20,
                                                                    ),
                                                              ),
                                                              backgroundColor:
                                                                  const Color.fromRGBO(
                                                                    82,
                                                                    178,
                                                                    29,
                                                                    1,
                                                                  ),
                                                            ),
                                                            child: null,
                                                          ),
                                                        ),
                                                        Text(
                                                          "Suggestion",
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                  0,
                                                                  120,
                                                                  254,
                                                                  1,
                                                                ),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                color: theme_color,
                                                width: screenWidth * 0.62,
                                                height: screenHeight * 0.04,
                                                child: Stack(
                                                  children: [
                                                    FormBuilder(
                                                      key: _formKey,
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            width:
                                                                screenWidth *
                                                                0.26,
                                                            child: FormBuilderDateTimePicker(
                                                              name: 'stDate',
                                                              format:
                                                                  DateFormat(
                                                                    'dd-MM-y',
                                                                  ),
                                                              inputType:
                                                                  InputType
                                                                      .date,
                                                              decoration: const InputDecoration(
                                                                hintStyle:
                                                                    TextStyle(
                                                                      color:
                                                                          bg_color,
                                                                      fontSize:
                                                                          10,
                                                                    ),
                                                                errorStyle: TextStyle(
                                                                  color: Colors
                                                                      .redAccent,
                                                                  fontSize: 10,
                                                                ),
                                                                contentPadding:
                                                                    EdgeInsets.only(
                                                                      left: 5,
                                                                      top: 3,
                                                                    ),
                                                                suffixIcon: Icon(
                                                                  Icons
                                                                      .date_range_sharp,
                                                                  color:
                                                                      bg_color,
                                                                  size: 15,
                                                                ),
                                                                hintText:
                                                                    "Start Date",
                                                              ),
                                                              style:
                                                                  const TextStyle(
                                                                    color:
                                                                        bg_color,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                            ),
                                                          ),
                                                          const Text(
                                                            "To",
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: bg_color,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                screenWidth *
                                                                0.26,
                                                            child: FormBuilderDateTimePicker(
                                                              name: 'enDate',
                                                              format:
                                                                  DateFormat(
                                                                    'dd-MM-y',
                                                                  ),
                                                              inputType:
                                                                  InputType
                                                                      .date,
                                                              decoration: const InputDecoration(
                                                                hintStyle:
                                                                    TextStyle(
                                                                      color:
                                                                          bg_color,
                                                                      fontSize:
                                                                          10,
                                                                    ),
                                                                errorStyle: TextStyle(
                                                                  color: Colors
                                                                      .redAccent,
                                                                  fontSize: 10,
                                                                ),
                                                                contentPadding:
                                                                    EdgeInsets.only(
                                                                      left: 15,
                                                                      top: 3,
                                                                    ),
                                                                suffixIcon: Icon(
                                                                  Icons
                                                                      .date_range_sharp,
                                                                  color:
                                                                      bg_color,
                                                                  size: 15,
                                                                ),
                                                                hintText:
                                                                    "End Date",
                                                              ),
                                                              style:
                                                                  const TextStyle(
                                                                    color:
                                                                        bg_color,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        left:
                                                            screenWidth * 0.55,
                                                      ),
                                                      child: IconButton(
                                                        splashRadius: 0.2,
                                                        onPressed: () {
                                                          setState(() {
                                                            getRequestSpecificData(
                                                              DateFormat(
                                                                    'y-MM-dd',
                                                                  )
                                                                  .format(
                                                                    _formKey
                                                                        .currentState!
                                                                        .fields['stDate']!
                                                                        .value,
                                                                  )
                                                                  .toString(),
                                                              DateFormat(
                                                                    'y-MM-dd',
                                                                  )
                                                                  .format(
                                                                    _formKey
                                                                        .currentState!
                                                                        .fields['enDate']!
                                                                        .value,
                                                                  )
                                                                  .toString(),
                                                            ).then(
                                                              (
                                                                requestCount,
                                                              ) => request =
                                                                  requestCount,
                                                            );
                                                            getFoodSpecificData(
                                                              DateFormat(
                                                                    'y-MM-dd',
                                                                  )
                                                                  .format(
                                                                    _formKey
                                                                        .currentState!
                                                                        .fields['stDate']!
                                                                        .value,
                                                                  )
                                                                  .toString(),
                                                              DateFormat(
                                                                    'y-MM-dd',
                                                                  )
                                                                  .format(
                                                                    _formKey
                                                                        .currentState!
                                                                        .fields['enDate']!
                                                                        .value,
                                                                  )
                                                                  .toString(),
                                                            ).then(
                                                              (foodCount) =>
                                                                  foods =
                                                                      foodCount,
                                                            );
                                                          });
                                                        },
                                                        icon: const Icon(
                                                          Icons.filter_list_alt,
                                                          color: bg_color,
                                                          size: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: screenHeight * 0.27,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                flex: 5,
                                                child: SizedBox(
                                                  height: screenHeight * 0.225,
                                                  child: Row(
                                                    children: [
                                                      // graph
                                                      Expanded(
                                                        child: Container(
                                                          color:
                                                              const Color.fromRGBO(
                                                                241,
                                                                173,
                                                                40,
                                                                1,
                                                              ),
                                                          width:
                                                              screenWidth *
                                                              0.445,
                                                          child: SfCartesianChart(
                                                            primaryXAxis:
                                                                CategoryAxis(),
                                                            primaryYAxis:
                                                                NumericAxis(
                                                                  minimum: 0,
                                                                  maximum: 40,
                                                                  interval: 10,
                                                                ),
                                                            tooltipBehavior:
                                                                TooltipBehavior(
                                                                  enable: true,
                                                                ),
                                                            series:
                                                                <
                                                                  CartesianSeries<
                                                                    RequestClass,
                                                                    String
                                                                  >
                                                                >[
                                                                  ColumnSeries<
                                                                    RequestClass,
                                                                    String
                                                                  >(
                                                                    dataSource:
                                                                        request,
                                                                    xValueMapper:
                                                                        (
                                                                          RequestClass
                                                                          r,
                                                                          _,
                                                                        ) => r
                                                                            .date[0],
                                                                    yValueMapper:
                                                                        (
                                                                          RequestClass
                                                                          r,
                                                                          _,
                                                                        ) => r
                                                                            .count[0],
                                                                    name:
                                                                        'Request',
                                                                    // Enable data label
                                                                    dataLabelSettings:
                                                                        DataLabelSettings(
                                                                          isVisible:
                                                                              true,
                                                                        ),
                                                                    color:
                                                                        Color.fromRGBO(
                                                                          159,
                                                                          222,
                                                                          125,
                                                                          1,
                                                                        ),
                                                                  ),
                                                                ],
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 7),
                                                      // graph
                                                      Expanded(
                                                        child: Container(
                                                          color:
                                                              const Color.fromRGBO(
                                                                241,
                                                                173,
                                                                40,
                                                                1,
                                                              ),
                                                          width:
                                                              screenWidth *
                                                              0.445,
                                                          child: SfCartesianChart(
                                                            primaryXAxis:
                                                                CategoryAxis(),
                                                            primaryYAxis:
                                                                NumericAxis(
                                                                  minimum: 0,
                                                                  maximum: 40,
                                                                  interval: 10,
                                                                ),
                                                            tooltipBehavior:
                                                                TooltipBehavior(
                                                                  enable: true,
                                                                ),
                                                            series:
                                                                <
                                                                  CartesianSeries<
                                                                    FoodClass,
                                                                    String
                                                                  >
                                                                >[
                                                                  ColumnSeries<
                                                                    FoodClass,
                                                                    String
                                                                  >(
                                                                    dataSource:
                                                                        foods,
                                                                    xValueMapper:
                                                                        (
                                                                          FoodClass
                                                                          f,
                                                                          _,
                                                                        ) => f
                                                                            .date[0],
                                                                    yValueMapper:
                                                                        (
                                                                          FoodClass
                                                                          f,
                                                                          _,
                                                                        ) => f
                                                                            .count[0],
                                                                    name:
                                                                        'Foods',
                                                                    // Enable data label
                                                                    dataLabelSettings:
                                                                        DataLabelSettings(
                                                                          isVisible:
                                                                              true,
                                                                        ),
                                                                    color:
                                                                        Color.fromRGBO(
                                                                          159,
                                                                          222,
                                                                          125,
                                                                          1,
                                                                        ),
                                                                  ),
                                                                ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        height:
                                                            screenHeight * 0.03,
                                                        width:
                                                            screenWidth * 0.445,
                                                        alignment:
                                                            AlignmentDirectional
                                                                .center,
                                                        child: const Text(
                                                          "Request",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                            color:
                                                                Color.fromRGBO(
                                                                  241,
                                                                  173,
                                                                  40,
                                                                  1,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        height:
                                                            screenHeight * 0.03,
                                                        width:
                                                            screenWidth * 0.445,
                                                        alignment:
                                                            AlignmentDirectional
                                                                .center,
                                                        child: const Text(
                                                          "Food Availability",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                            color:
                                                                Color.fromRGBO(
                                                                  241,
                                                                  173,
                                                                  40,
                                                                  1,
                                                                ),
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
                                ],
                              ),
                            ),
                          ],
                          SizedBox(
                            height: screenHeight * 0.6,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: screenHeight * 0.58,
                                  width: screenWidth * 0.4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const headingWidget(heading: "Requests"),
                                      Container(
                                        height: screenHeight * 0.52,
                                        width: screenWidth * 0.38,
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                            0,
                                            120,
                                            254,
                                            1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            15.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 5,
                                          ),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                FutureBuilder(
                                                  future: fetchAllRequests(),
                                                  builder:
                                                      (
                                                        context,
                                                        AsyncSnapshot<
                                                          List<HomeRequest>
                                                        >
                                                        snapshot,
                                                      ) {
                                                        if (snapshot.hasData) {
                                                          return ListView.builder(
                                                            physics:
                                                                const NeverScrollableScrollPhysics(),
                                                            shrinkWrap: true,
                                                            itemCount: snapshot
                                                                .data
                                                                ?.length,
                                                            itemBuilder:
                                                                (
                                                                  BuildContext
                                                                  context,
                                                                  index,
                                                                ) {
                                                                  HomeRequest
                                                                  requestList =
                                                                      snapshot
                                                                          .data![index];
                                                                  return homeRequestWidget(
                                                                    screenWidth:
                                                                        screenWidth,
                                                                    req:
                                                                        requestList,
                                                                  );
                                                                },
                                                          );
                                                        }
                                                        return const CircularProgressIndicator();
                                                      },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.58,
                                  width: screenWidth * 0.52,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const headingWidget(heading: "Donations"),
                                      Container(
                                        height: screenHeight * 0.52,
                                        width: screenWidth * 0.51,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color.fromRGBO(
                                              251,
                                              126,
                                              91,
                                              1,
                                            ),
                                            width: 2,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(25),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 10,
                                          ),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                FutureBuilder(
                                                  future: fetchAllDonations(),
                                                  builder:
                                                      (
                                                        context,
                                                        AsyncSnapshot<
                                                          List<HomeDonation>
                                                        >
                                                        snapshot,
                                                      ) {
                                                        if (snapshot.hasData) {
                                                          return ListView.builder(
                                                            physics:
                                                                const NeverScrollableScrollPhysics(),
                                                            shrinkWrap: true,
                                                            itemCount: snapshot
                                                                .data
                                                                ?.length,
                                                            itemBuilder:
                                                                (
                                                                  BuildContext
                                                                  context,
                                                                  index,
                                                                ) {
                                                                  HomeDonation
                                                                  donation =
                                                                      snapshot
                                                                          .data![index];
                                                                  return homeDonationWidget(
                                                                    screenHeight:
                                                                        screenHeight,
                                                                    screenWidth:
                                                                        screenWidth,
                                                                    don:
                                                                        donation,
                                                                  );
                                                                },
                                                          );
                                                        }
                                                        return const CircularProgressIndicator();
                                                      },
                                                ),
                                              ],
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
                          SizedBox(
                            height: screenHeight * 0.62,
                            child: Column(
                              children: [
                                const headingWidget(heading: "Feedbacks"),
                                SizedBox(
                                  height: screenHeight * 0.5,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        FutureBuilder(
                                          future: fetchFeedback(),
                                          builder:
                                              (
                                                context,
                                                AsyncSnapshot<
                                                  List<FeedbackList>
                                                >
                                                snapshot,
                                              ) {
                                                if (snapshot.hasData) {
                                                  return ListView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        snapshot.data?.length,
                                                    itemBuilder:
                                                        (
                                                          BuildContext context,
                                                          index,
                                                        ) {
                                                          FeedbackList
                                                          feedBack = snapshot
                                                              .data![index];
                                                          return feedbackWidget(
                                                            fBack: feedBack,
                                                          );
                                                        },
                                                  );
                                                }
                                                return const CircularProgressIndicator();
                                              },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 60,
                                        width: screenWidth,
                                        alignment:
                                            AlignmentDirectional.centerEnd,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: screenWidth * 0.5,
                                              height: 40,
                                              child: FormButton(
                                                execute: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const FeedbackScreen(),
                                                    ),
                                                  );
                                                },
                                                buttonColor:
                                                    const Color.fromRGBO(
                                                      247,
                                                      122,
                                                      86,
                                                      1,
                                                    ),
                                                buttonTextColor: bg_color,
                                                buttonText: 'View more',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(right: 15),
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional.centerEnd,
                                          child: Icon(
                                            Icons.chevron_right,
                                            color: bg_color,
                                            size: 30,
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
                  ),
                  SizedBox(
                    height: homeHeightIn,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: screenHeight * 1.54,
                        right: 14,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: Visibility(
                          visible: suggetion,
                          child: Container(
                            width: screenWidth * 0.7,
                            constraints: BoxConstraints(
                              minHeight: 20,
                              maxHeight: screenHeight * 0.3,
                            ),
                            decoration: BoxDecoration(
                              color: bg_color,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: theme_color,
                                width: 2.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 50,
                                    width: double.maxFinite,
                                    alignment: AlignmentDirectional.center,
                                    child: const Text(
                                      "Tips for Handle the Foods and Requests.",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: text_color_light,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: screenHeight * 0.2,
                                      child: FutureBuilder(
                                        future: showPrediction(),
                                        builder:
                                            (
                                              context,
                                              AsyncSnapshot<List<Prediction>>
                                              snapshot,
                                            ) {
                                              if (snapshot.hasData) {
                                                return ListView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      snapshot.data?.length,
                                                  itemBuilder:
                                                      (
                                                        BuildContext context,
                                                        index,
                                                      ) {
                                                        Prediction predict =
                                                            snapshot
                                                                .data![index];
                                                        return homePredictionWidget(
                                                          predict: predict,
                                                        );
                                                      },
                                                );
                                              }
                                              return const CircularProgressIndicator();
                                            },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const footer(),
            ],
          ),
        ),
      ),
    );
  }
}
