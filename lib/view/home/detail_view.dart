// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DetailView extends StatefulWidget {
  String name, image;
  // int totalCases,
  //     totalDeaths,
  // totalRecovered,
  // active,
  // critical,
  // todayRecovered,
  // test;
  DetailView({
    Key? key,
    required this.image,
    // required this.active,
    // required this.todayRecovered,
    // required this.totalRecovered,
    // required this.test,
    // required this.critical,
    required this.name,
    // required this.totalDeaths,
    // required this.totalCases,
  }) : super(key: key);

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
        // backgroundColor: Colors.grey.shade400,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(alignment: Alignment.topCenter, children: [
            Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 300,
                    child: ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.elliptical(10, 10),
                          topRight: Radius.elliptical(10, 10),
                          bottomLeft: Radius.elliptical(10, 10),
                          bottomRight: Radius.elliptical(10, 10)),
                      child: Image(
                        image: NetworkImage(widget.image),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * .04,
                  // ),
                  // ReusableRow(
                  //     title: 'Total Tests',
                  //     value: widget.test.toString()),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * .04,
                  // ),
                  // ReusableRow(
                  //     title: 'Total Cases',
                  //     value: widget.totalCases.toString()),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * .04,
                  // ),
                  // ReusableRow(
                  //     title: 'Total Recovered',
                  //     value: widget.todayRecovered.toString()),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * .04,
                  // ),
                  // ReusableRow(
                  //     title: 'Total Deaths',
                  //     value: widget.totalDeaths.toString()),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .04,
                  ),
                  // ReusableRow(
                  //     title: 'Critical',
                  //     value: widget.critical.toString()),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .04,
                  ),
                ]),
          ]),
        ],
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value),
      ],
    );
  }
}
