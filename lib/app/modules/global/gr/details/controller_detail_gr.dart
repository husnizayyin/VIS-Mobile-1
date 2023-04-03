import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vis_mobile/app/core/value/colors.dart';
import 'package:vis_mobile/app/data/models/detail_gr.dart';
import 'package:vis_mobile/app/data/providers/detail_gr_provider.dart';

class DetailGrController extends GetxController {
  final DetailGrProvider detailGrProvider;

  DetailGrController({required this.detailGrProvider});

  var isLoading = true.obs;
  final total_row = 0.obs;
  var id = ''.obs;
  var detailgr = <DetailGr>[].obs;

  @override
  void onInit() {
    fetchDetailGr();
    super.onInit();
  }

  void fetchDetailGr() async {
    try {
      final response = await detailGrProvider.fetchDetailGr(id);
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        total_row.value = body['total_row'];

        detailgr.value = body['data'] == null
            ? []
            : listDetailGrFromJson(jsonEncode(body['data']));

        update();
      } else {
        Get.snackbar(
          'Failed',
          '${response.statusCode}',
          backgroundColor: Colors.amber.withOpacity(0.8),
          colorText: blueColor,
          icon: const Icon(Icons.warning, color: blueColor),
        );
      }
    } on IOException {
      Get.snackbar(
        'Failed',
        'Something went wrong',
        backgroundColor: Colors.amber.withOpacity(0.8),
        colorText: blueColor,
        icon: const Icon(Icons.warning, color: blueColor),
      );
    }

    isLoading.value = false;
    update();
  }
}
