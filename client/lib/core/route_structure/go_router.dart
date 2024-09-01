// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:professionals/navigation_bar/bottom_nav_bar.dart';
// import 'package:professionals/onboarding/onboardingscreen.dart';
// import 'package:professionals/splash/splash_screen.dart';
// import 'package:professionals/tailor/views/auth/tailor_registration_screen.dart';
// import 'package:professionals/technician/views/technician_home/technician_home_screen.dart';
// import 'package:professionals/vendor/vendor_bottom_navbar/vendor_bottom_navbar.dart';
// import 'package:professionals/vendor/views/auth/vendor_signup_screen.dart';
// import 'package:professionals/vendor/views/vendor_dashboard/vendor_dashboard_screen.dart';
// import 'package:professionals/views/auth/forgot_password/forgot_password_screen.dart';
// import 'package:professionals/views/auth/login_screen.dart';
// import 'package:professionals/views/auth/otp/enter_otp_screen.dart';
// import 'package:professionals/views/auth/signup_screen.dart';
// import 'package:professionals/views/home/home_screen.dart';
// // import 'package:professionals/views/home/home_screen.dart';
// import 'package:professionals/widgets/error_screen.dart';

// class RouteName {
//   static const String splashScreen = 'splash';
//   static const String loginScreen = 'login';
//   static const String onboardingScreen = 'onboarding';
//   static const String signupScreen = 'sign-up';
//   static const String otpScreen = 'otp-screen';
//   static const String forgotPasswordScreen = 'forgot-password';
//   static const String bottomNavBar = 'bottom-nav-bar';
//   static const String homeScreen = 'home';
//   static const String wishlistScreen = 'wish-list';
//   static const String productDetailsScreen = 'product-details';
//   static const String categoryProductsScreen = 'category-products';
//   static const String cartScreen = 'cart';
//   static const String checkOutScreen = 'checkout';
//   static const String paymentOptionsScreen = 'payment-options';
//   static const String reviewOrderScreen = 'review-order';
//   static const String myOrdersScreen = 'my-orders';
//   static const String profileScreen = 'profile';
//   static const String editProfileScreen = 'edit-profile';
//   static const String faqScreen = 'faq';
//   static const String changePasswordScreen = 'change-password';
//   static const String aboutUsScreen = 'about-us';
//   static const String vendorSignUpScreen = 'vendor-sign-up';
//   static const String vendorBottomNavBar = 'vendor-bottom-nav-bar';

//   GoRouter myrouter = GoRouter(
//     errorPageBuilder: (context, state) {
//       return const MaterialPage(
//         child: ErrorScreen(),
//       );
//     },
//     routes: [
//       GoRoute(
//         path: '/',
//         name: splashScreen,
//         pageBuilder: (context, state) {
//           return const MaterialPage(
//             child: SplashScreen(),
//           );
//         },
//       ),
//       GoRoute(
//         path: '/$onboardingScreen',
//         name: onboardingScreen,
//         pageBuilder: (context, state) {
//           return const MaterialPage(
//             child: OnboardingScreen(),
//           );
//         },
//       ),
//       GoRoute(
//         path: '/$loginScreen',
//         name: loginScreen,
//         pageBuilder: (context, state) {
//           return const MaterialPage(
//             child: LoginScreen(),
//           );
//         },
//       ),
//       GoRoute(
//         path: '/$signupScreen',
//         name: signupScreen,
//         pageBuilder: (context, state) {
//           return const MaterialPage(
//             child: SignupScreen(),
//           );
//         },
//       ),
//       GoRoute(
//         path: '/$otpScreen/:verificationId',
//         name: otpScreen,
//         pageBuilder: (context, state) {
//           return MaterialPage(
//             child: EnterOtpScreen(
//               verificationId: state.pathParameters['verificationId'] ?? '',
//             ),
//           );
//         },
//       ),
//       GoRoute(
//         path: '/$forgotPasswordScreen',
//         name: forgotPasswordScreen,
//         pageBuilder: (context, state) {
//           return const MaterialPage(
//             child: ForgotPasswordScreen(),
//           );
//         },
//       ),
//       GoRoute(
//         path: '/$bottomNavBar/:currentIndex',
//         name: bottomNavBar,
//         pageBuilder: (context, state) {
//           return MaterialPage(
//             child: BottomNavBar(
//               currentIndex: state.pathParameters['currentIndex'] ?? '',
//             ),
//           );
//         },
//       ),
//       GoRoute(
//         path: '/$vendorSignUpScreen',
//         name: vendorSignUpScreen,
//         pageBuilder: (context, state) {
//           return const MaterialPage(
//             child: VendorSignupScreen(),
//           );
//         },
//       ),
//       GoRoute(
//         path: '/$vendorBottomNavBar/:currentIndex',
//         name: vendorBottomNavBar,
//         pageBuilder: (context, state) {
//           return MaterialPage(
//             child: VendorBottomNavBar(
//               currentIndex: state.pathParameters['currentIndex'] ?? '',
//             ),
//           );
//         },
//       ),
//       // GoRoute(
//       //   path: '/$homeScreen',
//       //   name: homeScreen,
//       //   pageBuilder: (context, state) {
//       //     return const MaterialPage(
//       //       child: HomeScreen(
//       //           // title: state.pathParameters['title'] ?? '',
//       //           ),
//       //     );
//       //   },
//       // ),
//       // GoRoute(
//       //   path: '/$wishlistScreen',
//       //   name: wishlistScreen,
//       //   pageBuilder: (context, state) {
//       //     return const MaterialPage(
//       //       child: WishlistScreen(),
//       //     );
//       //   },
//       // ),
//       // GoRoute(
//       //   path: '/$productDetailsScreen/:productImage/:productTitle',
//       //   name: productDetailsScreen,
//       //   pageBuilder: (context, state) {
//       //     return MaterialPage(
//       //       child: ProductDetailsScreen(
//       //         productImage: state.pathParameters['productImage'] ?? '',
//       //         productTitle: state.pathParameters['productTitle'] ?? '',
//       //       ),
//       //     );
//       //   },
//       // ),
//       // GoRoute(
//       //   path: '/$categoryProductsScreen/:categoryTitle',
//       //   name: categoryProductsScreen,
//       //   pageBuilder: (context, state) {
//       //     return MaterialPage(
//       //       child: CategoryProductsScreen(
//       //         categoryTitle: state.pathParameters['categoryTitle'] ?? '',
//       //       ),
//       //     );
//       //   },
//       // ),
//       // GoRoute(
//       //   path: '/$cartScreen',
//       //   name: cartScreen,
//       //   pageBuilder: (context, state) {
//       //     return const MaterialPage(
//       //       child: CartScreen(),
//       //     );
//       //   },
//       // ),
//       // GoRoute(
//       //   path: '/$checkOutScreen',
//       //   name: checkOutScreen,
//       //   pageBuilder: (context, state) {
//       //     return const MaterialPage(
//       //       child: CheckoutScreen(),
//       //     );
//       //   },
//       // ),
//       // GoRoute(
//       //   path: '/$paymentOptionsScreen',
//       //   name: paymentOptionsScreen,
//       //   pageBuilder: (context, state) {
//       //     return const MaterialPage(
//       //       child: PaymentOptionsScreen(),
//       //     );
//       //   },
//       // ),
//       // GoRoute(
//       //   path: '/$reviewOrderScreen',
//       //   name: reviewOrderScreen,
//       //   pageBuilder: (context, state) {
//       //     return const MaterialPage(
//       //       child: ReviewOrderScreen(),
//       //     );
//       //   },
//       // ),
//       // GoRoute(
//       //   path: '/$myOrdersScreen',
//       //   name: myOrdersScreen,
//       //   pageBuilder: (context, state) {
//       //     return const MaterialPage(
//       //       child: MyOrderScreen(),
//       //     );
//       //   },
//       // ),
//       // GoRoute(
//       //   path: '/$editProfileScreen',
//       //   name: editProfileScreen,
//       //   pageBuilder: (context, state) {
//       //     return const MaterialPage(
//       //       child: EditProfileScreen(),
//       //     );
//       //   },
//       // ),
//       // GoRoute(
//       //   path: '/$mallDetailsScreen',
//       //   name: mallDetailsScreen,
//       //   pageBuilder: (context, state) {
//       //     return const MaterialPage(
//       //       child: MallsDetailsScreen(),
//       //     );
//       //   },
//       // ),
//     ],
//   );
// }
