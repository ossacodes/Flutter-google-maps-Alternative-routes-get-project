import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class RouteTile extends StatefulWidget {
  const RouteTile({
    Key? key,
    required this.routeName,
    required this.routeDescription,
    required this.routeDistance,
    required this.color,
    required this.distance,
    required this.turn,
    required this.isExpanded,
  }) : super(key: key);

  final String routeName;
  final String routeDescription;
  final String routeDistance;
  final Color color;
  final bool isExpanded;
  final String distance;
  final String turn;

  @override
  State<RouteTile> createState() => _RouteTileState();
}

class _RouteTileState extends State<RouteTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.005,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Container(
                color: widget.color,
                width: 10.0,
                height: widget.isExpanded
                    ? MediaQuery.of(context).size.height * 0.25
                    : MediaQuery.of(context).size.height * 0.08,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Main ${widget.routeName}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        CircleAvatar(
                          backgroundColor: widget.color,
                          radius: 5,
                        )
                      ],
                    ),
                    Text(
                      widget.routeDescription,
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey,
                      ),
                    ),
                    widget.isExpanded
                        ? Container(
                            padding: const EdgeInsets.all(
                              10.0,
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(
                                    widget.turn.contains('right')
                                        ? Icons.arrow_circle_right_outlined
                                        : Icons.arrow_circle_left_outlined,
                                    size: 80.0,
                                  ),
                                  Text(
                                    widget.distance,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  Html(
                                    data: widget.turn,
                                  ),
                                  //  Text(
                                  //   widget.turn,
                                  //   style: const TextStyle(
                                  //     fontSize: 18.0,
                                  //     color: Colors.grey,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              // Flexible(
              //   child: const ListTile(
              //     contentPadding: EdgeInsets.all(0),
              //     minVerticalPadding: 0,
              //     title: Text('Main Route'),
              //     subtitle: Text('Main Route'),
              //   ),
              // ),
            ],
          ),
        ),
      );

  }
}
