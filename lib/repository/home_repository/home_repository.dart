import '../../model/home/movie_model.dart';
import '../../network/network_api_services.dart';
import '../../resources/app_url/app_url.dart';

class HomeRepository {
  //
  final _apiServices = NetworkApiServices();

  //
  Future<MovieDetails> movieListApi(dynamic data) async {
    dynamic response = await _apiServices.postApi(AppUrl.moviesList, data);
    return MovieDetails.fromJson(response);
  }
}
