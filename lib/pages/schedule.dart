import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class Schedule extends StatefulWidget {
  final String token;
  final VoidCallback logout;
  const Schedule({super.key, required this.token, required this.logout});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  List<dynamic> doctorList = [];

  @override
  void initState() {
    super.initState();
    getDoctors();
  }

  FutureOr<void> getDoctors() async {
    try {
      final String tokenData = widget.token;
      final response = await http.post(
        Uri.parse('https://nexacaresys.codeplay.id/api/doctor'),
        headers: {'token': tokenData},
      );

      if (response.statusCode == 200) {
        final dynamic dataResponse = json.decode(response.body);
        final dynamic jsonData = dataResponse["response"]["data"];
        if (jsonData is Map<String, dynamic>) {
          setState(() {
            doctorList.add(jsonData);
          });
        } else {
          setState(() {
            doctorList = jsonData as List<dynamic>;
          });
        }
      } else {
        print(response.body);
        widget.logout();
      }
    } catch (e) {
      print('Exception during HTTP request: $e');
      // Handle exception
    }
  }

  showText() {
    getDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 24,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Container(
            transform: Matrix4.translationValues(
                -(MediaQuery.of(context).size.width / 2 - 110), 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.fromLTRB(32, 15, 32, 15),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(10, 0, 0, 0),
                        borderRadius: BorderRadius.circular(100)),
                    child: const Text(
                      "Jadwal Dibatalkan",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(100, 0, 0, 0)),
                    )),
                const SizedBox(width: 12),
                Container(
                    padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(20, 72, 148, 254),
                        borderRadius: BorderRadius.circular(100)),
                    child: const Text(
                      "Jadwal Dokter",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 72, 148, 254)),
                    )),
                const SizedBox(width: 12),
                Container(
                    padding: const EdgeInsets.fromLTRB(32, 15, 32, 15),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(10, 0, 0, 0),
                        borderRadius: BorderRadius.circular(100)),
                    child: const Text(
                      "Semua Jadwal",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(100, 0, 0, 0)),
                    )),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: doctorList
                          .map(
                            (e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xffffffff),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 20,
                                      color: Color.fromARGB(40, 90, 117, 167),
                                      offset: Offset(
                                        2,
                                        12,
                                      ),
                                    ),
                                  ],
                                ),
                                margin: const EdgeInsets.only(bottom: 20),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 16),
                                        height: 48,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          // crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: 48,
                                                  height: 48,
                                                  margin: const EdgeInsets.only(
                                                      right: 12),
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Color.fromARGB(
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
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      e['nama'],
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                          color: Colors.black),
                                                    ),
                                                    Text(
                                                      e['jenis'],
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 14,
                                                          color:
                                                              Colors.black45),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        color:
                                            Color.fromARGB(255, 240, 240, 240),
                                        thickness: 1,
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/icons/calendar.svg',
                                                color: Colors.black45,
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                e['tanggal'],
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 12,
                                                    color: Colors.black45),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/clock.svg',
                                                  color: Colors.black45,
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  e['jadwal'],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 12,
                                                      color: Colors.black45),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 24),
                                      Container(
                                        width: MediaQuery.sizeOf(context).width,
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              20, 72, 148, 254),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: Center(
                                            child: Text(
                                          "Detail",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromARGB(
                                                  255, 72, 148, 254)),
                                        )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 240, 240, 240),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/search-normal.svg'),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              "Search Doctor or Health Issues",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                  color: Colors.black38),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
