import 'package:flutter/material.dart';
import 'package:flutter_movies/model/home/movie_model.dart';
import 'package:flutter_movies/resources/colors/app_colors.dart';
import 'package:flutter_movies/utils/utils.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/user_prefernce/user_preferences.dart';
import 'package:get/get.dart';

import 'package:flutter_movies/resources/assets/image_assets.dart';
import 'package:flutter_movies/resources/components/roun_button.dart';
import '../../controller/home/home_view_model.dart';
import '../../resources/components/internet_exceptions.dart';
import '../../response/status.dart';
import '../../routes/routes_name.dart';
import 'detail_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //
  final homeController = Get.put(HomeController());
  //
  UserPreference userPreference = UserPreference();

  final searchController = TextEditingController();

  bool isVisible = true;

  ///
  @override
  void initState() {
    super.initState();
    homeController.movieListApi();
  }

//
  int count = 0;

  //
  void increment(int movieId) {
    setState(() {
      movies.elementAt(movieId).count++;
    });
  }

  //
  void decrement(int movieId) {
    setState(() {
      if (count > 0) movies.elementAt(movieId).count--;
    });
  }

  List movies = [];

//
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        // leading: Text(count),
        elevation: 0,
        title: const Text('Home'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.primaryColor,
        actions: [
          PopupMenuButton(
              elevation: 0,
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: GestureDetector(
                          onTap: () {
                            Get.back();
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  icon: Container(
                                      height: 60,
                                      width: 100,
                                      // radius: 40,
                                      // color: Colors.amber,
                                      child: const Image(
                                        fit: BoxFit.contain,
                                        image: AssetImage(
                                          ImageAssets.logo,
                                        ),
                                      )),
                                  content: Container(
                                    height: size.height * 0.12,
                                    width: size.width * 0.8,
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Geeksyenergy Technology Pvt Ltd',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        alignWidget(
                                            firstText: 'Address',
                                            secondText:
                                                'Sanjaynagar,Bengaluru-56'),
                                        alignWidget(
                                            firstText: 'Email',
                                            secondText: 'xxxxxx@gmail.com'),
                                        alignWidget(
                                            firstText: 'Phone',
                                            secondText: 'xxxxxxxx09')
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Text('Company Info')),
                    ),
                    PopupMenuItem(
                      child: GestureDetector(
                        onTap: () {
                          userPreference.removeUser().then(
                            (value) {
                              Utils.taostMessage('Successfully sign out');
                              Get.offAllNamed(RoutesName.loginView);
                              //   });
                            },
                          );
                        },
                        child: const Text('Sign Out'),
                      ),
                    ),
                  ]),
        ],
      ),
      body: Column(
        children: [
          Visibility(
            visible: true,
            child: TextFormField(
              controller: searchController,
              decoration: const InputDecoration(
                  hintText: 'Search Movie',
                  border: OutlineInputBorder(borderSide: BorderSide())),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              switch (homeController.rxRequestStatus.value) {
                case Status.LOADING:
                  return ListView.builder(
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                            children: [
                              ListTile(
                                title: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                                // Text(snapshot.data![index]['country']),
                                subtitle: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                                leading: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                //     //
                case Status.ERROR:
                  return Center(
                    child: InternetExceptionWidget(onPress: () {
                      homeController.refreshApi();
                    }),
                  );

                case Status.COMPLETED:
                  return ListView.builder(
                      itemCount:
                          homeController.movieDetails.value.result!.length,
                      itemBuilder: (context, index) {
                        // movies.add(homeController.movieDetails.value.result);
                        String movieId = homeController
                            .movieDetails.value.result![index].id
                            .toString();
                        RxInt totalVotes = homeController.getVotes(movieId);
                        // List<Movie> apiMovies = ... \\// Movies fetched from the API

                        // List<LocalMovie> localMovies =
                        //     apiMovies.map((apiMovie) {
                        //   return LocalMovie(
                        //     id: apiMovie.id,
                        //     title: apiMovie.title,
                        //     description: apiMovie.description,
                        //   );
                        // }).toList();
                        // MovieDetails movieDetails = MovieDetails();
                        // String movieId = movieDetails.result![index].id;

                        String name = homeController
                            .movieDetails.value.result![index].title
                            .toString();
                        if (searchController.text.isEmpty) {
                          return searchMethod(index, movieId, totalVotes);
                        } else if (name
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                          return searchMethod(index, movieId, totalVotes);
                        } else {
                          return const SizedBox();
                        }
                      });
              }
            }),
          ),
        ],
      ),
    );
  }

  Padding searchMethod(int index, dynamic movieId, RxInt totalVotes) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailView(
                            image: homeController
                                .movieDetails.value.result![index].poster
                                .toString(),
                            name: homeController
                                .movieDetails.value.result![index].title
                                .toString(),
                          )));
            },
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            // increment(movieId);
                            homeController.upvote(movieId);
                          },
                          icon: const Icon(
                            Icons.arrow_drop_up,
                            size: 35,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        // homeController
                        //     .movieDetails.value.result![index].voted.length
                        //     .toString(),
                        // count.toString(),
                        totalVotes.toString(),
                        // homeController.getVotes(movieId).toString(),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      IconButton(
                        onPressed: () {
                          // decrement(movieId);
                          homeController.downvote(movieId);
                        },
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 90,
                    height: 150,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.elliptical(10, 10),
                          topRight: Radius.elliptical(10, 10),
                          bottomLeft: Radius.elliptical(10, 10),
                          bottomRight: Radius.elliptical(10, 10)),
                      child: Image(
                        image: NetworkImage(homeController
                            .movieDetails.value.result![index].poster),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 210,
                        child: Text(
                          homeController.movieDetails.value.result![index].title
                              .toString(),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      newMethod(
                          index: index,
                          name: 'Genre: ',
                          data: homeController
                              .movieDetails.value.result![index].genre
                              .toString()),
                      newMethod(
                          index: index,
                          name: 'Director: ',
                          data: homeController
                              .movieDetails.value.result![index].director.first
                              .toString()),
                      newMethod(
                          index: index,
                          name: 'Starring: ',
                          data: homeController
                              .movieDetails.value.result![index].stars.first
                              .toString()),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            "${homeController.movieDetails.value.result![index].runTime.toString() == "null" ? '150' : homeController.movieDetails.value.result![index].runTime.toString()} Mins",
                          ),
                          const Text(
                            '| ',
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(homeController
                              .movieDetails.value.result![index].language.name
                              .toString()),
                          const Text(
                            ' | ',
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            width: 15,
                            child: Text(
                              homeController.movieDetails.value.result![index]
                                  .releasedDate
                                  .toString(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            "${homeController.movieDetails.value.result![index].pageViews.toString()} views",
                            style: const TextStyle(color: Colors.blue),
                          ),
                          const Text(
                            ' | ',
                            style: TextStyle(fontSize: 15, color: Colors.blue),
                          ),
                          Text(
                            "Voted by ${homeController.movieDetails.value.result![index].voted.length.toString()} People",
                            style: const TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          RoundButton(
            title: 'Watch Trailer',
            onPress: () {},
            height: 35,
            width: double.infinity,
          ),
        ],
      ),
    );
  }

  Row alignWidget({
    required String firstText,
    required String secondText,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          firstText,
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black),
        ),
        const SizedBox(
          width: 10,
          height: 5,
        ),
        const Text(
          ":",
          style: TextStyle(fontSize: 8, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          width: 2,
          height: 5,
        ),
        Expanded(
          flex: 3,
          child: Text(
            secondText,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Container newMethod(
      {required int index, required String name, required String data}) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Row(
        children: [
          Text(
            name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700),
          ),
          Container(
            width: 150,
            child: Text(
              data,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
