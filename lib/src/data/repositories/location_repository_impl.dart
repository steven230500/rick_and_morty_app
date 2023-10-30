import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_app/src/data/models/location.dart';
import 'package:rick_and_morty_app/src/data/services/api.dart';
import 'package:rick_and_morty_app/src/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final ApiService apiService;

  LocationRepositoryImpl(this.apiService);

  @override
  Future<Either<Exception, List<Location>>> getAllLocations({int page = 1}) async {
    return await apiService.getLocations(page: page);
  }
}
