import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/common/reusableComponents/textWidget.dart';
import 'package:chefsandmeals_customer/src/models/requests/get_product_medias_request.dart';
import 'package:chefsandmeals_customer/src/models/responses/get_product_reviews_response.dart';
import 'package:chefsandmeals_customer/src/models/responses/product_response.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/cart/controller/cartController.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/cart/view/cartScreen.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/cart/view/direct_checkout_page.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/hubProfile/controller/landing_page_controller.dart';
import 'package:chefsandmeals_customer/src/modules/restaurant/productProfile/controllers/product_profile_controller.dart';
import 'package:chefsandmeals_customer/src/modules/userManagement/userSignIn/view/widget/signIn/signIn_screen.dart';

import '../../../../models/requests/get_product_reviews_request.dart';

class ProductProfileScreen extends StatefulWidget {
  final ProductResult product;

  const ProductProfileScreen({Key? key, required this.product})
      : super(key: key);

  @override
  _ProductProfileScreenState createState() => _ProductProfileScreenState();
}

class _ProductProfileScreenState extends State<ProductProfileScreen> {
  final ProductProfileController _controller =
      Get.put(ProductProfileController());
  int _productCount = 1;
  int _current = 0;
  bool descriptionSelected = true;
  bool reviewSelected = false;
  final CarouselController _carouselController = CarouselController();

  final _imageList = <String?>[];
  final _reviews = <ProductReview>[];

  @override
  void initState() {
    super.initState();

    _controller
        .getProductMedias(
            GetProductMediasRequest(productId: widget.product.productId!))
        .then((value) {
      final imageList = value.result?.map((e) => e.picture).toList();

      setState(() {
        _imageList.assignAll(imageList!);
      });
    });

    _controller
        .getProductReviews(GetProductReviewsRequest(
      productIdFilter: widget.product.productId!,
      skipCount: 0,
      isPublish: 1,
      maxResultCount: 20,
    ))
        .then((value) {
      setState(() {
        if (value.productReviews != null) {
          _reviews.assignAll(value.productReviews!);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Material(
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  height: _height / 8,
                ),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox(
                        height: 220,
                        width: _width,
                        child: CarouselSlider(
                          carouselController: _carouselController,
                          options: CarouselOptions(
                              autoPlay: false,
                              enlargeCenterPage: true,
                              viewportFraction: 1,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              }),
                          items: _imageList.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: _width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14)),
                                  child: Image.asset(
                                    i!,
                                    fit: BoxFit.fitWidth,
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _imageList.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () =>
                              _carouselController.animateToPage(entry.key),
                          child: Container(
                            width: 12.0,
                            height: 12.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.white)
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    widget.product.productName ?? '',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      decoration: TextDecoration.none,
                      fontSize: 20,
                      color: AppCustomColors.blackColor,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      width: (_width / 3) * 1.8,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  'Regular Price',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    decoration: TextDecoration.none,
                                    fontSize: 18,
                                    color: AppCustomColors.greyTextColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                child: Text(
                                  '\$${widget.product.regularPrice! * _productCount}',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    decoration: TextDecoration.none,
                                    fontSize: 18,
                                    color: AppCustomColors.greyTextColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          widget.product.salesPrice != null
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Sale Price',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          decoration: TextDecoration.none,
                                          fontSize: 18,
                                          color: AppCustomColors.greyTextColor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        '\$${widget.product.salesPrice! * _productCount}',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          decoration: TextDecoration.none,
                                          fontSize: 18,
                                          color: AppCustomColors.greyTextColor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                          SizedBox(
                            height: 16,
                          ),
                          widget.product.membershipTypeName != null
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        '${widget.product.membershipTypeName}',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          decoration: TextDecoration.none,
                                          fontSize: 18,
                                          color: AppCustomColors.greyTextColor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        '\$${widget.product.membershipPrice! * _productCount}',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          decoration: TextDecoration.none,
                                          fontSize: 18,
                                          color: AppCustomColors.greyTextColor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                )
                              : Container()
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        width: (_width / 3) * 1.2,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: _width / 4,
                                    height: _width / 16,
                                    decoration: BoxDecoration(
                                        color: AppCustomColors.containerBgColor,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Text(
                                      '$_productCount',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        decoration: TextDecoration.none,
                                        fontSize: _width / 22,
                                        color: AppCustomColors.blackColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (_productCount > 1) {
                                            setState(() {
                                              _productCount--;
                                            });
                                          }
                                        });
                                      },
                                      child: Container(
                                        width: _width / 16,
                                        height: _width / 16,
                                        decoration: BoxDecoration(
                                            color: AppCustomColors.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '-',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              decoration: TextDecoration.none,
                                              fontSize: _width / 22,
                                              color: AppCustomColors.whiteColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _productCount++;
                                        });
                                      },
                                      child: Container(
                                        width: _width / 16,
                                        height: _width / 16,
                                        decoration: BoxDecoration(
                                            color: AppCustomColors.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: Text(
                                          '+',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            decoration: TextDecoration.none,
                                            fontSize: _width / 22,
                                            color: AppCustomColors.whiteColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              InkWell(
                                onTap: () async {
                                  final cartController =
                                      Get.put(CartController());
                                  final landingController =
                                      Get.put(LandingPageController());
                                  await cartController.getContactId();
                                  if (cartController.contactId.value > 0) {
                                    await cartController.getAllCart();
                                    if (cartController.cartList.length > 0) {
                                      if (cartController
                                              .cartList.first.storeId ==
                                          widget.product.storeId) {
                                        await landingController
                                            .addProductToCart(
                                                widget.product.productId!,
                                                widget.product.storeId!);
                                        Get.to(() => AddToCartScreen());
                                      } else {
                                        Get.defaultDialog(
                                          title: "Alert!",
                                          content: Text(
                                              "Do you want to Delete Existing cart item?"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: Text("NO")),
                                            TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                  Get.to(
                                                      () => AddToCartScreen());
                                                },
                                                child: Text("YES")),
                                          ],
                                        );
                                      }
                                    } else {
                                      await landingController.addProductToCart(
                                          widget.product.productId!,
                                          widget.product.storeId!);
                                      Get.to(() => AddToCartScreen());
                                    }
                                  } else {
                                    Get.to(() => SignInScreen());
                                  }
                                },
                                child: Container(
                                  width: _width / 4,
                                  height: _width / 16,
                                  decoration: BoxDecoration(
                                      color: AppCustomColors.primaryColor,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Text(
                                    'Add To Cart',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      decoration: TextDecoration.none,
                                      fontSize: _width / 26,
                                      color: AppCustomColors.whiteColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ]))
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Divider(
                  color: AppCustomColors.greyTextColor,
                  thickness: 1.5,
                ),
                SizedBox(
                  height: 8,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              descriptionSelected = true;
                              reviewSelected = false;
                            });
                          },
                          child: Text(
                            'Description',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              decoration: TextDecoration.none,
                              fontSize: descriptionSelected
                                  ? _width / 24
                                  : _width / 28,
                              color: descriptionSelected
                                  ? AppCustomColors.primaryColor
                                  : AppCustomColors.greyTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: _width / 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              descriptionSelected = false;
                              reviewSelected = true;
                            });
                          },
                          child: Text(
                            'Review',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              decoration: TextDecoration.none,
                              fontSize:
                                  reviewSelected ? _width / 24 : _width / 28,
                              color: reviewSelected
                                  ? AppCustomColors.primaryColor
                                  : AppCustomColors.greyTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Container(
                          width: _width / 2,
                          height: descriptionSelected ? 3 : 2,
                          color: descriptionSelected
                              ? AppCustomColors.primaryColor
                              : AppCustomColors.greyTextColor,
                        ),
                        Container(
                          width: _width / 2,
                          height: reviewSelected ? 3 : 2,
                          color: reviewSelected
                              ? AppCustomColors.primaryColor
                              : AppCustomColors.greyTextColor,
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                descriptionSelected
                    ? Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          widget.product.shortDescription ?? '',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            decoration: TextDecoration.none,
                            fontSize: _width / 28,
                            color: AppCustomColors.greyTextColor,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 1000,
                        ),
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text(
                              widget.product.shortDescription ?? "",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                decoration: TextDecoration.none,
                                fontSize: _width / 28,
                                color: AppCustomColors.greyTextColor,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 1000,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Divider(
                            color: AppCustomColors.greyTextColor,
                            thickness: 1.5,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: _reviews.length,
                                itemBuilder: (context, index) {
                                  print(_reviews[index].productId);
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            _reviews[index].contactName,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              decoration: TextDecoration.none,
                                              fontSize: reviewSelected
                                                  ? _width / 24
                                                  : _width / 28,
                                              color: reviewSelected
                                                  ? AppCustomColors.primaryColor
                                                  : AppCustomColors
                                                      .greyTextColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            _reviews[index].postDate,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              decoration: TextDecoration.none,
                                              fontSize: _width / 28,
                                              color:
                                                  AppCustomColors.greyTextColor,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 4),
                                              decoration: BoxDecoration(
                                                  color: AppCustomColors
                                                      .primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: customTextWidget(
                                                    _reviews[index]
                                                        .ratingScore
                                                        .toString(),
                                                    _width / 28,
                                                    FontWeight.w600,
                                                    AppCustomColors.whiteColor),
                                              )),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          RatingBar.builder(
                                            initialRating: 4.2,
                                            itemSize: _width / 14,
                                            maxRating: 5,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount:
                                                _reviews[index].ratingLikeId,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 1.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Container(
                                        child: Text(
                                          _reviews[index].storeName,
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            decoration: TextDecoration.none,
                                            fontSize: _width / 28,
                                            color:
                                                AppCustomColors.greyTextColor,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          maxLines: 1000,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Container(
                                        width: _width,
                                        child: Text(
                                          _reviews[index].postDate,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            decoration: TextDecoration.none,
                                            fontSize: _width / 28,
                                            color:
                                                AppCustomColors.greyTextColor,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          maxLines: 1000,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Divider(
                                        color: AppCustomColors.greyTextColor,
                                        thickness: 1,
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ],
                      )
              ],
            ),
            Positioned(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              height: _height / 7.5,
              color: AppCustomColors.primaryColor,
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                //Utils.navigateToPage(context, LandingScreen(), 250, true);
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_rounded,
                                color: AppCustomColors.whiteColor,
                              )),
                          customTextWidget("Item Details", _width / 20,
                              FontWeight.w400, AppCustomColors.whiteColor),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
