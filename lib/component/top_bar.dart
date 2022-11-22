import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  TopBar({Key? key}) : super(key: key);

  List<String> poplist = ['My Profile', 'Log Out'];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
        child: Container(
      height: 55,
      decoration: const BoxDecoration(
        color: Color(0xff327C04),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0.8,
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Image(
              image: AssetImage('/image/dashborad_logo.png'),
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Container(
                    height: double.maxFinite,
                    // color: Colors.orange[300],
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Center(
                      child: Text(
                        'Dashboard',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: Color(0xffffffff)),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: double.maxFinite,
                    // color: Colors.orange[300],
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Center(
                      child: Text(
                        'Task',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: Color(0xffffffff)),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: double.maxFinite,
                    // color: Colors.orange[300],
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Center(
                      child: Text(
                        'Crop Plans',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: Color(0xffffffff)),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: double.maxFinite,
                    // color: Colors.orange[300],
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Center(
                      child: Text(
                        'Crop',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: Color(0xffffffff)),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: double.maxFinite,
                    // color: Colors.orange[300],
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Center(
                      child: Text(
                        'Farms',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: Color(0xffffffff)),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: double.maxFinite,
                    // color: Colors.orange[300],
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Center(
                      child: Text(
                        'Inventory',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: Color(0xffffffff)),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: double.maxFinite,
                    // color: Colors.orange[300],
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Center(
                      child: Text(
                        'Growth Stage',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: Color(0xffffffff)),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: double.maxFinite,
                    // color: Colors.orange[300],
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Center(
                      child: Text(
                        'GAP Analysis',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: Color(0xffffffff)),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: double.maxFinite,
                    // color: Colors.orange[300],
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Center(
                      child: Text(
                        'User',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: Color(0xffffffff)),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: double.maxFinite,
                    // color: Colors.orange[300],
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Center(
                      child: Text(
                        'Allocation',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: Color(0xffffffff)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 15,
                  backgroundImage: NetworkImage(
                      'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909__340.png'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 4.0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                  ),
                  child: PopupMenuButton(
                      offset: const Offset(0, 50),
                      color: const Color(0xff327C04),
                      tooltip: '',
                      // elevation: 0,
                      padding: const EdgeInsets.all(0),
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xffffffff),
                      ),
                      onSelected: (value) {
                        if (value == 'My Profile') {
                          print('My Profile');
                        } else {
                          print('Logout');
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return poplist
                            .map(
                              (e) => PopupMenuItem<int>(
                                padding: const EdgeInsets.only(left: 20),
                                height: 40,
                                child: SizedBox(
                                  width: 200,
                                  child: Text(
                                    e,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      color: Color(0xffffffff),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList();
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
