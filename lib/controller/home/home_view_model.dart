// import 'package:flutter_mvvm/model/home/user_list.dart';
import 'package:get/get.dart';

import '../../../model/home/movie_model.dart';
import '../../../repository/home_repository/home_repository.dart';
import '../../../response/status.dart';

class HomeController extends GetxController {
  //
  final _api = HomeRepository();
  //
  final rxRequestStatus = Status.LOADING.obs;
  final movieDetails = MovieDetails().obs;
  var votes = <String, VoteCounts>{}.obs;
  RxString error = ''.obs;
  RxInt? totalVotes = 0.obs;
  Map data = {
    'category': 'movies',
    'language': 'kannada',
    'sort': 'voting',
    'genre': 'all'
  };
//
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setMovieList(MovieDetails _value) => movieDetails.value = _value;
  void setError(String _value) => error.value = _value;
  //
  // Function to handle upvote
  void upvote(String movieId) {
    if (votes.containsKey(movieId)) {
      votes[movieId]!.upvotes++;
    } else {
      votes[movieId] = VoteCounts(upvotes: 1.obs, downvotes: 0.obs);
    }
  }

  // Function to handle downvote
  void downvote(String movieId) {
    if (votes.containsKey(movieId)) {
      if (votes[movieId]!.downvotes > 0) {
        votes[movieId]!.downvotes--;
      }
    } else {
      votes[movieId] = VoteCounts(upvotes: 0.obs, downvotes: 1.obs);
    }
  }

  // Function to get the vote counts for a movie
  // VoteCounts getVoteCounts(String movieId) {
  //   if (votes.containsKey(movieId)) {
  //     return votes[movieId]!;
  //   }
  //   return VoteCounts(upvotes: 0, downvotes: 0);
  // }

  RxInt getVotes(String movieId) {
    if (votes.containsKey(movieId)) {
      // VoteCounts voteCounts = votes[movieId]!;
      return votes[movieId]!.upvotes - votes[movieId]!.downvotes.value;
    }
    return 0.obs;
  }

//
  void movieListApi() {
    //
    _api.movieListApi(data).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setMovieList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  //
  void refreshApi() {
    setRxRequestStatus(Status.LOADING);

    //
    _api.movieListApi(data).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setMovieList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }
}

class VoteCounts {
  RxInt upvotes;
  RxInt downvotes;
  // RxInt totalVotes;

  VoteCounts({required this.upvotes, required this.downvotes});
  // : totalVotes = RxInt(upvotes - downvotes);

  // int get totalVotes => upvotes + downvotes;
}
