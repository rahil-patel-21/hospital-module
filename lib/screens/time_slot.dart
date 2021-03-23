//Flutter Imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hospital/globals/responsive.dart';
import 'package:hospital/globals/user_details.dart';
import 'package:hospital/screens/appointment_hisotry.dart';
import 'package:hospital/theme/app_theme.dart';
import 'package:hospital/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class SlotPage extends StatefulWidget {
  final String doctorID, hosptialID;
  SlotPage({this.doctorID, this.hosptialID});
  @override
  _SlotPageState createState() => _SlotPageState();
}

class _SlotPageState extends State<SlotPage> {
  List<SlotButton> _tokens = [];
  DocumentSnapshot snapshot;
  String _openingTime = '';
  String _closingTime = '';

  @override
  void initState() {
    super.initState();
    getDoctorInfo();
  }

  getDoctorInfo() async {
    try {
      Future.delayed(Duration(milliseconds: 100)).whenComplete(() async {
        Utils.showProgressBar();
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection('Hospital')
            .doc(widget.hosptialID)
            .collection('Doctors')
            .doc(widget.doctorID)
            .get();
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Hospital')
            .doc(widget.hosptialID)
            .collection('Doctors')
            .doc(widget.doctorID)
            .collection('Appointments')
            .get();
        List<String> ids = [];
        if (querySnapshot != null) {
          if (querySnapshot.docs != null) {
            for (int index = 0; index < querySnapshot.docs.length; index++) {
              DateTime date = DateTime.parse(querySnapshot.docs[index].id);
              if (date.day == DateTime.now().day &&
                  date.month == DateTime.now().month &&
                  date.year == DateTime.now().year) {
                ids.add(querySnapshot.docs[index].id);
              }
            }
          }
        }
        Get.back();
        int totalTokens = int.parse(documentSnapshot.data()['tokens']);
        // _tokens = [];
        for (int index = 0; index < totalTokens; index++) {
          _tokens.add(SlotButton(
              querySnapshot: querySnapshot,
              idList: ids,
              doctorID: widget.doctorID,
              hospitalID: widget.hosptialID,
              time: (index + 1).toString()));
        }
        setState(() {
          snapshot = documentSnapshot;
          _openingTime = DateFormat('hh:mm a')
              .format(DateTime.parse(snapshot.data()['OpeningTime']));
          _closingTime = DateFormat('hh:mm a')
              .format(DateTime.parse(snapshot.data()['ClosingTime']));
        });
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
            title: Text('Token Management',
                style: TextStyle(
                    fontFamily: AppTheme.poppins,
                    fontWeight: FontWeight.bold))),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey.withOpacity(0.41),
                                image: snapshot != null
                                    ? DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            snapshot.data()['profile']))
                                    : null,
                                borderRadius: BorderRadius.circular(1000)),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot != null
                                      ? snapshot.data()['name']
                                      : '',
                                  style: TextStyle(
                                      color: AppTheme.primaryColor,
                                      fontSize: 16,
                                      fontFamily: AppTheme.poppinsBold),
                                ),
                                Text(
                                  '${snapshot != null ? ((snapshot.data()['special1'] ?? '') + ' ' + (snapshot.data()['special2'] ?? '') + ' ' + (snapshot.data()['special3'] ?? '') + ' ' + (snapshot.data()['special4'] ?? '') + ' ' + (snapshot.data()['special5'] ?? '')) : ""}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: AppTheme.poppins),
                                ),
                                Text(
                                  '${snapshot != null ? ((snapshot.data()['education1'] ?? '') + ' ' + (snapshot.data()['education2'] ?? '') + ' ' + (snapshot.data()['education3'] ?? '') + ' ' + (snapshot.data()['education4'] ?? '') + ' ' + (snapshot.data()['education5'] ?? '')) : ""}',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontFamily: AppTheme.poppins),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                '${snapshot != null ? snapshot.data()['years'] : ''} Years',
                                style: TextStyle(
                                    color: AppTheme.primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: AppTheme.poppins),
                              ),
                              Text(
                                'Experience',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontFamily: AppTheme.poppins),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Open',
                                style: TextStyle(
                                    color: AppTheme.primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: AppTheme.poppins),
                              ),
                              Text(
                                _openingTime,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontFamily: AppTheme.poppins),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Close',
                                style: TextStyle(
                                    color: AppTheme.primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: AppTheme.poppins),
                              ),
                              Text(
                                _closingTime,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontFamily: AppTheme.poppins),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () => Get.to(SlotHistpryPage(
                  doctorID: widget.doctorID,
                  hospitalID: widget.hosptialID,
                )),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(8)),
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Text('Show Appointments History',
                      style: TextStyle(
                          color: AppTheme.whiteColor,
                          fontSize: 14,
                          fontFamily: AppTheme.poppins,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: Text(DateFormat('dd MMM yyyy').format(DateTime.now()),
                    style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontFamily: AppTheme.poppinsBold)),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.red),
                  ),
                  SizedBox(width: 5),
                  Text('Completed',
                      style: TextStyle(
                          fontFamily: AppTheme.poppins,
                          color: AppTheme.primaryColor)),
                  SizedBox(width: 10),
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.orange),
                  ),
                  SizedBox(width: 5),
                  Text('Pending',
                      style: TextStyle(
                          fontFamily: AppTheme.poppins,
                          color: AppTheme.primaryColor)),
                  SizedBox(width: 10),
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.green),
                  ),
                  SizedBox(width: 5),
                  Text('Available',
                      style: TextStyle(
                          fontFamily: AppTheme.poppins,
                          color: AppTheme.primaryColor)),
                  SizedBox(width: 10)
                ],
              ),
              SizedBox(height: 15),
              Container(
                child: Text('Tokens',
                    style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontFamily: AppTheme.poppins)),
              ),
              SizedBox(height: 10),
              if (_tokens.length > 0) Wrap(children: _tokens),
              SizedBox(height: size(10)),
              GestureDetector(
                onTap: () async {
                  try {
                    Utils.showProgressBar();
                    Map<String, dynamic> map = {};
                    for (int index = 0; index < _tokens.length; index++) {
                      map['S${index + 1}'] = '0';
                    }
                    await FirebaseFirestore.instance
                        .collection('Hospital')
                        .doc(widget.hosptialID)
                        .collection('Doctors')
                        .doc(widget.doctorID)
                        .update(map);
                    Get.back();
                    Utils.showsuccess(
                        'All Token is Available to Book Appointments');
                    Navigator.pop(context);
                  } catch (error) {
                    print(error);
                    Get.back();
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(8)),
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Text('Clear All Tokens',
                      style: TextStyle(
                          color: AppTheme.whiteColor,
                          fontSize: 14,
                          fontFamily: AppTheme.poppins,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(height: size(10)),
            ],
          ),
        )));
  }
}

class SlotButton extends StatefulWidget {
  final String time, doctorID, hospitalID;
  final List<String> idList;
  final QuerySnapshot querySnapshot;
  SlotButton(
      {this.time,
      this.doctorID,
      this.hospitalID,
      this.idList,
      this.querySnapshot});
  @override
  _SlotButtonState createState() => _SlotButtonState();
}

class _SlotButtonState extends State<SlotButton> {
  String _type = '0';
  String _status = '';
  bool _isAvailable = true;
  String _id = '';
  TextEditingController _nameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getSlotStatus();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _numberController.dispose();
  }

  getSlotStatus() async {
    try {
      Future.delayed(Duration(milliseconds: 100)).whenComplete(() async {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('Hospital')
            .doc(widget.hospitalID)
            .collection('Doctors')
            .doc(widget.doctorID)
            .get();
        if (widget.idList != null) {
          List<String> ids = [];
          for (int index = 0; index < widget.idList.length; index++) {
            for (int i = 0; i < widget.querySnapshot.docs.length; i++) {
              if (widget.querySnapshot.docs[i].id == widget.idList[index]) {
                if (widget.querySnapshot.docs[i].data()['token'] ==
                    widget.time) {
                  ids.add(widget.idList[index]);
                }
              }
            }
          }
          if (ids.length > 0) {
            if (ids.length > 1) {
              _id = ids[ids.length - 1];
            } else {
              _id = ids[0];
            }
            if (_id != null) {
              if (_id != '') {
                DocumentSnapshot documentSnapshot = await FirebaseFirestore
                    .instance
                    .collection('Hospital')
                    .doc(widget.hospitalID)
                    .collection('Doctors')
                    .doc(widget.doctorID)
                    .collection('Appointments')
                    .doc(_id)
                    .get();
                if (documentSnapshot != null) {
                  _status = documentSnapshot.data()['status'];
                }
              }
            }
          }
        }
        if (snapshot.data() != null) {
          if (snapshot.data()[widget.time] != null) {
            setState(() {
              _isAvailable = (DateTime.now().day !=
                  DateTime.parse(snapshot.data()[widget.time]).day);
              _type = snapshot.data()['S${widget.time}'];
            });
          }
        }
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          if (_type == '0') {
            showDialog(
                context: context,
                child: AlertDialog(
                    content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Add Future Customer'),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: _textField(
                          _nameController, TextInputType.name, 'Customer Name'),
                    ),
                    SizedBox(height: size(10)),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: _textField(_numberController, TextInputType.phone,
                          'Mobile Number'),
                    ),
                    SizedBox(height: size(10)),
                    RaisedButton(
                      onPressed: () async {
                        try {
                          if (_nameController.text.trim() == '') {
                            Utils.showError('Please Enter Valid Name');
                          } else if (_numberController.text.trim().length !=
                              10) {
                            Utils.showError('Please Enter Valid Number');
                          } else {
                            String id = DateTime.now().toString();
                            Utils.showProgressBar();
                            await FirebaseFirestore.instance
                                .collection('Admin')
                                .doc('Future Customers')
                                .collection('List')
                                .doc(id)
                                .set({
                              'name': _nameController.text,
                              'number': _numberController.text,
                              'hospital': currentUser.displayName
                            });
                            await FirebaseFirestore.instance
                                .collection('Hospital')
                                .doc(widget.hospitalID)
                                .collection('Doctors')
                                .doc(widget.doctorID)
                                .update({
                              'S${widget.time}': '1',
                              '${widget.time}': DateTime.now().toString(),
                            });
                            await FirebaseFirestore.instance
                                .collection('Hospital')
                                .doc(widget.hospitalID)
                                .collection('Doctors')
                                .doc(widget.doctorID)
                                .collection('Appointments')
                                .doc(id)
                                .set({
                              'status': '1',
                              'token': widget.time,
                              'name': _nameController.text.trim(),
                              'number': _numberController.text.trim()
                            });
                            Get.back();
                            Navigator.pop(context);
                            Utils.showsuccess('Future Customer Added !');
                            _nameController.clear();
                            _numberController.clear();
                            setState(() {
                              _type = '1';
                            });
                          }
                        } catch (error) {
                          Get.back();
                          print(error);
                        }
                      },
                      child: Text('Send Customer Data'),
                      color: Colors.orange,
                    )
                  ],
                )));
          } else if (_type == '1') {
            showDialog(
                context: context,
                child: AlertDialog(
                    content: Column(children: [
                  GestureDetector(
                    onTap: () async {
                      try {
                        Utils.showProgressBar();
                        await FirebaseFirestore.instance
                            .collection('Hospital')
                            .doc(widget.hospitalID)
                            .collection('Doctors')
                            .doc(widget.doctorID)
                            .update({
                          'S${widget.time}': '2',
                          '${widget.time}': DateTime.now().toString(),
                        });
                        Get.back();
                        Navigator.pop(context);
                        Utils.showsuccess('Appointment Completed !');
                        setState(() {
                          _type = '2';
                        });
                      } catch (error) {
                        Get.back();
                      }
                    },
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5)),
                        alignment: Alignment.center,
                        child: Text('Tap to Complete Appointment',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center)),
                  ),
                  SizedBox(height: size(15)),
                  GestureDetector(
                    onTap: () async {
                      try {
                        Utils.showProgressBar();
                        await FirebaseFirestore.instance
                            .collection('Hospital')
                            .doc(widget.hospitalID)
                            .collection('Doctors')
                            .doc(widget.doctorID)
                            .update({
                          'S${widget.time}': '0',
                          '${widget.time}': DateTime.now()
                              .subtract(Duration(days: 1))
                              .toString(),
                        });
                        Get.back();
                        Navigator.pop(context);
                        Utils.showsuccess('Appointment Cancelled !');
                        setState(() {
                          _type = '0';
                        });
                      } catch (error) {
                        Get.back();
                      }
                    },
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5)),
                        alignment: Alignment.center,
                        child: Text('Tap to Cancel Appointment',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center)),
                  )
                ], mainAxisSize: MainAxisSize.min)));
          }
        } catch (error) {
          print(error);
          Get.back();
        }
      },
      child: Container(
        width: size(90),
        height: size(40),
        alignment: Alignment.center,
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: _type == '0'
              ? Colors.green
              : _type == '1'
                  ? Colors.orange
                  : Colors.red,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(widget.time,
            style:
                TextStyle(color: Colors.white, fontFamily: AppTheme.poppins)),
      ),
    );
  }

  Widget _textField(TextEditingController controller,
      TextInputType keyBoardType, String labelText,
      {int maxLength}) {
    return TextField(
      controller: controller,
      maxLength: maxLength,
      keyboardType: keyBoardType,
      decoration: InputDecoration(
        counterText: '',
        hintText: labelText,
        labelText: labelText,
        hintStyle: TextStyle(
            fontFamily: AppTheme.poppins, color: AppTheme.primaryColor),
        enabledBorder: new OutlineInputBorder(
          borderSide:
              const BorderSide(color: AppTheme.primaryColor, width: 1.0),
          borderRadius: const BorderRadius.all(
            const Radius.circular(8.0),
          ),
        ),
        focusedBorder: new OutlineInputBorder(
          borderSide:
              const BorderSide(color: AppTheme.primaryColor, width: 1.0),
          borderRadius: const BorderRadius.all(
            const Radius.circular(8.0),
          ),
        ),
        disabledBorder: new OutlineInputBorder(
          borderSide:
              const BorderSide(color: AppTheme.primaryColor, width: 1.0),
          borderRadius: const BorderRadius.all(
            const Radius.circular(8.0),
          ),
        ),
        border: new OutlineInputBorder(
          borderSide:
              const BorderSide(color: AppTheme.primaryColor, width: 1.0),
          borderRadius: const BorderRadius.all(
            const Radius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
