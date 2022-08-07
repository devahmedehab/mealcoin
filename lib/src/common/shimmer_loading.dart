import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/style/k_size.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListLoading extends StatelessWidget {
  const ShimmerListLoading({
    Key? key,
    required this.count,
    required this.height,
  }) : super(key: key);

  final double height;
  final int count;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: count,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300.withOpacity(0.5),
                highlightColor: Colors.grey.shade100,
                loop: 80,
                child: Container(
                  height: height,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300.withOpacity(0.5),
                highlightColor: Colors.grey.shade100,
                loop: 80,
                child: Container(
                  height: 15,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

class ShimmerGridLoading extends StatelessWidget {
  const ShimmerGridLoading({
    Key? key,
    required double height,
    required this.count,
  })  : _height = height,
        super(key: key);

  final double _height;
  final int count;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: count,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300.withOpacity(0.5),
              highlightColor: Colors.grey.shade100,
              loop: 100,
              child: Container(
                height: 125,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300.withOpacity(0.5),
                highlightColor: Colors.grey.shade100,
                loop: 100,
                child: Container(
                  height: 25,
                  width: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

class ProfileLoading extends StatelessWidget {
  const ProfileLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppCustomColors.primaryColor,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300.withOpacity(0.5),
                highlightColor: Colors.grey.shade100,
                loop: 100,
                child: CircleAvatar(
                  radius: 45,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Column(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300.withOpacity(0.5),
                    highlightColor: Colors.grey.shade100,
                    loop: 80,
                    child: Container(
                      width: 100,
                      height: 25,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300.withOpacity(0.5),
                    highlightColor: Colors.grey.shade100,
                    loop: 80,
                    child: Container(
                      width: 100,
                      height: 25,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300.withOpacity(0.5),
                    highlightColor: Colors.grey.shade100,
                    loop: 80,
                    child: Container(
                      width: 100,
                      height: 25,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 22,
          ),
        ],
      ),
    );
  }
}

class HeadingValueLoading extends StatelessWidget {
  const HeadingValueLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230.0,
      width: 230.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(15.0),
              child: Image.asset(
                'assets/icons/chefs_heart_white_background.gif',
                height: 60,
                width: 60,
              )),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Loading'.toUpperCase(),
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileMenuLoading extends StatelessWidget {
  const ProfileMenuLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300.withOpacity(0.5),
            highlightColor: Colors.grey.shade100,
            loop: 100,
            child: Container(
              height: KSize.getHeight(context, 36),
              width: double.infinity,
              color: Colors.white,
              //padding: EdgeInsets.all(6),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300.withOpacity(0.5),
            highlightColor: Colors.grey.shade100,
            loop: 80,
            child: Container(
              height: KSize.getHeight(context, 36),
              width: double.infinity,
              color: Colors.white,
              //padding: EdgeInsets.all(6),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300.withOpacity(0.5),
            highlightColor: Colors.grey.shade100,
            loop: 80,
            child: Container(
              height: KSize.getHeight(context, 36),
              width: double.infinity,
              color: Colors.white,
              // padding: EdgeInsets.all(6),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300.withOpacity(0.5),
            highlightColor: Colors.grey.shade100,
            loop: 80,
            child: Container(
              height: KSize.getHeight(context, 36),
              width: double.infinity,
              color: Colors.white,
              //padding: EdgeInsets.all(6),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300.withOpacity(0.5),
            highlightColor: Colors.grey.shade100,
            loop: 80,
            child: Container(
              height: KSize.getHeight(context, 36),
              width: double.infinity,
              color: Colors.white,
              // padding: EdgeInsets.all(6),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300.withOpacity(0.5),
            highlightColor: Colors.grey.shade100,
            loop: 80,
            child: Container(
              height: KSize.getHeight(context, 36),
              width: double.infinity,
              color: Colors.white,
              //padding: EdgeInsets.all(6),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300.withOpacity(0.5),
            highlightColor: Colors.grey.shade100,
            loop: 80,
            child: Container(
              height: KSize.getHeight(context, 36),
              width: double.infinity,
              color: Colors.white,
              // padding: EdgeInsets.all(6),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300.withOpacity(0.5),
            highlightColor: Colors.grey.shade100,
            loop: 80,
            child: Container(
              height: KSize.getHeight(context, 36),
              width: double.infinity,
              color: Colors.white,
              //padding: EdgeInsets.all(6),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300.withOpacity(0.5),
            highlightColor: Colors.grey.shade100,
            loop: 80,
            child: Container(
              height: KSize.getHeight(context, 36),
              width: double.infinity,
              color: Colors.white,
              //  padding: EdgeInsets.all(6),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300.withOpacity(0.5),
            highlightColor: Colors.grey.shade100,
            loop: 80,
            child: Container(
              height: KSize.getHeight(context, 36),
              width: double.infinity,
              color: Colors.white,
              //padding: EdgeInsets.all(6),
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingListPage extends StatefulWidget {
  @override
  _LoadingListPageState createState() => _LoadingListPageState();
}

class _LoadingListPageState extends State<LoadingListPage> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade600,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Shimmer.fromColors(
               /* baseColor: Colors.black12,
                highlightColor: Colors.grey,*/
                baseColor: Colors.grey.shade300.withOpacity(0.5),
                highlightColor: Colors.grey.shade100,
                enabled: _enabled,
                child: ListView.builder(
                  itemBuilder: (_, __) => Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 55.0,
                          height: 55.0,
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                height: 8.0,
                                color: Colors.white,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 3.0),
                              ),
                              Container(
                                width: 150,
                                height: 8.0,
                                color: Colors.white,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 3.0),
                              ),
                              Container(
                                width: double.infinity,
                                height: 13.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  //itemCount: 6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
