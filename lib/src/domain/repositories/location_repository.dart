import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_app/src/data/models/location.dart';

abstract class LocationRepository {
  Future<Either<Exception, List<Location>>> getAllLocations({int page = 1});
}
