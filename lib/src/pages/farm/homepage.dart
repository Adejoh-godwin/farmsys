import 'package:farmsys/src/pages/farm/topMenu.dart';
import 'package:farmsys/src/widgets/appbar.dart';
import 'package:farmsys/src/widgets/colors.dart';
import 'package:farmsys/src/widgets/drawer.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int curridx = 0;
  int check = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Bgcolor,
        appBar: appbar(),
        drawer: MyDrawer(),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              FarmHome(),
            ],
          ),
        ));
  }

  GestureDetector iconBtnAppbar(String iconpath, String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          curridx = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 3,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 9,
                fontWeight:
                    curridx == index ? FontWeight.w700 : FontWeight.w600,
                color: curridx == index ? GreenColor : BottomIcon),
          )
        ],
      ),
    );
  }
}

class FarmHome extends StatelessWidget {
  const FarmHome({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 17, bottom: 12),
        //height: 225,
        width: double.infinity,
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: <Widget>[
            GopayMenu(),
            Divider(
              height: 40,
              thickness: 1.5,
              indent: 30,
              endIndent: 30,
              color: Bgcolor,
            ),
            PromoBanner(
              iconpath: "assets/icons/logo.png",
              sizeicon: 15.0,
              imgpath: "assets/images/kyf.jpg",
              title: "Know Your Farmers",
              buttontext: "View",
              route: '/filterOnline',
            ),
            Divider(
              height: 35,
              thickness: 1.5,
              indent: 30,
              endIndent: 30,
              color: Bgcolor,
            ),
            PromoBanner(
              iconpath: "assets/icons/logo.png",
              imgpath: "assets/images/map.png",
              title: "Mapping",
              buttontext: "View",
              route: '/map',
            ),
            Divider(
              height: 35,
              thickness: 1.5,
              indent: 30,
              endIndent: 30,
              color: Bgcolor,
            ),
            PromoBanner(
              iconpath: "assets/icons/logo.png",
              //sizeicon: 15.0,
              imgpath: "assets/images/id.png",
              title: "Input Distribution",
              buttontext: "View",
              route: '/fliterdistribution',
            ),
            const SizedBox(height: 20.0),
            MaterialButton(
              elevation: 2,
              child: Text("Upload Details Online"),
              color: Colors.lightGreen,
              onPressed: () async {
                Navigator.pushNamed(context, '/offline');
              },
              textColor: Colors.white,
              padding: const EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PromoBanner extends StatelessWidget {
  final String imgpath;
  final String iconpath;
  final String title;
  final String buttontext;
  final sizeicon;
  final String route;
  const PromoBanner({
    Key key,
    this.imgpath,
    this.iconpath,
    this.title,
    this.buttontext,
    this.sizeicon,
    this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18),
      height: 167,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        image: DecorationImage(image: AssetImage(imgpath), fit: BoxFit.cover),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.transparent,
                  Colors.black.withOpacity(0.6),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 16,
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.white, fontSize: 14),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 18,
            child: RaisedButton(
              color: Colors.lightGreen,
              textColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text("view"),
              onPressed: () {
                Navigator.pushNamed(context, route);
              },
            ),
          )
        ],
      ),
    );
  }
}
