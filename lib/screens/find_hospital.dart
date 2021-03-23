//Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hospital/constants/resources.dart';
import 'package:hospital/theme/app_theme.dart';

import 'hospital_page.dart';

class FindAHospitalPage extends StatefulWidget {
  @override
  _FindAHospitalPageState createState() => _FindAHospitalPageState();
}

class _FindAHospitalPageState extends State<FindAHospitalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: AppBar(
            title: Text('Find a hospital',
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
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              prefixIcon: Container(
                                child: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                              ),
                              hintText: 'Search Name ...',
                              hintStyle: TextStyle(
                                  fontFamily: AppTheme.poppins,
                                  color: AppTheme.primaryColor),
                              enabledBorder: new OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppTheme.primaryColor, width: 1.0),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(8.0),
                                ),
                              ),
                              focusedBorder: new OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppTheme.primaryColor, width: 1.0),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(8.0),
                                ),
                              ),
                              disabledBorder: new OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppTheme.primaryColor, width: 1.0),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(8.0),
                                ),
                              ),
                              border: new OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppTheme.primaryColor, width: 1.0),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(8.0),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
              SizedBox(height: 5),
              Container(
                alignment: Alignment.centerLeft,
                child: Text('Search by hospital',
                    style: TextStyle(
                        fontFamily: AppTheme.poppins,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HospitalPage())),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6)),
                      padding: EdgeInsets.all(10),
                      width: (MediaQuery.of(context).size.width - 50) / 2,
                      child: Row(
                        children: [
                          Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey.withOpacity(0.41),
                                  borderRadius: BorderRadius.circular(1000)),
                              child: SvgPicture.asset(hospitalASVG)),
                          SizedBox(width: 5),
                          Text('Shelby',
                              style: TextStyle(fontFamily: AppTheme.poppins))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6)),
                    padding: EdgeInsets.all(10),
                    width: (MediaQuery.of(context).size.width - 50) / 2,
                    child: Row(
                      children: [
                        Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey.withOpacity(0.41),
                                borderRadius: BorderRadius.circular(1000)),
                            child: SvgPicture.asset(hospitalBSVG)),
                        SizedBox(width: 5),
                        Text('Zydus',
                            style: TextStyle(fontFamily: AppTheme.poppins))
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6)),
                    padding: EdgeInsets.all(10),
                    width: (MediaQuery.of(context).size.width - 50) / 2,
                    child: Row(
                      children: [
                        Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey.withOpacity(0.41),
                                borderRadius: BorderRadius.circular(1000)),
                            child: SvgPicture.asset(hospitalCSVG)),
                        SizedBox(width: 5),
                        Text('CIMS',
                            style: TextStyle(fontFamily: AppTheme.poppins))
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6)),
                    padding: EdgeInsets.all(10),
                    width: (MediaQuery.of(context).size.width - 50) / 2,
                    child: Row(
                      children: [
                        Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey.withOpacity(0.41),
                                borderRadius: BorderRadius.circular(1000)),
                            child: SvgPicture.asset(hospitalDSVG)),
                        SizedBox(width: 5),
                        Text('Ortho Exp.',
                            style: TextStyle(fontFamily: AppTheme.poppins))
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6)),
                    padding: EdgeInsets.all(10),
                    width: (MediaQuery.of(context).size.width - 50) / 2,
                    child: Row(
                      children: [
                        Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey.withOpacity(0.41),
                                borderRadius: BorderRadius.circular(1000)),
                            child: SvgPicture.asset(hospitalESVG)),
                        SizedBox(width: 5),
                        Text('Civil',
                            style: TextStyle(fontFamily: AppTheme.poppins))
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6)),
                    padding: EdgeInsets.all(10),
                    width: (MediaQuery.of(context).size.width - 50) / 2,
                    child: Row(
                      children: [
                        Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey.withOpacity(0.41),
                                borderRadius: BorderRadius.circular(1000)),
                            child: SvgPicture.asset(hospitalASVG)),
                        SizedBox(width: 5),
                        Text('Navkar',
                            style: TextStyle(fontFamily: AppTheme.poppins))
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6)),
                    padding: EdgeInsets.all(10),
                    width: (MediaQuery.of(context).size.width - 50) / 2,
                    child: Row(
                      children: [
                        Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey.withOpacity(0.41),
                                borderRadius: BorderRadius.circular(1000)),
                            child: SvgPicture.asset(hospitalASVG)),
                        SizedBox(width: 5),
                        Text('Shelby',
                            style: TextStyle(fontFamily: AppTheme.poppins))
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6)),
                    padding: EdgeInsets.all(10),
                    width: (MediaQuery.of(context).size.width - 50) / 2,
                    child: Row(
                      children: [
                        Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey.withOpacity(0.41),
                                borderRadius: BorderRadius.circular(1000)),
                            child: SvgPicture.asset(hospitalBSVG)),
                        SizedBox(width: 5),
                        Text('Zydus',
                            style: TextStyle(fontFamily: AppTheme.poppins))
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6)),
                    padding: EdgeInsets.all(10),
                    width: (MediaQuery.of(context).size.width - 50) / 2,
                    child: Row(
                      children: [
                        Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey.withOpacity(0.41),
                                borderRadius: BorderRadius.circular(1000)),
                            child: SvgPicture.asset(hospitalCSVG)),
                        SizedBox(width: 5),
                        Text('CIMS',
                            style: TextStyle(fontFamily: AppTheme.poppins))
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6)),
                    padding: EdgeInsets.all(10),
                    width: (MediaQuery.of(context).size.width - 50) / 2,
                    child: Row(
                      children: [
                        Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey.withOpacity(0.41),
                                borderRadius: BorderRadius.circular(1000)),
                            child: SvgPicture.asset(hospitalDSVG)),
                        SizedBox(width: 5),
                        Text('Ortho Exp.',
                            style: TextStyle(fontFamily: AppTheme.poppins))
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6)),
                    padding: EdgeInsets.all(10),
                    width: (MediaQuery.of(context).size.width - 50) / 2,
                    child: Row(
                      children: [
                        Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey.withOpacity(0.41),
                                borderRadius: BorderRadius.circular(1000)),
                            child: SvgPicture.asset(hospitalESVG)),
                        SizedBox(width: 5),
                        Text('Civil',
                            style: TextStyle(fontFamily: AppTheme.poppins))
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6)),
                    padding: EdgeInsets.all(10),
                    width: (MediaQuery.of(context).size.width - 50) / 2,
                    child: Row(
                      children: [
                        Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey.withOpacity(0.41),
                                borderRadius: BorderRadius.circular(1000)),
                            child: SvgPicture.asset(hospitalASVG)),
                        SizedBox(width: 5),
                        Text('Navkar',
                            style: TextStyle(fontFamily: AppTheme.poppins))
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        )));
  }
}
