import 'package:bodymind/features/splash/presentation/provider/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  ProviderSubscription<AsyncValue<AppStartState>>? _sub;

  @override
  void initState() {
    super.initState();

    _sub = ref.listenManual<AsyncValue<AppStartState>>(appStartProvider, (prev, next) {
      if (next.hasValue || next.hasError) {
        FlutterNativeSplash.remove();
      }
    });
  }

  @override
  void dispose() {
    _sub?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}