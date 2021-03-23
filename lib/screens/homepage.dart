//Flutter Imports
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hospital/constants/resources.dart';
import 'package:hospital/globals/responsive.dart';
import 'package:hospital/globals/user_details.dart';
import 'package:hospital/screens/add_doctor.dart';
import 'package:hospital/screens/add_edit_banners.dart';
import 'package:hospital/screens/doctor_page.dart';
import 'package:hospital/screens/profile_page.dart';
import 'package:hospital/theme/app_theme.dart';
import 'package:hospital/utils/utils.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();
  int index = 0;
  List<Widget> _banners = [];
  List<Widget> _doctors = [];
  TextEditingController _nameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkUserStatus();
    getBanners();
    getDoctors();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _numberController.dispose();
  }

  checkUserStatus() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Hospital')
          .doc(currentUser.phoneNumber)
          .get();
      if (snapshot.exists) {
        if (snapshot.data()['name'] == '') {
          Utils.showError('Please Update Profile Data');
          Future.delayed(Duration(seconds: 3)).whenComplete(() async {
            try {
              dynamic response = await Get.to(ProfilePage());
              if (response) {}
            } catch (error) {
              print(error);
              setState(() {});
            }
          });
        }
        if (snapshot.data()['location'] != null) {
          userLocation = snapshot.data()['location'];
          print(userLocation);
        }
      }
    } catch (error) {
      print(error);
    }
  }

  getBanners() async {
    try {
      _banners = [];
      Future.delayed(Duration(milliseconds: 100)).whenComplete(() async {
        Utils.showProgressBar();
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Hospital')
            .doc(currentUser.phoneNumber)
            .collection('Banner Section')
            .get();
        if (querySnapshot != null) {
          if (querySnapshot.docs != null) {
            if (querySnapshot.docs.isNotEmpty) {
              for (int index = 0; index < querySnapshot.docs.length; index++) {
                _banners.add(Stack(
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      child: Container(
                        width: size(50),
                        height: size(50),
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                        child: CircularProgressIndicator(
                            backgroundColor: AppTheme.primaryAccent),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: size(15)),
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(querySnapshot.docs[index]
                                  .data()['bannerURL']),
                            ),
                            borderRadius: BorderRadius.circular(10))),
                  ],
                ));
              }
            }
          }
        }
        Get.back();
        Future.delayed(Duration(milliseconds: 100))
            .whenComplete(() => setState(() {}));
      });
    } catch (error) {
      Get.back();
      print(error);
    }
  }

  getDoctors() async {
    try {
      _doctors = [];
      Future.delayed(Duration(milliseconds: 100)).whenComplete(() async {
        Utils.showProgressBar();
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Hospital')
            .doc(currentUser.phoneNumber)
            .collection('Doctors')
            .get();
        if (querySnapshot != null) {
          if (querySnapshot.docs != null) {
            for (int index = 0; index < querySnapshot.docs.length; index++) {
              _doctors.add(GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DoctorPage(
                              hosptialID: querySnapshot.docs[index]
                                  .data()['hospitalID'],
                              doctorID: querySnapshot.docs[index].id,
                            ))),
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.28,
                  width: MediaQuery.of(context).size.width * 0.28,
                  child: Column(
                    children: [
                      Container(
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey.withOpacity(0.41),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(querySnapshot.docs[index]
                                    .data()['profile'])),
                            borderRadius: BorderRadius.circular(1000)),
                      ),
                      Text(querySnapshot.docs[index].data()['name'],
                          style: TextStyle(fontFamily: AppTheme.poppins))
                    ],
                  ),
                ),
              ));
            }
          }
        }
        _doctors.add(GestureDetector(
          onTap: () => Get.to(AddDoctor()),
          child: Container(
            height: MediaQuery.of(context).size.width * 0.28,
            width: MediaQuery.of(context).size.width * 0.28,
            child: Column(
              children: [
                Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey.withOpacity(0.41),
                        borderRadius: BorderRadius.circular(1000)),
                    child: Icon(Icons.add)),
                Text('Add Doctor',
                    style: TextStyle(fontFamily: AppTheme.poppins))
              ],
            ),
          ),
        ));
        Get.back();
        if (_doctors.length == 0) {
          Utils.showError('Something went wrong, please restart the App');
        }
      });
    } catch (error) {
      Get.back();
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppTheme.offWhite,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () async {
              try {
                dynamic response = await Get.to(ProfilePage());
                if (response) {}
              } catch (error) {
                print(error);
                setState(() {});
              }
            },
            child: Padding(
                padding: EdgeInsets.all(10),
                child: CircleAvatar(
                    child: Icon(Icons.person, color: AppTheme.whiteColor),
                    backgroundColor: AppTheme.primaryColor,
                    radius: 20)),
          ),
          title: Container(
            height: AppBar().preferredSize.height,
            child: Image.asset(logoJPEG),
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() {
                    _pageController.jumpToPage(0);
                  }),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        color: AppTheme.primaryColor,
                        size: 30,
                      ),
                      if (index == 0)
                        Text('Home',
                            style: TextStyle(
                                color: AppTheme.primaryColor,
                                fontFamily: AppTheme.poppinsBold)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() {
                    _pageController.jumpToPage(1);
                  }),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.group_add,
                        color: AppTheme.primaryColor,
                        size: 30,
                      ),
                      if (index == 1)
                        Text('Future Customers',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppTheme.primaryColor,
                                fontFamily: AppTheme.poppinsBold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: currentUser.displayName != '' && currentUser.displayName != null
            ? SingleChildScrollView(
                child: Container(
                    height: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        AppBar().preferredSize.height,
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) => setState(() {
                        this.index = index;
                      }),
                      children: [
                        SingleChildScrollView(
                            child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          child: Column(
                            children: [
                              Container(
                                  child: Text(
                                      'Welcome \n${currentUser.displayName}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: AppTheme.poppinsBold,
                                          color: AppTheme.primaryColor,
                                          fontSize: 18))),
                              SizedBox(height: size(15)),
                              CarouselSlider(
                                  items: [
                                    GestureDetector(
                                      onTap: () async {
                                        try {
                                          dynamic response =
                                              await Get.to(AddEditBanner());
                                          if (response) {}
                                        } catch (error) {
                                          setState(() {});
                                        }
                                      },
                                      child: Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(size(25)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text('Edit Banner',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily:
                                                          AppTheme.poppins)),
                                              SizedBox(height: size(5)),
                                              Icon(Icons.add,
                                                  color: Colors.white),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                    ),
                                    if (_banners.length > 0) ..._banners
                                  ],
                                  options: CarouselOptions(
                                    height: 200,
                                    aspectRatio: 16 / 9,
                                    viewportFraction: 0.8,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    reverse: false,
                                    autoPlay: true,
                                    autoPlayInterval: Duration(seconds: 3),
                                    autoPlayAnimationDuration:
                                        Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: true,
                                    scrollDirection: Axis.horizontal,
                                  )),
                              SizedBox(height: size(10)),
                              Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 5),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text('Our Doctors',
                                              style: TextStyle(
                                                  fontFamily: AppTheme.poppins,
                                                  fontSize: 12)),
                                          SizedBox(height: 5),
                                          Wrap(
                                            children: _doctors,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        )),
                        Column(
                          children: [
                            Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 5),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        SizedBox(height: 5),
                                        TextField(
                                          controller: _nameController,
                                          decoration: InputDecoration(
                                            hintText: 'Full Name',
                                            hintStyle: TextStyle(
                                                fontFamily: AppTheme.poppins,
                                                color: AppTheme.primaryColor),
                                            enabledBorder:
                                                new OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: AppTheme.primaryColor,
                                                  width: 1.0),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(8.0),
                                              ),
                                            ),
                                            focusedBorder:
                                                new OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: AppTheme.primaryColor,
                                                  width: 1.0),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(8.0),
                                              ),
                                            ),
                                            disabledBorder:
                                                new OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: AppTheme.primaryColor,
                                                  width: 1.0),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(8.0),
                                              ),
                                            ),
                                            border: new OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: AppTheme.primaryColor,
                                                  width: 1.0),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(8.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        TextField(
                                          controller: _numberController,
                                          maxLength: 10,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            counterText: '',
                                            hintText: 'Mobile Number',
                                            hintStyle: TextStyle(
                                                fontFamily: AppTheme.poppins,
                                                color: AppTheme.primaryColor),
                                            enabledBorder:
                                                new OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: AppTheme.primaryColor,
                                                  width: 1.0),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(8.0),
                                              ),
                                            ),
                                            focusedBorder:
                                                new OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: AppTheme.primaryColor,
                                                  width: 1.0),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(8.0),
                                              ),
                                            ),
                                            disabledBorder:
                                                new OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: AppTheme.primaryColor,
                                                  width: 1.0),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(8.0),
                                              ),
                                            ),
                                            border: new OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: AppTheme.primaryColor,
                                                  width: 1.0),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(8.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        RaisedButton(
                                            color: Colors.orange,
                                            onPressed: () async {
                                              try {
                                                if (_nameController.text
                                                        .trim() ==
                                                    '') {
                                                  Utils.showError(
                                                      'Please enter valid name');
                                                } else if (_numberController
                                                        .text.length !=
                                                    10) {
                                                  Utils.showError(
                                                      'Please enter valid number');
                                                } else {
                                                  Utils.showProgressBar();
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('Admin')
                                                      .doc('Future Customers')
                                                      .collection('List')
                                                      .doc(DateTime.now()
                                                          .toString())
                                                      .set({
                                                    'name':
                                                        _nameController.text,
                                                    'number':
                                                        _numberController.text,
                                                    'hospital':
                                                        currentUser.displayName
                                                  });
                                                  Get.back();
                                                  Utils.showsuccess(
                                                      'Data Has Been Sent to Admin !');
                                                  _nameController.clear();
                                                  _numberController.clear();
                                                }
                                              } catch (error) {
                                                print(error);
                                              }
                                            },
                                            child: Text('Send Customer Data',
                                                style: TextStyle(
                                                    fontFamily:
                                                        AppTheme.poppins,
                                                    color:
                                                        AppTheme.whiteColor)))
                                      ],
                                    ),
                                  ),
                                )),
                          ],
                        )
                      ],
                    )))
            : SizedBox.shrink());
  }
}
