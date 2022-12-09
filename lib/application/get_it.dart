import 'package:get_it/get_it.dart';
import 'package:reservations/repository/reservation_repository.dart';

final getIt = GetIt.instance;

void registerRepositories() {
  getIt.registerLazySingleton<ReservationRepository>(
    () => ReservationRepositoryImpls(),
  );
}
