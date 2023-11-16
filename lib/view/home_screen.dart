import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_project/controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          // App bar for the home screen
          centerTitle: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              // Handle back button press
            },
          ),
          backgroundColor: Colors.white,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Class Time Table",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              GetBuilder<HomeController>(
                  init: homeController,
                  builder: (_) {
                    return DropdownButton<String>(
                      // Dropdown for selecting academic year
                      value: homeController.selectedValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Colors.black,
                      ),
                      onChanged: (String? newValue) {
                        // Handle dropdown value change
                        homeController.changeDropdownValue(newValue);
                        homeController.update();
                      },
                      items: homeController.dropDownItems.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                    );
                  }),
            ],
          ),
        ),
      ),
      body: GetBuilder<HomeController>(
          init: homeController,
          builder: (_) {
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Divider(
                  color: Colors.grey.withOpacity(0.9),
                ),
                GestureDetector(
                  onTap: () {
                    // Open the bottom sheet for selecting class and section
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return MyBottomSheet();
                      },
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() {
                          return Text(
                            homeController.isSelectedClassAndSection!.value
                                ? '${homeController.classes} ${homeController.section}'
                                : "Choose Your Class and Section",
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          );
                        }),
                        const Icon(Icons.arrow_drop_down, color: Colors.black)
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey.withOpacity(0.9),
                ),
                const SizedBox(
                  height: 10,
                ),
                homeController.isSelectedClassAndSection!.value
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          // Container for displaying days of the week
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Mon',
                                  style: TextStyle(color: Colors.black),
                                ),
                                const Text(
                                  'Tues',
                                  style: TextStyle(color: Colors.black),
                                ),
                                const Text(
                                  'Wed',
                                  style: TextStyle(color: Colors.black),
                                ),
                                const Text(
                                  'Thur',
                                  style: TextStyle(color: Colors.black),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.deepOrange,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Fri',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Sat',
                                  style: TextStyle(color: Colors.deepOrange),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const Text(''),
                const SizedBox(
                  height: 20,
                ),
                homeController.isSelectedClassAndSection!.value
                    ? timeTable() // Display timetable
                    : const Center(
                        child: Text(
                        "No Time Table found!",
                        style: TextStyle(fontSize: 20),
                      )),
              ],
            );
          }),
    );
  }

  // Widget for the bottom sheet for selecting class and section
  Widget MyBottomSheet() {
    return GetBuilder<HomeController>(
        init: homeController,
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
                child: Text(
                  'Select Class and Section',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                height: 450,
                child: Row(
                  children: [
                    // First List - Class List
                    Expanded(
                      flex: 3,
                      child: ListView.builder(
                        itemCount: homeController.leftList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              ListTile(
                                title: Text(homeController.leftList[index]),
                                onTap: () {
                                  // Handle class selection
                                  homeController.changeClassAndSectionValue(
                                      homeController.leftList[index]);
                                  homeController
                                      .isSelectedClassAndSection!.value = true;
                                  log("test ${homeController.leftList[index]}");
                                  homeController.classes =
                                      homeController.leftList[index];
                                  homeController.update();
                                  //Navigator.pop(context);
                                },
                              ),
                              Divider(
                                color: Colors.grey.withOpacity(0.8),
                              )
                            ],
                          );
                        },
                      ),
                    ),

                    // Second List with Radio Buttons - Section List
                    Expanded(
                      flex: 2,
                      child: ListView.builder(
                        itemCount: homeController.rightList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            color: Colors.grey.withOpacity(0.1),
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio<String>(
                                    value: homeController.rightList[index],
                                    groupValue:
                                        homeController.selectedRightValue,
                                    onChanged: (String? value) {
                                      // Handle section selection
                                      homeController.isSelectedClassAndSection!
                                          .value = true;
                                      homeController.changeSection(value);

                                      homeController.section = value!;
                                      log("test 2:-  ${homeController.section}");
                                      homeController.update();
                                      Get.back();
                                    },
                                  ),
                                  Text(homeController.rightList[index]),
                                ],
                              ),
                              onTap: () {
                                // Handle section selection
                                homeController.changeSection(
                                    homeController.rightList[index]);
                                Get.back();
                                homeController.update();
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  // Widget to display the timetable
  Widget timeTable() {
    return GetBuilder<HomeController>(
        init: homeController,
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 600,
              child: ListView.builder(
                itemCount: homeController.timetableData["periods"],
                itemBuilder: (BuildContext context, int index) {
                  var entry = homeController.timetableData["timetable"][index];

                  if (entry.containsKey("period")) {
                    // Display for periods
                    return Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(homeController.getTime(entry["startTime"])),
                              Text(
                                '\n${homeController.getPeriodDescription(entry)}',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            const Icon(
                              Icons.fiber_manual_record,
                              color: Colors.deepOrange,
                            ),
                            CustomPaint(
                              painter: DottedLinePainter(),
                              child: Container(
                                height: 60, // Adjust the height as needed
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('${entry["subject"] ?? ""}'),
                                      Text('${entry["staff"] ?? ""}'),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const Icon(Icons.person),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  } else if (entry.containsKey("break")) {
                    // Display for breaks
                    return Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Text('${entry["break"] ?? ""}'),
                              Text(
                                '${homeController.getTime(entry["startTime"])} - ${homeController.getTime(entry["endTime"])}',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            const Icon(
                              Icons.fiber_manual_record,
                              color: Colors.deepOrange,
                            ),
                            CustomPaint(
                              painter: DottedLinePainter(),
                              child: Container(
                                height: 60, // Adjust the height as needed
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.deepOrange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text('${entry["break"] ?? ""}'),
                            ),
                          ),
                        )
                      ],
                    );
                  }

                  return Container(); // Placeholder for other cases or invalid entries
                },
              ),
            ),
          );
        });
  }
}

// Custom painter for drawing a dotted line
class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.deepOrange
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    double dashWidth = 2.0;
    double dashSpace = 4.0;
    double startY = 0.0;
    double endY = size.height;

    double currentY = startY;

    while (currentY < endY) {
      canvas.drawLine(
        Offset(size.width / 2, currentY),
        Offset(size.width / 2, currentY + dashWidth),
        paint,
      );

      currentY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
