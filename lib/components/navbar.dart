import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Navbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemTapped;

  const Navbar({
    required this.currentIndex,
    required this.onItemTapped,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => onItemTapped(0),
            child: Container(
              padding: const EdgeInsets.all(12),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color:
                    currentIndex == 0 ? Color(0x1963B4FF) : Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: 24,
                            height: 24,
                            child: currentIndex == 0
                                ? SvgPicture.asset(
                                    'assets/icons/home-bold.svg',
                                  )
                                : SvgPicture.asset('assets/icons/home-2.svg')),
                      ],
                    ),
                  ),
                  if (currentIndex == 0) const SizedBox(width: 8),
                  if (currentIndex == 0)
                    const Text(
                      'Home',
                      style: TextStyle(
                        color: Color(0xFF63B4FF),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => onItemTapped(1),
            child: Container(
              padding: const EdgeInsets.all(12),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color:
                    currentIndex == 1 ? Color(0x1963B4FF) : Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: 24,
                            height: 24,
                            child: currentIndex == 1
                                ? SvgPicture.asset(
                                    'assets/icons/calendar-bold.svg')
                                : SvgPicture.asset(
                                    'assets/icons/calendar.svg',
                                    color: Colors.black38,
                                  )),
                      ],
                    ),
                  ),
                  if (currentIndex == 1) const SizedBox(width: 8),
                  if (currentIndex == 1)
                    const Text(
                      'Jadwal',
                      style: TextStyle(
                        color: Color(0xFF63B4FF),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              height: 48,
              padding: const EdgeInsets.all(12),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: 24,
                            height: 24,
                            child: SvgPicture.asset(
                              'assets/icons/message.svg',
                              color: Colors.black54,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              height: 48,
              padding: const EdgeInsets.all(12),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: 24,
                            height: 24,
                            child: SvgPicture.asset(
                              'assets/icons/profile.svg',
                              color: Colors.black45,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
