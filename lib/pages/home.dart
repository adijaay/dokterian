import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final String token;
  final VoidCallback logout;
  const HomePage({super.key, required this.token, required this.logout});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> doctorNearbyList = [];

  @override
  void initState() {
    super.initState();
    getNearestDoctor();
  }

  FutureOr<void> getNearestDoctor() async {
    try {
      final String tokenData = widget.token;
      final response = await http.post(
        Uri.parse('https://nexacaresys.codeplay.id/api/nearby'),
        headers: {'token': tokenData},
      );

      if (response.statusCode == 200) {
        final dynamic dataResponse = json.decode(response.body);
        final dynamic jsonData = dataResponse["response"]["dataResponse"];
        if (jsonData is Map<String, dynamic>) {
          setState(() {
            doctorNearbyList.add(jsonData);
          });
        } else {
          setState(() {
            doctorNearbyList = jsonData as List<dynamic>;
          });
          print("doctorNearbyList: $doctorNearbyList");
        }
      } else {
        print(response.body);
        widget.logout();
      }
    } catch (e) {
      print('Exception during HTTP request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Hello,',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal,
                          fontSize: 16),
                    ),
                    Text('Dimas Okva',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ],
                ),
                GestureDetector(
                  onTap: () => widget.logout(),
                  child: ClipOval(
                    child: Image.asset('assets/images/Frame.png'),
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 24),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Color(0xff4894FE),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            height: 48,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 48,
                                      height: 48,
                                      margin: const EdgeInsets.only(right: 12),
                                      clipBehavior: Clip.antiAlias,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child: Image.asset(
                                        'assets/images/image8.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Dr. Adi Wijaya',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          'Dokterian',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SvgPicture.asset(
                                    'assets/icons/arrow-right.svg'),
                              ],
                            ),
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 1,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/icons/calendar.svg'),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Sunday, 12 June',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/clock.svg'),
                                    const SizedBox(width: 8),
                                    const Text(
                                      '11.00 - 12.00 AM',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 240, 240, 240),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/search-normal.svg'),
                        const SizedBox(width: 16),
                        const Text("Cari Dokter Spesialis",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                color: Colors.black38))
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 240, 240, 240),
                                borderRadius: BorderRadius.circular(100)),
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Container(
                                  height: 24,
                                  width: 24,
                                  child: SvgPicture.asset(
                                    'assets/icons/profile-add.svg',
                                  )),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Dokter',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                color: Colors.black38),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 240, 240, 240),
                                borderRadius: BorderRadius.circular(100)),
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Container(
                                  height: 24,
                                  width: 24,
                                  child: SvgPicture.asset(
                                    'assets/icons/link.svg',
                                  )),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Obat & Resep',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                color: Colors.black38),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 240, 240, 240),
                                borderRadius: BorderRadius.circular(100)),
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: SvgPicture.asset(
                                    'assets/icons/hospital.svg',
                                  )),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Rumah Sakit',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                color: Colors.black38),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 32),
                  Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Dokter Terdekat",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Column(
                            mainAxisSize: MainAxisSize.min,
                            children: doctorNearbyList
                                .map((e) => Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xffffffff),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 20,
                                            color: Color.fromARGB(
                                                40, 90, 117, 167),
                                            offset: Offset(
                                              2,
                                              12,
                                            ),
                                          )
                                        ],
                                      ),
                                      margin: const EdgeInsets.only(bottom: 20),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 16),
                                              height: 48,
                                              decoration: BoxDecoration(),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                mainAxisSize: MainAxisSize.max,
                                                // crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        width: 48,
                                                        height: 48,
                                                        margin: const EdgeInsets
                                                            .only(right: 12),
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        decoration:
                                                            const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        240,
                                                                        240,
                                                                        240)),
                                                        child: Image.asset(
                                                          'assets/images/image8.png',
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            e['nama'],
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          Text(
                                                            e['jenis'],
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black45),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/location.svg',
                                                        color: Colors.black45,
                                                      ),
                                                      SizedBox(width: 8),
                                                      Text(
                                                        e['jarak'] != null
                                                            ? e['jarak']
                                                            : '',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.black45),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Divider(
                                              color: Color.fromARGB(
                                                  255, 240, 240, 240),
                                              thickness: 1,
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/clock.svg',
                                                        color:
                                                            Color(0xffFEB052),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      const Text(
                                                        '48 (120 Reviews)',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 12,
                                                            color: Color(
                                                                0xffFEB052)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/clock.svg',
                                                        color:
                                                            Color(0xff4894FE),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Text(
                                                        e['jadwal']
                                                                .split(' ')[0] +
                                                            " " +
                                                            e['jadwal']
                                                                .split(' ')[3],
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 12,
                                                            color: Color(
                                                                0xff4894FE)),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ))
                                .toList()),
                      ])
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
