import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

import '../../../core/imports/index.dart';
import '../../../core/loader.dart';
import '../../../theme/index.dart';
import '../controllers/verse.controller.dart';
import '../widgets/index.dart';

class FeedView extends StatefulWidget {
  const FeedView({super.key});

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  void getPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const BeveledRectangleBorder(),
          actionsAlignment: MainAxisAlignment.center,
          backgroundColor: Pallet.primaryColor,
          title: const Text(
            "Permission Denied!",
            style: TextStyle(fontSize: 20, color: Pallet.darkColor),
          ),
          content: const Text(
            "Please allow us storage permission to save screenshot and share.",
            style: TextStyle(color: Pallet.darkColor, fontStyle: FontStyle.normal, fontWeight: FontWeight.normal, fontFamily: 'Roboto'),
          ),
          buttonPadding: const EdgeInsets.all(4),
          actionsPadding: const EdgeInsets.all(4),
          actionsOverflowButtonSpacing: 5,
          actionsOverflowAlignment: OverflowBarAlignment.center,
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Back',
                style: TextStyle(color: Pallet.darkColor),
              ),
            ),
            const TextButton(
              onPressed: openAppSettings,
              child: Text(
                'Settings',
                style: TextStyle(color: Pallet.darkColor),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ScreenshotController screenshotController = ScreenshotController();
    final VerseController controller = Get.put(VerseController(context: context));

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Pallet.whiteColor,
    ));
    return Scaffold(
      backgroundColor: Pallet.primaryColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Obx(
          () => controller.isloading.value
              ? const Loader()
              : Column(
                  children: [
                    FeedAppbar(
                      name: 'Devotees of Krishna',
                      profileUrl: PIMGS.defaultUser,
                      ontapProfile: () {},
                      onPressSearch: () {},
                    ),
                    controller.dailyVerse.value.text.isNotEmpty
                        ? ShlokaCard(
                            onPressRight: controller.increaseVerseNo,
                            onPressLeft: () {
                              if (controller.verseNo.value == 0) {
                                return;
                              } else {
                                controller.descreseVerseNo();
                              }
                            },
                            onPressLike: () {},
                            onPressExplain: () => Get.toNamed(
                              'explain',
                              arguments: [...controller.dailyVerse.value.translations, ...controller.dailyVerse.value.commentaries],
                            ),
                            onPressShare: () => controller.shareVerse(
                              shotController: screenshotController,
                              context: context,
                              slug: controller.dailyVerse.value.slug,
                              getPermissionDialog: getPermissionDialog,
                            ),
                            titleText: controller.dailyVerse.value.slug,
                            child: Screenshot(
                              controller: screenshotController,
                              child: MainContent(
                                shlokaText: controller.dailyVerse.value.text,
                                shlokaEngText: controller.dailyVerse.value.transliteration,
                                translation: controller.dailyVerse.value.translations[0].description,
                              ),
                            ),
                          )
                        : NetworkErrorCard(onReload: controller.getVerse),
                  ],
                ),
        ),
      ),
    );
  }
}
