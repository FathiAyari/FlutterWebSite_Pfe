import 'package:flutter/material.dart';
import 'package:showroom_backend/temp/utils/content_view.dart';
import 'package:showroom_backend/temp/utils/tab_controller_handler.dart';
import 'package:showroom_backend/temp/utils/view_wrapper.dart';
import 'package:showroom_backend/temp/views/about_view.dart';
import 'package:showroom_backend/temp/views/home_view.dart';
import 'package:showroom_backend/temp/views/projects_view.dart';
import 'package:showroom_backend/temp/widgets/bottom_bar.dart';
import 'package:showroom_backend/temp/widgets/custom_tab.dart';
import 'package:showroom_backend/temp/widgets/custom_tab_bar.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:showroom_backend/views/login/login_screen.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  ItemScrollController itemScrollController;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  double screenHeight;
  double screenWidth;
  double topPadding;
  double bottomPadding;
  double sidePadding;

  List<ContentView> contentViews = [
    ContentView(
      tab: CustomTab(title: 'Home'),
      content: HomeView(),
    ),
    ContentView(
      tab: CustomTab(title: 'About'),
      content: AboutView(),
    ),

  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: contentViews.length, vsync: this);
    itemScrollController = ItemScrollController();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    topPadding = screenHeight * 0.05;
    bottomPadding = screenHeight * 0.03;
    sidePadding = screenWidth * 0.05;

    print('Width: $screenWidth');
    print('Height: $screenHeight');
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      endDrawer: drawer(),
      body: Padding(
        padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
        child:
        ViewWrapper(desktopView: desktopView(), mobileView: mobileView()),
      ),
    );
  }

  Widget desktopView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Tab Bar
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: Image.asset("assets/images/app_logo.png",
                height: 40,),


            ),

            Container(
              height: screenHeight * 0.05,
              child: CustomTabBar(
                  controller: tabController,
                  tabs: contentViews.map((e) => e.tab).toList()),
            ),
            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
            }, child: Text("Login")),

          ],
        ),

        /// Tab Bar View
        Container(
          height: screenHeight * 0.8,
          child: TabControllerHandler(
            tabController: tabController,
            child: TabBarView(
              controller: tabController,
              children: contentViews.map((e) => e.content).toList(),
            ),
          ),
        ),

        /// Bottom Bar
        BottomBar()
      ],
    );
  }

  Widget mobileView() {
    return Padding(
      padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
      child: Container(
        width: screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                iconSize: screenWidth * 0.08,
                icon: Icon(Icons.menu_rounded),
                color: Colors.blueAccent,
                splashColor: Colors.transparent,
                onPressed: () => scaffoldKey.currentState.openEndDrawer()),
            Expanded(
              child: ScrollablePositionedList.builder(
                scrollDirection: Axis.vertical,
                itemScrollController: itemScrollController,
                itemCount: contentViews.length,
                itemBuilder: (context, index) => contentViews[index].content,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget drawer() {
    return Container(
      width: screenWidth * 0.5,
      child: Drawer(
        child: ListView(
          children: [Container(height: screenHeight * 0.1)] +
              contentViews
                  .map((e) => Container(
                child: ListTile(
                  title: Text(
                    e.tab.title,
                    style: Theme.of(context).textTheme.button,
                  ),
                  onTap: () {
                    itemScrollController.scrollTo(
                        index: contentViews.indexOf(e),
                        duration: Duration(milliseconds: 300));
                    Navigator.pop(context);
                  },
                ),
              ))
                  .toList(),
        ),
      ),
    );
  }
}
