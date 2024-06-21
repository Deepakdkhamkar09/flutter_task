import 'package:flutter/material.dart';
import 'package:flutter_task/controller/profile_controller.dart';
import 'package:flutter_task/controller/step_controller.dart';
import 'package:flutter_task/profile_screen.dart';
import 'package:get/get.dart';
import 'package:horizontal_stepper_flutter/horizontal_stepper_flutter.dart';

import 'package:intl/intl.dart';

class StepsScreen extends StatefulWidget {
  const StepsScreen({super.key});

  @override
  State<StepsScreen> createState() => _StepsScreenState();
}

class _StepsScreenState extends State<StepsScreen> {
  final StepsController controller = Get.put(StepsController());
  final ProfileController profileController = Get.find();
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              controller.stepDecrement();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.amber,
            )),
      ),
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: GetBuilder<StepsController>(builder: (_) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: FlutterHorizontalStepper(
                    steps: const ["Step 1", "Step 2", "Step 3"],
                    radius: 45,
                    currentStep: controller.currentStep,
                    child: const [Text("1"), Text("2"), Text("3")],
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                controller.currentStep == 1
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            // height: 200,
                            child: Row(
                              children: [
                                profileController.profileImage != null
                                    ? ClipOval(
                                        child: Image.file(
                                          profileController.profileImage!,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : ClipOval(
                                        child: Image.asset(
                                          'assets/images/defoultProfile.png',
                                          width: 100.0,
                                          height: 100.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                const SizedBox(width: 30),
                                Text(profileController.nameController.text),
                              ],
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                controller.currentStep == 2
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 1, color: Colors.black)),
                              height: 55,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: DropdownButton(
                                  padding: const EdgeInsets.all(10),
                                  isDense: true,
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  icon: const Icon(
                                    Icons.arrow_downward,
                                  ),
                                  elevation: 16,
                                  onChanged: (newValue) {
                                    if (newValue != null) {
                                      controller.selectDay(newValue);
                                    }
                                  },
                                  value: controller.selectedDay,
                                  items: controller.days.map((location) {
                                    return DropdownMenuItem(
                                      child: new Text(location),
                                      value: location,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
                controller.currentStep == 3
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'From Date  - ${formatter.format(controller.fromDate!)}',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'To Date      - ${formatter.format(controller.toDate!)}',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Select        - ${controller.selectedDay}',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Total ${controller.selectedDay}      - ${controller.occurrenceCount}',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      controller.currentStep == 2
                          ? Row(
                              children: [
                                buildDateSelector(
                                  label: 'From Date',
                                  selectedDate: controller.fromDate,
                                  onChanged: (DateTime? newValue) {
                                    controller.fromDateSelected(newValue!);
                                  },
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                buildDateSelector(
                                  label: 'To Date',
                                  selectedDate: controller.toDate,
                                  onChanged: (DateTime? newValue) {
                                    controller.toDateSelected(newValue!);
                                  },
                                ),
                              ],
                            )
                          : const SizedBox(),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          controller.stepIncrement();

                          print("step no ${controller.currentStep}");
                          if (controller.currentStep == 3) {
                            controller.calculateOccurrences(
                                controller.selectedDay!,
                                controller.fromDate!,
                                controller.toDate!);
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blue,
                          ),
                          child: Center(
                            child: Text(
                              controller.currentStep == 3 ? "Finish" : "Next",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            );
          })),
    );
  }

  Widget buildDateSelector({
    required String label,
    required DateTime? selectedDate,
    required ValueChanged<DateTime?> onChanged,
  }) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');

    return GestureDetector(
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: label == 'To Date'
              ? controller.fromDate
              : selectedDate ?? DateTime.now(),
          firstDate: label == 'To Date' ? controller.fromDate! : DateTime(2015),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null && pickedDate != selectedDate) {
          setState(() {
            onChanged(pickedDate);
          });
        }
      },
      child: Container(
        height: 50,
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            color: Colors.black,
            style: BorderStyle.solid,
            width: 0.80,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedDate != null
                    ? formatter.format(selectedDate)
                    : '$label',
                style: const TextStyle(fontSize: 14.0),
              ),
              const Icon(
                Icons.calendar_today,
                size: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
