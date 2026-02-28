import 'package:bodymind/features/main_feature/health/detail/activity/presentation/view/health_dtl_act_view.dart';
import 'package:bodymind/features/main_feature/health/detail/heartrate/presentation/view/health_dtl_heart_view.dart';
import 'package:bodymind/features/main_feature/main_feature_nav/bottom_navigation_view.dart';
import 'package:bodymind/features/splash/presentation/provider/splash_provider.dart';
import 'package:bodymind/features/splash/presentation/view/splash_view.dart';
import 'package:bodymind/features/user/presentation/view/view/user_register_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


import '../../features/main_feature/home/presentation/view/home_view.dart';
import '../../features/onboard/presentation/view/onboard_view.dart';

final _rootNavigationKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>();
final _chatNavigatorKey = GlobalKey<NavigatorState>();
final _contentNavigatorKey = GlobalKey<NavigatorState>();
final _settingNavigatorKey = GlobalKey<NavigatorState>();

final routeProvider = Provider<GoRouter>((ref){
  final startAsync = ref.watch(appStartProvider);

  return GoRouter(
      navigatorKey: _rootNavigationKey,
      initialLocation: '/splash',

      routes: [
        GoRoute(
          path: '/splash',
          name: 'splash',
          builder: (context, state) => SplashView()
        ),
        GoRoute(
          path: '/onboard',
          name: 'onBoard',
          builder: (context, state) => OnboardView(),
        ),
        GoRoute(
            path: '/user',
            name: 'user',
            builder: (context, state) => UserRegisterView()
        ),
        GoRoute(
            path: '/feature/heart/:ymd',
            name: 'featureHeartYmd',
            builder: (context, state) {
              final ymd = state.pathParameters['ymd'];
              return HealthDtlHeartView(receivedYmd: ymd);
            }
        ),
        GoRoute(
          path: '/feature/heart',
          name: 'featureHeart',
          builder: (context, state) {
            return HealthDtlHeartView(); // ymd 없이
          },
        ),
        GoRoute(
            path: '/feature/act/:ymd',
            name: 'featureActYmd',
            builder: (context, state) {
              final ymd = state.pathParameters['ymd'];
              return HealthDtlActView(receivedYmd: ymd,);
            }
        ),
        GoRoute(
          path: '/feature/act',
          name: 'featureAct',
          builder: (context, state) {
            return HealthDtlActView(); // ymd 없이
          },
        ),
        //bottomNavigationView 하위 위젯 정의
        StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) {
              return BottomNavigationView(navShell: navigationShell);
            },
            branches: [
              StatefulShellBranch(
                navigatorKey: _homeNavigatorKey,
                routes: [
                  GoRoute(
                    path: '/home',
                    name: 'home',
                    pageBuilder: (context, state) => NoTransitionPage(child: HomeView()),
                  )
                ]
              ),
              // StatefulShellBranch(
              //     navigatorKey: _chatNavigatorKey,
              //     routes: [
              //
              //     ]
              // ),
              // StatefulShellBranch(
              //     navigatorKey: _contentNavigatorKey,
              //     routes: [
              //
              //     ]
              // ),
              // StatefulShellBranch(
              //     navigatorKey: _settingNavigatorKey,
              //     routes: [
              //
              //     ]
              // ),

            ]
        )
      ],

    redirect: (context, state) {
      final location = state.matchedLocation;

      if (startAsync.isLoading || startAsync.hasError) {
        return location == '/splash' ? null : '/splash';
      }

      final isOnboarded = startAsync.value?.isOnboarded ?? false;
      final isUserRegistered = startAsync.value?.isUserRegistered ?? false;

      if (!isOnboarded) return location == '/onboard' ? null : '/onboard';
      if (!isUserRegistered) return location == '/user' ? null : '/user';

      // ✅ 완료 상태에서는 blocking 페이지만 home으로 보내고, 나머지는 허용
      final blocking = location == '/splash' || location == '/onboard' || location == '/user';
      if (blocking) return '/home';

      return null;
    }
    );
});