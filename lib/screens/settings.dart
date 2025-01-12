import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:samsung_note/widgets/flutter_advanced_switch.dart';

class SettingsWidget extends HookWidget {
  final Color textcolors;
  final Color backgroundColor;
  final Color containerColor;

  SettingsWidget({
    super.key,
    required this.textcolors,
    required this.backgroundColor,
    required this.containerColor,
  });

  // Heading reusability
  Widget buildCustomContainer({
    required String title,
    required Color backgroundColor,
    Color textColor = const Color(0xFF757575),
    double fontSize = 15.0,
    EdgeInsets padding = const EdgeInsets.only(left: 20, bottom: 5, top: 10),
  }) {
    return Container(
      padding: padding,
      color: backgroundColor,
      width: double.infinity, // Takes full width
      child: Text(
        title,
        style: TextStyle(color: textColor, fontSize: fontSize),
      ),
    );
  }

//

  final Widget divider = Container(
    margin: EdgeInsets.only(left: 10, right: 10),
    height: 1,
    color: Colors.grey[350],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          // HeaderSliver >>>>>>>>
          SliverAppBar(
            backgroundColor: backgroundColor,
            expandedHeight: 250,
            toolbarHeight: 10,
            pinned: true,
            // floating: true,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Center(
                      child: Text(
                        "Samsung Notes settings",
                        style: TextStyle(fontSize: 30, color: textcolors),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 5,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: textcolors,
                            ),
                          ),
                          Text(
                            "Samsung Notes settings",
                            style: TextStyle(fontSize: 20, color: textcolors),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // BodySliver >>>>>>>>>>>
          SliverToBoxAdapter(
            child: Column(
              children: [
                // for the heading title {1}
                buildCustomContainer(
                    title: "General", backgroundColor: backgroundColor),
                // Box container {1}
                Container(
                  decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        color: backgroundColor,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 200, top: 10),
                                child: Text(
                                  "Style of new notes",
                                  style: TextStyle(
                                      color: textcolors, fontSize: 18),
                                ),
                              ),
                            ),
                            divider,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10, bottom: 10),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Auto save notes",
                                      style: TextStyle(
                                          fontSize: 18, color: textcolors),
                                    ),
                                  ),
                                ),
                                Container(
                                    margin:
                                        EdgeInsets.only(right: 15, bottom: 8),
                                    child: FLutterSwitch()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // for the heading title {2}

                buildCustomContainer(
                    title: "Advanced", backgroundColor: backgroundColor),

                // Box container {2}
                Container(
                  decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        color: backgroundColor,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10, top: 10),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Show links in notes",
                                      style: TextStyle(
                                          fontSize: 18, color: textcolors),
                                    ),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                      right: 15,
                                    ),
                                    child: FLutterSwitch()),
                              ],
                            ),
                            divider,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextButton(
                                        onPressed: () {},
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Show web previews",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: textcolors),
                                            ),
                                            Text(
                                              "preview websites added from other apps.",
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 15,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                      right: 15,
                                    ),
                                    child: FLutterSwitch()),
                              ],
                            ),
                            divider,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 10,
                                  ),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Hide scroll bar when editing",
                                      style: TextStyle(
                                          fontSize: 18, color: textcolors),
                                    ),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                      right: 15,
                                    ),
                                    child: FLutterSwitch()),
                              ],
                            ),
                            divider,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 10,
                                  ),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Block Back button while editing",
                                      style: TextStyle(
                                          fontSize: 18, color: textcolors),
                                    ),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                      right: 15,
                                    ),
                                    child: FLutterSwitch()),
                              ],
                            ),
                            divider,
                            TextButton(
                              onPressed: () {},
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 215, top: 10, bottom: 10),
                                child: Text(
                                  "Toolbar add-ons",
                                  style: TextStyle(
                                      color: textcolors, fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // for the heading title{3}

                buildCustomContainer(
                    title: "Privacy", backgroundColor: backgroundColor),

                // Box container {3}
                Container(
                  decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        color: backgroundColor,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 230,
                                ),
                                child: Text(
                                  "Privacy Notice",
                                  style: TextStyle(
                                      color: textcolors, fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // space between two containers
                Container(
                  height: 20,
                  color: backgroundColor,
                ),
                //
                Container(
                  decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        color: backgroundColor,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Padding(
                                padding: const EdgeInsets.only(right: 200),
                                child: Text(
                                  "Style of new notes",
                                  style: TextStyle(
                                      color: textcolors, fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  color: backgroundColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
