import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../app_router.dart';
import '../network/local/cache_helper.dart';

void signOut(context) async {
  await FirebaseAuth.instance.signOut();
  print("Signed Out Successfully");
  Navigator.pushReplacementNamed(context, AppRouter.loginScreen);

// CacheHelper.removeCacheData(key: '').then(
//   (value) {
//     if (value) {
//       Navigator.pushReplacementNamed(context, AppRouter.loginScreen);
//     }
//   },
// );
}
