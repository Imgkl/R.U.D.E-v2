import 'package:rude/services/navigation_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.I;
void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
}