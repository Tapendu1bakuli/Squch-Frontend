import 'package:squch/core/utils/Resource.dart';
import 'package:squch/features/map_page_feature/domain/repositories/map_repository.dart';
import '../../domain/repositories/home_repository.dart';
import '../api_client/home_api_client.dart';


class HomeRepositoryImpl extends HomeRepository {
  final HomeApiClient apiClient;

  HomeRepositoryImpl({required this.apiClient});

  @override
  Future<Resource> getActiveRideData(Map<String,String>header) async {
    return await apiClient.getActiveRideData(header:header);
  }




}
