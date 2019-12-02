import 'package:get_it/get_it.dart';
import 'package:rialto/viewmodels/review_crud.dart';

import './services/api.dart';
import './viewmodels/contact_crud.dart';

GetIt contactBuyerToSellerLocator = GetIt();
GetIt reviewsLocator = GetIt();

void setupLocator() {
  contactBuyerToSellerLocator.registerLazySingleton(() => Api('contactBuyerToSeller'));
  contactBuyerToSellerLocator.registerLazySingleton(() => ContactCRUD());
  reviewsLocator.registerLazySingleton(() => Api('users'));
  reviewsLocator.registerLazySingleton(() => ReviewCRUD());
}