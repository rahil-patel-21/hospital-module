//Flutter Imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hospital/globals/responsive.dart';
import 'package:hospital/globals/user_details.dart';
import 'package:hospital/screens/homepage.dart';
import 'package:hospital/services/auth.dart';
import 'package:hospital/theme/app_theme.dart';
import 'package:hospital/utils/utils.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddDoctor extends StatefulWidget {
  final bool isEdit;
  final String doctorID;
  AddDoctor({this.doctorID, this.isEdit = false});
  @override
  _AddDoctorState createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _experienceController = TextEditingController();
  TextEditingController _feesController = TextEditingController();
  TextEditingController _service1Controller = TextEditingController();
  TextEditingController _service2Controller = TextEditingController();
  TextEditingController _service3Controller = TextEditingController();
  TextEditingController _service4Controller = TextEditingController();
  TextEditingController _service5Controller = TextEditingController();
  TextEditingController _special1Controller = TextEditingController();
  TextEditingController _special2Controller = TextEditingController();
  TextEditingController _special3Controller = TextEditingController();
  TextEditingController _special4Controller = TextEditingController();
  TextEditingController _special5Controller = TextEditingController();
  TextEditingController _education1Controller = TextEditingController();
  TextEditingController _education2Controller = TextEditingController();
  TextEditingController _education3Controller = TextEditingController();
  TextEditingController _education4Controller = TextEditingController();
  TextEditingController _education5Controller = TextEditingController();
  TextEditingController _tokenController = TextEditingController();

  File _avatarFile;
  String _avatarURL;

  DocumentSnapshot snapshot;

  bool _isMonday = true;
  bool _isTuesday = true;
  bool _isWednesday = true;
  bool _isThursday = true;
  bool _isFriday = true;
  bool _isSaturday = true;
  bool _isSunday = true;

  DateTime _openingTime = DateTime(2021, 1, 1, 09, 00);
  DateTime _closingTime = DateTime(2021, 1, 1, 20, 00);

  pickImage() async {
    try {
      ImagePicker imagePicker = ImagePicker();
      PickedFile file = await imagePicker.getImage(
          source: ImageSource.gallery, imageQuality: 65);
      if (file != null) {
        _avatarFile = File(file.path);
      }
      setState(() {});
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      getDoctorInfo();
    }
  }

  getDoctorInfo() async {
    try {
      Future.delayed(Duration(milliseconds: 100)).whenComplete(() async {
        Utils.showProgressBar();
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection('Hospital')
            .doc(currentUser.phoneNumber)
            .collection('Doctors')
            .doc(widget.doctorID)
            .get();
        Get.back();
        setState(() {
          snapshot = documentSnapshot;
          dynamic data = snapshot.data();
          _avatarURL = data['profile'];
          _nameController.text = data['name'];
          _experienceController.text = data['years'];
          _feesController.text = data['fees'];
          _isMonday = data['monday'];
          _isTuesday = data['tuesday'];
          _isWednesday = data['wednesday'];
          _isThursday = data['thursday'];
          _isFriday = data['friday'];
          _isSaturday = data['saturday'];
          _isSunday = data['sunday'];
          _service1Controller.text = data['service1'];
          _service2Controller.text = data['service2'];
          _service3Controller.text = data['service3'];
          _service4Controller.text = data['service4'];
          _service5Controller.text = data['service5'];
          _education1Controller.text = data['education1'];
          _education2Controller.text = data['education2'];
          _education3Controller.text = data['education3'];
          _education4Controller.text = data['education4'];
          _education5Controller.text = data['education5'];
          _special1Controller.text = data['special1'];
          _special2Controller.text = data['special2'];
          _special3Controller.text = data['special3'];
          _special4Controller.text = data['special4'];
          _special5Controller.text = data['special5'];
          _openingTime = DateTime.parse(data['OpeningTime']);
          _closingTime = DateTime.parse(data['ClosingTime']);
          _tokenController.text = data['tokens'];
        });
      });
    } catch (error) {
      Get.back();
      print(error);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _experienceController.dispose();
    _feesController.dispose();
    _service1Controller.dispose();
    _service2Controller.dispose();
    _service3Controller.dispose();
    _service4Controller.dispose();
    _service5Controller.dispose();
    _special1Controller.dispose();
    _special2Controller.dispose();
    _special3Controller.dispose();
    _special4Controller.dispose();
    _special5Controller.dispose();
    _education1Controller.dispose();
    _education2Controller.dispose();
    _education3Controller.dispose();
    _education4Controller.dispose();
    _education5Controller.dispose();
    _tokenController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: AppBar(
            title: Text('Add Doctor',
                style: TextStyle(
                    fontFamily: AppTheme.poppins,
                    fontWeight: FontWeight.bold))),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => pickImage(),
                child: Container(
                  height: size(70),
                  width: size(70),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1000),
                      color: AppTheme.primaryAccent,
                      image: _avatarFile == null && _avatarURL == null
                          ? null
                          : DecorationImage(
                              fit: BoxFit.cover,
                              image: _avatarURL != null
                                  ? NetworkImage(_avatarURL)
                                  : FileImage(_avatarFile))),
                  child: Icon(Icons.add),
                ),
              ),
              SizedBox(height: 10),
              Text(
                _avatarURL != null || _avatarFile != null
                    ? 'Profile Picture'
                    : 'Add Profile Picture',
                style: TextStyle(
                    fontFamily: AppTheme.poppins, color: AppTheme.primaryColor),
              ),
              SizedBox(height: 20),
              _textField('Dr. Name', _nameController, TextInputType.name),
              SizedBox(height: 10),
              _textField('Years of Experience', _experienceController,
                  TextInputType.number),
              SizedBox(height: 10),
              _textField('Fees', _feesController, TextInputType.number),
              SizedBox(height: 10),
              _textField('Services 1', _service1Controller, TextInputType.name),
              SizedBox(height: 10),
              _textField('Services 2 (Optional)', _service2Controller,
                  TextInputType.name),
              SizedBox(height: 10),
              _textField('Services 3 (Optional)', _service3Controller,
                  TextInputType.name),
              SizedBox(height: 10),
              _textField('Services 4 (Optional)', _service4Controller,
                  TextInputType.name),
              SizedBox(height: 10),
              _textField('Services 5 (Optional)', _service5Controller,
                  TextInputType.name),
              SizedBox(height: 10),
              _textField(
                  'Specialization 1', _special1Controller, TextInputType.name),
              SizedBox(height: 10),
              _textField('Specialization 2 (Optional)', _special2Controller,
                  TextInputType.name),
              SizedBox(height: 10),
              _textField('Specialization 3 (Optional)', _special3Controller,
                  TextInputType.name),
              SizedBox(height: 10),
              _textField('Specialization 4 (Optional)', _special4Controller,
                  TextInputType.name),
              SizedBox(height: 10),
              _textField('Specialization 5 (Optional)', _special5Controller,
                  TextInputType.name),
              SizedBox(height: 10),
              _textField(
                  'Education', _education1Controller, TextInputType.name),
              SizedBox(height: 10),
              _textField('Education 2 (Optional)', _education2Controller,
                  TextInputType.name),
              SizedBox(height: 10),
              _textField('Education 3 (Optional)', _education3Controller,
                  TextInputType.name),
              SizedBox(height: 10),
              _textField('Education 4 (Optional)', _education4Controller,
                  TextInputType.name),
              SizedBox(height: 10),
              _textField('Education 5 (Optional)', _education5Controller,
                  TextInputType.name),
              SizedBox(height: 10),
              Check(
                  'Monday',
                  () => setState(() {
                        _isMonday = !_isMonday;
                      }),
                  _isMonday),
              Check(
                  'Tuesday',
                  () => setState(() {
                        _isTuesday = !_isTuesday;
                      }),
                  _isTuesday),
              Check(
                  'Wednesday',
                  () => setState(() {
                        _isWednesday = !_isWednesday;
                      }),
                  _isWednesday),
              Check(
                  'Thursday',
                  () => setState(() {
                        _isThursday = !_isThursday;
                      }),
                  _isThursday),
              Check(
                  'Friday',
                  () => setState(() {
                        _isFriday = !_isFriday;
                      }),
                  _isFriday),
              Check(
                  'Saturday',
                  () => setState(() {
                        _isSaturday = !_isSaturday;
                      }),
                  _isSaturday),
              Check(
                  'Sunday',
                  () => setState(() {
                        _isSunday = !_isSunday;
                      }),
                  _isSunday),
              SizedBox(height: 20),
              Text('Select Duration & No. of Tokens',
                  style: TextStyle(color: AppTheme.primaryColor)),
              SizedBox(height: 10),
              Row(
                children: [
                  Text('Opening Time : ',
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontFamily: AppTheme.poppins,
                      )),
                  Icon(Icons.calendar_today),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () async => _selectOpeningTime(),
                    child: Text(DateFormat('hh:mm a').format(_openingTime),
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontFamily: AppTheme.poppinsBold,
                        )),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text('Closing Time :   ',
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontFamily: AppTheme.poppins,
                      )),
                  Icon(Icons.calendar_today),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () async => _selectClosingTime(),
                    child: Text(DateFormat('hh:mm a').format(_closingTime),
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontFamily: AppTheme.poppinsBold,
                        )),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text('No. of Tokens : ',
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontFamily: AppTheme.poppins,
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  _textField('Tokens', _tokenController, TextInputType.number,
                      width: MediaQuery.of(context).size.width * 0.25,
                      maxLength: 2),
                ],
              ),
              SizedBox(height: 15),
              RaisedButton(
                  color: Colors.orange,
                  onPressed: () async {
                    try {
                      if (_nameController.text.trim() == '') {
                        Utils.showError('Please enter valid name');
                      } else if (_experienceController.text.trim() == '') {
                        Utils.showError(
                            'Please enter valid years of experience');
                      } else if (_feesController.text.trim() == '' ||
                          _feesController.text.length == 0) {
                        Utils.showError('Please enter valid fess');
                      } else if (_avatarFile == null && !widget.isEdit) {
                        Utils.showError('Please select profile picture');
                      } else if (_service1Controller.text == '') {
                        Utils.showError('Please Add atleast 1 Service');
                      } else if (_special1Controller.text == '') {
                        Utils.showError('Please Add atleast 1 Specialization');
                      } else if (_education1Controller.text == '') {
                        Utils.showError('Please Add atleast 1 Education');
                      } else if (_tokenController.text == '') {
                        Utils.showError('Please Add atleast 1 Token');
                      } else {
                        Utils.showProgressBar();
                        DocumentSnapshot snap = await FirebaseFirestore.instance
                            .collection('Hospital')
                            .doc(currentUser.phoneNumber)
                            .get();
                        Map<String, dynamic> map = {
                          'name': _nameController.text,
                          'years': _experienceController.text,
                          'fees': _feesController.text,
                          'monday': _isMonday,
                          'tuesday': _isTuesday,
                          'wednesday': _isWednesday,
                          'thursday': _isThursday,
                          'friday': _isFriday,
                          'saturday': _isSaturday,
                          'sunday': _isSunday,
                          'profile': widget.isEdit
                              ? _avatarURL
                              : await Auth.uploadPhoto(_avatarFile),
                          'hospitalID': currentUser.phoneNumber,
                          'address': snap.data()['address'],
                          'service1': _service1Controller.text,
                          'service2': _service2Controller.text,
                          'service3': _service3Controller.text,
                          'service4': _service4Controller.text,
                          'service5': _service5Controller.text,
                          'special1': _special1Controller.text,
                          'special2': _special2Controller.text,
                          'special3': _special3Controller.text,
                          'special4': _special4Controller.text,
                          'special5': _special5Controller.text,
                          'education1': _education1Controller.text,
                          'education2': _education2Controller.text,
                          'education3': _education3Controller.text,
                          'education4': _education4Controller.text,
                          'education5': _education5Controller.text,
                          'hospital': currentUser.displayName,
                          'OpeningTime': _openingTime.toString(),
                          'ClosingTime': _closingTime.toString(),
                          'tokens': _tokenController.text.trim()
                        };
                        for (int index = 0;
                            index < int.parse(_tokenController.text.trim());
                            index++) {
                          map['${index + 1}'] = DateTime.now()
                              .subtract(Duration(days: 1))
                              .toString();
                          map['S${index + 1}'] = '0';
                        }
                        String id = widget.isEdit
                            ? widget.doctorID
                            : DateTime.now().toString();
                        await FirebaseFirestore.instance
                            .collection('Hospital')
                            .doc(currentUser.phoneNumber)
                            .collection('Doctors')
                            .doc(id)
                            .set(map);
                        Get.back();
                        widget.isEdit
                            ? Utils.showsuccess('Profile Updated Successfully')
                            : Utils.showsuccess(
                                'Profile Created Successfully !');
                        Get.offAll(HomePage());
                      }
                    } catch (error) {
                      print(error);
                    }
                  },
                  child: Text(widget.isEdit ? 'Update Info' : 'Add Doctor',
                      style: TextStyle(
                          fontFamily: AppTheme.poppins,
                          color: AppTheme.whiteColor))),
              SizedBox(height: 80),
            ],
          ),
        )));
  }

  _selectOpeningTime() async {
    TimeOfDay time = await showTimePicker(
        context: context, initialTime: TimeOfDay(hour: 10, minute: 00));
    if (time != null) {
      final DateTime now = DateTime.now();
      _openingTime =
          DateTime(now.year, now.month, now.day, time.hour, time.minute);
    }
    setState(() {});
  }

  _selectClosingTime() async {
    TimeOfDay time = await showTimePicker(
        context: context, initialTime: TimeOfDay(hour: 20, minute: 00));
    final DateTime now = DateTime.now();
    _closingTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    setState(() {});
  }

  Widget _textField(String labelText, TextEditingController controller,
      TextInputType keyboardType,
      {double width, int maxLength}) {
    return Container(
      width: width,
      child: TextField(
        maxLength: maxLength,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          counterText: '',
          hintText: labelText,
          labelStyle: TextStyle(
              fontFamily: AppTheme.poppins, color: AppTheme.primaryColor),
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
          labelText: labelText,
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
      ),
    );
  }
}

class Check extends StatefulWidget {
  final String title;
  final Function() onTap;
  final bool isSelected;
  Check(this.title, this.onTap, this.isSelected);
  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: widget.isSelected,
            onChanged: (_) {
              widget.onTap();
            },
            activeColor: AppTheme.primaryColor),
        Container(
          child: Text(widget.title,
              style: TextStyle(fontFamily: AppTheme.poppins)),
        )
      ],
    );
  }
}
