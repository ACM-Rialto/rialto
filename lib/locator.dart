import 'package:get_it/get_it.dart';
import 'package:rialto/viewmodels/review_crud.dart';

import './services/api.dart';
import './viewmodels/contact_crud.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => Api('contactBuyerToSeller'));
  locator.registerLazySingleton(() => ContactCRUD());
  locator.registerLazySingleton(() => ReviewCRUD());
}