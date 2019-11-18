import 'package:get_it/get_it.dart';

import './services/api.dart';
import './viewmodels/CRUDModel.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => Api('contactBuyerToSeller'));
  locator.registerLazySingleton(() => CRUDModel()) ;
}