import 'package:GitaMobile/functions/about/views/about.view.dart';
import 'package:GitaMobile/functions/feed/views/explain.listing.view.dart';
import 'package:GitaMobile/functions/feed/views/feed.view.dart';
import 'package:GitaMobile/functions/feed/views/reading.view.dart';
import 'package:GitaMobile/functions/search/views/search.view.dart';
import 'package:GitaMobile/functions/splash/views/splash.view.dart';
import 'package:get/get.dart';

appRoutes() => [
      GetPage(
        name: '/splash',
        page: () => const SplashView(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 250),
      ),
      GetPage(
        name: '/',
        page: () => const FeedView(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 250),
      ),
      GetPage(
        name: '/explain',
        page: () => const ExplainListingView(),
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 250),
        showCupertinoParallax: true,
      ),
      GetPage(
        name: '/read',
        page: () => const ReadingView(),
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 250),
        showCupertinoParallax: true,
      ),
      GetPage(
        name: '/about',
        page: () => const AboutView(),
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 250),
        showCupertinoParallax: true,
      ),
      GetPage(
        name: '/search',
        page: () => const SearchView(),
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 250),
        showCupertinoParallax: true,
      ),
    ];
