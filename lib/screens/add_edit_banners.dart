//Flutter Imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:hospital/globals/responsive.dart';
import 'package:hospital/globals/user_details.dart';
import 'package:hospital/services/auth.dart';
import 'package:hospital/theme/app_theme.dart';
import 'package:hospital/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class AddEditBanner extends StatefulWidget {
  @override
  _AddEditBannerState createState() => _AddEditBannerState();
}

class _AddEditBannerState extends State<AddEditBanner> {
  File _bannerFile;
  List<Widget> _banners = [];

  pickImage() async {
    try {
      ImagePicker imagePicker = ImagePicker();
      PickedFile file = await imagePicker.getImage(
          source: ImageSource.gallery, imageQuality: 70);
      if (file != null) {
        _bannerFile = File(file.path);
      }
      setState(() {});
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    getBanners();
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
                    Container(
                      margin: EdgeInsets.symmetric(vertical: size(15)),
                      padding: EdgeInsets.only(top: size(5), right: size(5)),
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () async {
                          try {
                            Utils.showProgressBar();
                            await FirebaseFirestore.instance
                                .collection('Hospital')
                                .doc(currentUser.phoneNumber)
                                .collection('Banner Section')
                                .doc(querySnapshot.docs[index].id)
                                .delete();
                            Get.back();
                            Utils.showsuccess('Banner Deleted !');
                            getBanners();
                          } catch (error) {
                            print(error);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3)),
                          child: Icon(Icons.delete, color: Colors.red),
                        ),
                      ),
                    )
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
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Banner Section'),
        actions: [
          if (_bannerFile != null)
            GestureDetector(
              onTap: () async {
                try {
                  Utils.showProgressBar();
                  await FirebaseFirestore.instance
                      .collection('Hospital')
                      .doc(currentUser.phoneNumber)
                      .collection('Banner Section')
                      .doc(DateTime.now().toString())
                      .set({'bannerURL': await Auth.uploadPhoto(_bannerFile)});
                  _bannerFile = null;
                  Get.back();
                  getBanners();
                } catch (error) {
                  Get.back();
                  print(error);
                }
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(right: size(10)),
                child: Text(
                  'Save',
                  style: TextStyle(color: AppTheme.whiteColor),
                ),
              ),
            )
        ],
      ),
      body: Container(
          child: SingleChildScrollView(
              child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size(15)),
        child: Column(
          children: [
            SizedBox(height: size(15)),
            GestureDetector(
              onTap: () async => pickImage(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Add Banner',
                      style: TextStyle(fontFamily: AppTheme.poppinsBold)),
                  SizedBox(width: size(10)),
                  Icon(Icons.add)
                ],
              ),
            ),
            SizedBox(height: size(15)),
            if (_bannerFile != null)
              Stack(
                children: [
                  Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(_bannerFile),
                          ),
                          borderRadius: BorderRadius.circular(10))),
                  Container(
                    padding: EdgeInsets.only(top: size(5), right: size(5)),
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => setState(() {
                        _bannerFile = null;
                      }),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.3)),
                        child: Icon(Icons.delete, color: Colors.red),
                      ),
                    ),
                  )
                ],
              ),
            SizedBox(height: size(15)),
            if (_banners.length > 0)
              Text('Live Banners',
                  style: TextStyle(
                      fontSize: 18, fontFamily: AppTheme.poppinsBold)),
            if (_banners.length > 0) ..._banners
          ],
        ),
      ))),
    );
  }
}
