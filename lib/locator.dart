import 'package:get_it/get_it.dart';

import './services/api.dart';
import './viewmodels/contact_crud.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => Api('contactBuyerToSeller'));
  locator.registerLazySingleton(() => ContactCRUD()) ;
}