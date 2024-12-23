import 'package:clean_pro_user/di/di.dart';
import 'package:clean_pro_user/repository/auth_local_repo.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyIngection.init();
 String? tocken= await AuthLocalRepo.getToken();

  runApp( MyApp(tocken: tocken,));
}
