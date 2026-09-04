import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'routes.dart';
import '../theme/app_theme.dart';
import '../theme/colors.dart';
import '../views/splash_view.dart';
import '../views/onboarding_one_view.dart';
import '../views/onboarding_two_view.dart';
import '../views/onboarding_three_view.dart';
import '../views/login_view.dart';
import '../views/signup_view.dart';
import '../views/forgot_password_view.dart';
import '../views/main_shell.dart';
import '../views/service_details_view.dart';
import '../views/create_transaction_view.dart';
import '../views/transaction_details_view.dart';
import '../views/notifications_view.dart';

class MuamalatApp extends StatelessWidget {
  const MuamalatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'معاملات',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child ?? const SizedBox.shrink(),
        );
      },
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      locale: const Locale('ar'),
      initialRoute: AppRoutes.splash,
      onGenerateRoute: _generateRoute,
    );
  }

  Route<dynamic> _generateRoute(RouteSettings settings) {
    Widget page;
    switch (settings.name) {
      case AppRoutes.splash:
        page = const SplashView();
        break;
      case AppRoutes.onboarding:
        page = const OnboardingOneView();
        break;
      case AppRoutes.onboardingTwo:
        page = const OnboardingTwoView();
        break;
      case AppRoutes.onboardingThree:
        page = const OnboardingThreeView();
        break;
      case AppRoutes.login:
        page = const LoginView();
        break;
      case AppRoutes.signup:
        page = const SignupView();
        break;
      case AppRoutes.forgotPassword:
        page = const ForgotPasswordView();
        break;
      case AppRoutes.main:
        page = const MainShell();
        break;
      case AppRoutes.serviceDetails:
        final id = settings.arguments as String;
        page = ServiceDetailsView(serviceId: id);
        break;
      case AppRoutes.createTransaction:
        final id = settings.arguments as String;
        page = CreateTransactionView(serviceId: id);
        break;
      case AppRoutes.transactionDetails:
        final id = settings.arguments as String;
        page = TransactionDetailsView(transactionId: id);
        break;
      case AppRoutes.notifications:
        page = const NotificationsView();
        break;
      default:
        page = const _NotFoundView();
    }
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
    );
  }
}

class _NotFoundView extends StatelessWidget {
  const _NotFoundView();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: const Center(
        child: Text(
          'الصفحة غير موجودة',
          style: TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 18,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
