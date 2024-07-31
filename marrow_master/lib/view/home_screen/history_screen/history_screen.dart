import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../controller/home_main_controller/history_controller/history_controller.dart';
import 'history_screen_component/view_history_container.dart';
import '../result_screen/result_screen.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({super.key});
  final HistoryController historyController = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff184C9A),
          elevation: 3,
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40.0),
              bottomRight: Radius.circular(40.0),
            ),
          ),
          title: const Text(
            'Recent Searches',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: Obx(
          () {
            if (historyController.historyItems.isEmpty) {
              return const Center(child: Text("No History Available"));
            } else {
              return Container(
                height: 100.h,
                width: 100.w,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 237, 234, 234),
                ),
                child: ListView.builder(
                  itemCount: historyController.historyItems.length,
                  itemBuilder: (context, index) {
                    final item = historyController.historyItems[index];
                    return InkWell(
                      onTap: () =>
                          Get.to(() => const ResultScreen(), arguments: {
                        'name': item.name,
                        'description': item.text,
                        'image': item.imageUrl,
                        'check': false,
                      }),
                      child: viewHistoryContainer(
                        context: context,
                        time: item.date,
                        img: item.imageUrl,
                        icon: Icons.calendar_month_outlined,
                        text: item.name,
                        description: item.text,
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
