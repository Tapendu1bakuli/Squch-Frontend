import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:squch/core/common/common_button.dart';
import 'package:squch/core/common/common_text_form_field.dart';
import 'package:squch/core/utils/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sizing/sizing.dart';
import 'package:squch/core/utils/app_strings.dart';
import 'package:squch/core/utils/image_utils.dart';
import 'package:squch/core/widgets/horizontal_gap.dart';
import 'package:squch/features/home_page_feature/data/models/top_menu_list_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:squch/features/home_page_feature/presentation/controller/home_controller.dart';
import 'package:squch/features/map_page_feature/presentation/controller/map_controller.dart';
import '../../../../core/common/see_all_button.dart';
import '../../../../core/place_service/AddressSearch.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/place_service/place_provider.dart';
import '../../../../core/service/page_route_service/routes.dart';
import '../../../../core/utils/const.dart';
import '../../../../core/utils/fonts.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../map_page_feature/presentation/search_ride.dart';
class HomeTab extends StatefulWidget {
   HomeTab({super.key});
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab>  with TickerProviderStateMixin {

  List<TopMenuListModel> topMenuList =[
  TopMenuListModel(icon: ImageUtils.topup,label:"Top-Up"),
  TopMenuListModel(icon:ImageUtils.request,label:"Request"),
  TopMenuListModel(icon:ImageUtils.pay,label:"Pay"),
  TopMenuListModel(icon:ImageUtils.rewards,label:"Rewards"),
  TopMenuListModel(icon:ImageUtils.more,label:"More")];
  late TabController tabController;
  


  CarouselController _controller = new CarouselController();
  CarouselController _controllerEvents = new CarouselController();
  int _current = 0;
  int _currentEvent = 0;
  final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
HomeController _homeController = Get.find();
  @override
  void initState() {

    _homeController.getUserData();
    tabController = new TabController(length: 5, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return  Obx(()=>
      Container(
      decoration: BoxDecoration(
        color: AppColors.colorlightgrey
      ),
      padding: EdgeInsets.only(top: 5.ss),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.ss),
            child: Column(
              children: [
                SizedBox(height: 10.ss,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      CircleAvatar(
                        backgroundColor: AppColors.colorWhite,
                        maxRadius: 20,
                        child:
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: CachedNetworkImage(
                            imageUrl: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8YXZhdGFyfGVufDB8fDB8fHww",
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    colorFilter:
                                    ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
                              ),
                            ),
                            placeholder: (context, url) => CircularProgressIndicator( ),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                      ),
                      SizedBox(width: 5.ss,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                             AppStrings.Hi.tr+_homeController.userName.value,
                            style: CustomTextStyle(
                                fontSize: 14.fss,
                                fontWeight: FontWeight.w700
                            ),overflow: TextOverflow.clip,
                          ),

                          Text(
                            AppStrings.GoodMorning.tr,
                            style: CustomTextStyle(
                                fontSize: 10.fss
                            ),overflow: TextOverflow.clip,
                          ),
                        ],
                      )
                    ],),
                    Row(children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.ss,vertical: 10.ss),
                        decoration: BoxDecoration(
                            color: AppColors.colorWhite,
                            borderRadius: BorderRadius.all(Radius.circular(14.ss))
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(ImageUtils.walletOutline,color: AppColors.titleColor,),
                            SizedBox(width: 10.ss,),
                            Text(
                              "\$ 300",
                              style: CustomTextStyle(
                                  fontSize: 14.fss,
                                  fontWeight: FontWeight.w800
                              ),overflow: TextOverflow.clip,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.ss,),
                      Container(
                        height: 40.ss,
                        width: 40.ss,
                        decoration: BoxDecoration(
                            color: AppColors.colorWhite,
                            shape: BoxShape.circle
                        ),
                        child: SvgPicture.asset(ImageUtils.notificationOutline,fit: BoxFit.scaleDown,height: 20.ss,width: 20.ss,),
                      )
                    ],)
                  ],
                ),
                SizedBox(height: 20.ss,),

                Container(
                //  padding: EdgeInsets.symmetric(horizontal: 5.ss),
                  decoration: BoxDecoration(
                      color: AppColors.colorWhite,
                      borderRadius: BorderRadius.all(Radius.circular(14.ss))
                  ),
                  child: Row(
                    children: [
                      CommonTextFormField(
                        //controller: _homeController.searchController,
                        margin:  10.ss,
                        padding: 0.ss,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: AppStrings.SearchHint.tr,
                          hintStyle: CustomTextStyle(color: Theme.of(context).brightness != Brightness.dark?
                          Colors.black87 : Colors.white),
                          // isCollapsed: true,
                          prefixIcon: Container(
                            margin: EdgeInsets.symmetric(horizontal: 12.ss),
                            child: SvgPicture.asset(
                                ImageUtils.hometTabSearchFieldSearchIcon),
                          )
                          //prefixIcon: Icon(Icons.search,color: AppColors.titleColor.withOpacity(0.3),),
                        ),
                        width: size.width*5.8/8,
                        onTap: () async{
                          // generate a new token here
                          final sessionToken = Uuid().v4();
                          final Suggestion result = (await showSearch(
                            context: context,
                            delegate: AddressSearch(_homeController.placeApiProvider),
                          )) as Suggestion;
                          // This will change the text displayed in the TextField
                          if (result != null) {
                            final placeDetails = await PlaceApiProvider(sessionToken)
                                .getPlaceDetailFromId(result.placeId);
                          }
                        },
                      ),
                      Container(height: 30.ss,width: 0.5.ss,color: AppColors.titleColor.withOpacity(0.3),margin: EdgeInsets.symmetric(horizontal: 5.ss),),

                      SvgPicture.asset(ImageUtils.microphone)
                    ],
                  ),
                ),
                SizedBox(height: 10.ss,)
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  SizedBox(height: 10.ss,),
                  Container(
                    height: 80.ss,
                    margin: EdgeInsets.only(bottom: 20.ss),
                    padding: EdgeInsets.symmetric(horizontal: 10.ss),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: topMenuList.length,
                              itemBuilder: (context,index){
                                return InkWell(
                                  onTap: (){
                                    if(index == 0){
                                      _homeController.placeApiProvider.fetchSuggestions(_homeController.searchController.text,_homeController.selectedLanguage.value.id);
                                    }
                                  },
                                  child: Column(

                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 5.ss),
                                        width: size.width/6.5,
                                        height: 50.ss,
                                        decoration: BoxDecoration(
                                            color: index == 0? AppColors.bottomNavigationSelectedColor : AppColors.colorWhite,
                                            borderRadius: BorderRadius.all(Radius.circular(16.ss))
                                        ),
                                        child: SvgPicture.asset(topMenuList[index].icon??"",color: index == 0? AppColors.colorWhite : AppColors.titleColor,fit: BoxFit.scaleDown),
                                      ),
                                      SizedBox(height: 5.ss,),
                                      Text(topMenuList[index].label??"",
                                        style: CustomTextStyle(
                                            fontSize: 14.fss,
                                            fontWeight: FontWeight.w500
                                        ),overflow: TextOverflow.clip,)
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                  Wrap(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 75.ss,
                            decoration: BoxDecoration(
                              color:  AppColors.colorInviteFriendHome,

                              borderRadius:  BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 50.ss,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.ss,vertical: 20.ss),
                              width: size.width,
                              decoration: BoxDecoration(
                                color:  AppColors.colorWhite,
                                borderRadius:  BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                ),
                              ),

                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 30.ss,vertical: 10.ss),
                            child: Row(
                              children: [
                                SvgPicture.asset(ImageUtils.loudSpeaker),
                                HorizontalGap(8),
                                Text(AppStrings.InviteFriend.tr,style: CustomTextStyle(
                                    fontSize: 12.fss,
                                    fontWeight: FontWeight.w500
                                ),overflow: TextOverflow.clip,
                                  textAlign: TextAlign.center,),
                                Spacer(),
                                SvgPicture.asset(ImageUtils.rightArrow),
                              ],
                            ),
                          )

                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: size.width,
                    padding: EdgeInsets.symmetric(horizontal: 20.ss),
                    decoration: const BoxDecoration(
                      color:  AppColors.colorWhite,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppStrings.ExploreSquch.tr,
                          style: CustomTextStyle(
                              fontSize: 18.fss,
                              fontWeight: FontWeight.w800
                          ),overflow: TextOverflow.clip,),
                        SizedBox(height: 20.ss,),
                        Container(
                          height: 85.ss,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              InkWell(onTap: (){
                                MapController _mapController = Get.find();
                                _mapController.routeList.clear();
                                _mapController.stoppageList.clear();
                                _mapController.numberOfTextFields.value =0;
                                _mapController.textEditingControllers.clear();
                                Get.toNamed(Routes.SEARCH_RIDE);
                              },child: HomeWidgetBigContainer("Ride","16 min",ImageUtils.ride,size)),
                              SizedBox(width: 20.ss,),
                              HomeWidgetBigContainer("Grocery","10 min",ImageUtils.grocery,size),

                            ],
                          ),
                        ),
                        SizedBox(height: 20.ss,),
                        Container(
                          height: 125.ss,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              HomeWidgetSmallContainer(AppStrings.Foods.tr,"25 min",ImageUtils.foods,size),
                              SizedBox(width: 10.ss,),
                              HomeWidgetSmallContainer(AppStrings.BuyAndSell.tr,"10 min",ImageUtils.buyAndSell,size),
                              SizedBox(width: 10.ss,),
                              HomeWidgetSmallContainer(AppStrings.Stay.tr,"200 m",ImageUtils.stay,size),
                              SizedBox(width: 10.ss,),
                              HomeWidgetSmallContainer(AppStrings.Events.tr,"16 min",ImageUtils.events,size),

                            ],
                          ),
                        ),
                        SizedBox(height: 20.ss,),
                        Container(

                          height: 150.ss,
                          width: size.width-60,
                          child:
                         /* ListView.builder(
                            addAutomaticKeepAlives: true,
                            scrollDirection: Axis.horizontal,
                              itemCount: 10,
                              itemBuilder: (context,index){
                            return Container(
                              height: 150.ss,
                              width: size.width-60,
                              margin: EdgeInsets.only(right: 10.ss),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10.ss)),
                                color: AppColors.colorDeepGreen,
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                      right: 0,
                                      top: 10.ss,
                                      child: Image.asset(ImageUtils.car)),
                                  Positioned(
                                      left: 20.ss,
                                      top: 10.ss,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Ready? then let’s \nroll.",
                                            style: CustomTextStyle(
                                                fontSize: 18.fss,
                                                color: AppColors.colorWhite,
                                                fontWeight: FontWeight.w800
                                            ),
                                            overflow: TextOverflow.clip,),

                                          SizedBox(height: 50.ss,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text("Ride Now",
                                                style: CustomTextStyle(
                                                    fontSize: 14.fss,
                                                    color: AppColors.colorWhite,
                                                    fontWeight: FontWeight.w800
                                                ),
                                                overflow: TextOverflow.clip,),
                                              Icon(Icons.arrow_forward_rounded,color: AppColors.colorWhite,size: 14.ss,)
                                            ],
                                          )
                                        ],
                                      )),

                                ],
                              ),
                            );
                          }),*/

                           Column(children: [
                            Expanded(
                              child: CarouselSlider.builder(
                                carouselController: _controller,
                                itemCount: 6,
                                itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                                    Container(
                                      height: 200.ss,
                                      width: size.width*1.8/2,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10.ss)),
                                        color: AppColors.colorDeepGreen,
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                              right: 0,
                                              top: 10.ss,
                                              child: Image.asset(ImageUtils.car)),
                                          Positioned(
                                              left: 20.ss,
                                              top: 10.ss,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Ready? then let’s \nroll.",
                                                    style: CustomTextStyle(
                                                        fontSize: 18.fss,
                                                        color: AppColors.colorWhite,
                                                        fontWeight: FontWeight.w800
                                                    ),
                                                    overflow: TextOverflow.clip,),

                                                  SizedBox(height: 50.ss,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Text("Ride Now",
                                                        style: CustomTextStyle(
                                                            fontSize: 14.fss,
                                                            color: AppColors.colorWhite,
                                                            fontWeight: FontWeight.w800
                                                        ),
                                                        overflow: TextOverflow.clip,),
                                                      Icon(Icons.arrow_forward_rounded,color: AppColors.colorWhite,size: 14.ss,)
                                                    ],
                                                  )
                                                ],
                                              )),

                                        ],
                                      ),
                                    ), options: CarouselOptions(
                                  aspectRatio: 16/6,
                                  viewportFraction: 1,
                                  initialPage: 0,
                                  enableInfiniteScroll: false, // (1) Set to false
                                  reverse: false,
                                  autoPlay: true,
                                  autoPlayInterval: Duration(seconds: 3),
                                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enlargeCenterPage: true,
                                  enlargeFactor: 0.3,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _current = index;
                                    });
                                  }),
                              )
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: imgList.asMap().entries.map((entry) {
                                return GestureDetector(
                                   onTap: () => _controller.animateToPage(entry.key),
                                  child: Container(
                                    width: 8.0.ss,
                                    height: 8.0.ss,
                                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: (Theme.of(context).brightness == Brightness.dark
                                            ? Colors.white
                                            : Colors.black)
                                       .withOpacity(_current == entry.key ? 0.9 : 0.4)
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ]),
                        ),
                       /* Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: imgList.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () => _controller.animateToPage(entry.key),
                              child: Container(
                                width: 8.0.ss,
                                height: 8.0.ss,
                                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                        .withOpacity(_current == entry.key ? 0.9 : 0.4)
                                ),
                              ),
                            );
                          }).toList(),
                        ),*/
                        SizedBox(height: 20.ss,),
                        Text(AppStrings.PopularEvent.tr,
                          style: CustomTextStyle(
                              fontSize: 18.fss,
                              fontWeight: FontWeight.w700
                          ),overflow: TextOverflow.clip,),

                        TabBar(
                          isScrollable: true,
                          automaticIndicatorColorAdjustment: true,
                          controller: tabController ,
                          labelColor: AppColors.titleColor,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: AppColors.indicatorColor,
                          overlayColor: MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered))
                                return Colors.amberAccent; //<-- SEE HERE
                              return null;
                            },
                          ),
                          tabs: [
                            Tab(child: Text("California",style: CustomTextStyle(
                              color: AppColors.indicatorColor,
                            fontSize: 13.fss,
                            fontWeight: FontWeight.w700
                        ),overflow: TextOverflow.clip,)),
                            Tab(child: Text("Texas")),
                            Tab(child: Text( "Florida",)),
                            Tab(child: Text( "Virgina",)),
                            Tab(child: Text("Hawai"),),
                          ],
                          onTap: (index){
                            // _currentEvent = 0;
                            //  _controller.animateToPage(0);
                            setState(() {
                            });
                          },
                        ),
                        SizedBox(height: 20.ss,),
                        Container(
                          height: 250.ss,
                          width: size.width,
                          child:  Column(children: [
                            Expanded(
                              child:
                              CarouselSlider.builder(

                                carouselController: _controllerEvents,
                                itemCount: 6,
                                itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                                    Container(
                                      height: 250.ss,
                                      width: size.width*1.8/2,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10.ss)),
                                       image: DecorationImage(image: AssetImage(ImageUtils.eventItem),fit: BoxFit.cover)
                                      ),
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 250.ss,
                                            width: size.width*1.8/2,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,

                                              children: [
                                                Text("CRICKET",
                                                  style: CustomTextStyle(
                                                      fontSize: 24.fss,
                                                      color: AppColors.colorWhite,
                                                      fontWeight: FontWeight.w800
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow.clip,),
                                                SizedBox(height: 10.ss,),
                                                Text("Fiesta",
                                                  style: CustomTextStyle(
                                                      fontSize: 16.fss,
                                                      color: AppColors.colorWhite,
                                                      fontWeight: FontWeight.w800
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow.clip,),
                                                SizedBox(height: 10.ss,),
                                                Text("Lorem Ipsum is simply dummy text and typesetting industry.",
                                                  style: CustomTextStyle(
                                                      fontSize: 12.fss,
                                                      color: AppColors.colorWhite,
                                                      fontWeight: FontWeight.w800
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow.clip,),
                                                SizedBox(height: 10.ss,),

                                                Container(
                                                  padding: EdgeInsets.symmetric(vertical: 5.ss,horizontal: 10.ss),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(10.ss)),
                                                    border: Border.all(width: 0.5.ss,color: AppColors.colorWhite)
                                                  ),
                                                  child: Wrap(
                                                    crossAxisAlignment: WrapCrossAlignment.center,
                                                    children: [
                                                      Text('View Match',
                                                        style: CustomTextStyle(
                                                            fontSize: 12.fss,
                                                            color: AppColors.colorWhite,
                                                            fontWeight: FontWeight.w800
                                                        ),
                                                        textAlign: TextAlign.center,
                                                        overflow: TextOverflow.clip,
                                                      ),
                                                      SizedBox(width: 10.ss,),
                                                      Icon(
                                                        Icons.arrow_forward_rounded,
                                                        size: 16.0,
                                                        color: AppColors.colorWhite,
                                                      )
                                                    ],
                                                  ),
                                                )


                                              ],
                                            ),
                                          )

                                        ],
                                      ),
                                    ),
                                options: CarouselOptions(
                                  aspectRatio: 2.0,
                                  padEnds: false,
                                  initialPage: 0,
                                  enableInfiniteScroll: false, // (1) Set to false
                                  reverse: false,
                                  autoPlay: false,
                                  autoPlayInterval: Duration(seconds: 3),
                                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enlargeCenterPage: true,
                                ),
                              )
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: imgList.asMap().entries.map((entry) {
                                return GestureDetector(
                                  onTap: () => _controllerEvents.animateToPage(entry.key),
                                  child: Container(
                                    width: 8.0.ss,
                                    height: 8.0.ss,
                                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: (Theme.of(context).brightness == Brightness.dark
                                            ? Colors.white
                                            : Colors.black)
                                            .withOpacity(_currentEvent == entry.key ? 0.9 : 0.4)
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ]),
                        ),
                        SizedBox(height: 20.ss,),
                        Row(
                          children: [
                            Text(AppStrings.RecommendedRestaurant.tr,
                              style: CustomTextStyle(
                                  fontSize: 18.fss,
                                  fontWeight: FontWeight.w800
                              ),
                              overflow: TextOverflow.clip,),
                            Spacer(),
                            SeeAllButton(onTap: (){},),
                          ],
                        ),
                        SizedBox(height: 20.ss,),
                        Container(
                          height: 38.ss,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                              itemCount: recomendedResturantsCategory.length,
                              itemBuilder: (context,index){
                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5.ss),
                                  decoration: BoxDecoration(
                                    color: index ==0? AppColors.bottomNavigationSelectedColor :AppColors.colorlightgrey1,
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 10.ss,vertical: 5.ss),
                                  child: Center(child: Text(recomendedResturantsCategory[index]["label"].toString(),
                                    style: CustomTextStyle(
                                      color:  index ==0? AppColors.colorWhite: Colors.black,
                                        fontSize: 12.fss,
                                        fontWeight: FontWeight.w400
                                    ),
                                    overflow: TextOverflow.clip,)),
                                );
                              }
                          ),
                        ),
                        SizedBox(height: 20.ss,),
                        Container(
                          height: 250.ss,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context,index){
                                return RecomendedResturentCard(size);
                              }
                          ),
                        ),
                        SizedBox(height: 20.ss,),
                        Row(
                          children: [
                            Text(AppStrings.DealsonGrocery.tr,
                              style: CustomTextStyle(
                                  fontSize: 18.fss,
                                  fontWeight: FontWeight.w800
                              ),
                              overflow: TextOverflow.clip,),
                            Spacer(),
                            SeeAllButton(onTap: (){},),
                          ],
                        ),
                        SizedBox(height: 20.ss,),
                        Container(
                          height: 250.ss,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context,index){
                                return DealsOnGroceryCard(size);
                              }
                          ),
                        ),
                        SizedBox(height: 20.ss,),
                        Row(
                          children: [
                            Text(AppStrings.BesttoDineIn.tr,
                              style: CustomTextStyle(
                                  fontSize: 18.fss,
                                  fontWeight: FontWeight.w800
                              ),
                              overflow: TextOverflow.clip,),
                            Spacer(),
                            SeeAllButton(onTap: (){},),
                          ],
                        ),
                        SizedBox(height: 20.ss,),
                        Container(
                          height: 280.ss,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context,index){
                                return BestDealInCard(size);
                              }
                          ),
                        ),
                        SizedBox(height: 20.ss,),
                        Text(AppStrings.TopDestinations.tr,
                          style: CustomTextStyle(
                              fontSize: 18.fss,
                              fontWeight: FontWeight.w800
                          ),overflow: TextOverflow.clip,),
                        SizedBox(height: 14.ss,),
                        Text(AppStrings.TopDestinationsTagLine.tr,
                          style: CustomTextStyle(
                              fontSize: 12.fss,
                              fontWeight: FontWeight.w400
                          ),overflow: TextOverflow.clip,),
                        SizedBox(height: 20.ss,),
                        Container(
                          height: 180.ss,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context,index){
                                return TopDestinationCard(size);
                              }
                          ),
                        ),
                        SizedBox(height: 20.ss,),
                        Row(
                          children: [
                            Text(AppStrings.ShopDailyDeals.tr,
                              style: CustomTextStyle(
                                  fontSize: 18.fss,
                                  fontWeight: FontWeight.w800
                              ),
                              overflow: TextOverflow.clip,),
                            Spacer(),
                            SeeAllButton(onTap: (){},),
                          ],
                        ),
                        SizedBox(height: 20.ss,),
                        Container(
                          height: 170.ss,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context,index){
                                return ShopDailyDealsCard(size);
                              }
                          ),
                        ),

                        SizedBox(height: 20.ss,),
                        Row(
                          children: [
                            Text(AppStrings.NewlyListedProperty.tr,
                              style: CustomTextStyle(
                                  fontSize: 18.fss,
                                  fontWeight: FontWeight.w800
                              ),
                              overflow: TextOverflow.clip,),
                            Spacer(),
                            SeeAllButton(onTap: (){},),
                          ],
                        ),
                        SizedBox(height: 20.ss,),
                        Container(
                          height: 280.ss,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context,index){
                                return BestDealInCard(size);
                              }
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )


        ],
      ),
    ));
  }
}

Widget HomeWidgetBigContainer (String label, String subLabel, String image,Size size){
  return
    Container(

      width: size.width*2.1/5,
      height: 80.ss,
      decoration: BoxDecoration(
      color: AppColors.colorlightgrey1,
      borderRadius: BorderRadius.all(Radius.circular(18.ss)),

  ),
    child:
    Padding(
    padding:EdgeInsets.symmetric(vertical: 5.ss),
    child: Row(
      children: [
        SizedBox(width: 5.ss,),
        Padding(
          padding:  EdgeInsets.symmetric(vertical: 8.0.ss,horizontal: 10.ss),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,style: CustomTextStyle(
                  fontSize: 12.fss,
                  fontWeight: FontWeight.w700
              ),overflow: TextOverflow.clip,),
              Text(subLabel,style: CustomTextStyle(
                  fontSize: 11.fss,
                  fontWeight: FontWeight.w400
              ),overflow: TextOverflow.clip,),
            ],
          ),
        ),
        Flexible(

          child: Image.asset(image),
        ),
        SizedBox(width: 10.ss,),
      ],
    ),
  ));
}

Widget HomeWidgetSmallContainer (String label, String subLabel, String image,Size size){
  return
    Container(

        width: size.width*1/5,
        height: 120.ss,
        decoration: BoxDecoration(
          color: AppColors.colorlightgrey1,
          borderRadius: BorderRadius.all(Radius.circular(15.ss)),

        ),
        child:
        Padding(
          padding:EdgeInsets.symmetric(vertical: 5.ss),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 8.0.ss),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 8.0.ss),
                      child: Align(
                        child: Text(label,style: CustomTextStyle(
                            fontSize: 12.fss,
                            fontWeight: FontWeight.w800
                        ),
                        overflow: TextOverflow.clip,
                        ),
                        alignment: Alignment.topLeft,
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 8.0.ss),
                      child: Text(subLabel,style: CustomTextStyle(
                          fontSize: 11.fss,
                          fontWeight: FontWeight.w400
                      ),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Image.asset(image),
              ),
            ],
          ),
        ));
}

Widget RecomendedResturentCard (Size size){
  return
    Container(
      margin: EdgeInsets.only(right: 10.ss),
        width: size.width-50,
        decoration: BoxDecoration(
          color: AppColors.colorWhite,
          border: Border.all(width: 0.4.ss,color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(15.ss)),


        ),
        child:
        Column(

          children: [

            Stack(
              children: [
                Container(
        width:size.width-50,
                    child: Image.asset(ImageUtils.recomentedResturent,fit: BoxFit.fitWidth,)),
                Positioned(
                    right: 18.ss,
                    top: 15.ss,
                    child: SvgPicture.asset(ImageUtils.heartOutline)),
                Positioned(

                    bottom: 2.ss,
                    child: Container(

                      width: size.width-50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.ss,vertical: 5.ss),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                stops: [0.1, 0.5, 0.7, 0.9],
                                colors: [
                                  Colors.blueAccent.withOpacity(0.7),
                                  Colors.blueAccent.withOpacity(0.5),
                                  Colors.grey.withOpacity(0.2),
                                  Colors.transparent!,
                                ],
                              ),
                            ),
                            child:  Text(
                              AppStrings.Flat25_Off.tr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.ss,vertical: 5.ss),
                            child:  Text(
                              AppStrings.AvailableToday.tr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ))
              ],
            ),
            SizedBox(height: 20.ss,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.ss),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.ThaiFoodBar.tr,
                    style: TextStyle(
                      color: AppColors.titleColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "\$ 520 for two",
                    style: TextStyle(
                      color: AppColors.titleColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 10.ss,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.ss,vertical: 5.ss),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(

                    child: Text(
                      "Lorem Ipsum is simply dummy text and type setting industry.",
                      style: TextStyle(
                        color: AppColors.titleColor,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset(ImageUtils.star),
                      SizedBox(width: 10.ss,),
                      Text(
                        "4.2",
                        style: TextStyle(
                          color: AppColors.titleColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            )
          ],
        ));
}

Widget DealsOnGroceryCard (Size size){
  return
    Container(
      margin: EdgeInsets.only(right: 10.ss),
        height: 250.ss,
        width: size.width * 1.3/2,
        decoration: BoxDecoration(
          color: AppColors.colorWhite,
          borderRadius: BorderRadius.all(Radius.circular(15.ss)),

        ),
        child:
        Column(
          children: [
            Container(
              height: 200.ss,
              width: size.width * 1.3/2,
              padding: EdgeInsets.symmetric(horizontal: 10.ss,vertical: 5.ss),
              decoration: BoxDecoration(
                  border: Border.all(width: 0.4.ss,color: Colors.grey),
                  color: AppColors.colorWhite,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20.ss),
                      topRight: Radius.circular(20.ss))
              ),
              child: Column(
                children: [
                  SizedBox(height: 10.ss,),
                  Text("FARMING MADE EASY",style: TextStyle(
                    color: AppColors.colorDeepBlue,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w800,
                  ),),
                  SizedBox(height: 20.ss,),

                  Text("Lorem Ipsum is simply dummy text and typesetting industry.",
                    style: TextStyle(
                    color: AppColors.titleColor.withOpacity(0.7),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                  ),
                  Expanded(child: Image.asset(ImageUtils.dealsOnGroceryItem))
                ],
              ),
            ),

            Container(
              height: 40.ss,
              padding: EdgeInsets.symmetric(horizontal: 10.ss,vertical: 5.ss),
              decoration: BoxDecoration(
                color: AppColors.colorBlue,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.ss),
                bottomRight: Radius.circular(20.ss))
              ),
              
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Up to 40% OFF",
                    style: TextStyle(
                      color: AppColors.colorWhite,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                ],
              ),
            )
          ],
        ));
}

Widget BestDealInCard (Size size){
  return
    Container(
        margin: EdgeInsets.only(right: 10.ss),
        width: size.width*2.1/3,
        decoration: BoxDecoration(
          color: AppColors.colorWhite,
          borderRadius: BorderRadius.all(Radius.circular(15.ss)),


        ),
        child:
        Column(

          children: [

            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: 180.ss,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.ss)),
                        image: DecorationImage(image: AssetImage(ImageUtils.recomentedResturent),fit: BoxFit.cover)
                      ),),
                  Positioned(
                      right: 18.ss,
                      top: 15.ss,
                      child: SvgPicture.asset(ImageUtils.heartOutline)),
                  Positioned(

                      bottom: 2.ss,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.ss,vertical: 5.ss),
                        width: size.width-50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.ss),
                              decoration: BoxDecoration(
                              ),
                              child: const Text(
                                "FLAT 60% OFF",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.ss,vertical: 5.ss),
                              decoration: BoxDecoration(
                              ),
                              child: const Text(
                                "up to 15% bank offers",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
            SizedBox(height: 20.ss,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.ss),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex:3,
                    child: Text(
                      "Barrack 62 - The Gastropub",
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        color: AppColors.titleColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset(ImageUtils.star),
                        SizedBox(width: 10.ss,),
                        Text(
                          "4.2",
                          style: TextStyle(
                            color: AppColors.titleColor,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 10.ss,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.ss,vertical: 5.ss),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(

                    child: Text(
                      "32, My Street, Kingston, 1204",
                      style: TextStyle(
                        color: AppColors.titleColor,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),


                ],
              ),
            )
          ],
        ));
}

Widget ShopDailyDealsCard (Size size){
  return
    Container(
        margin: EdgeInsets.only(right: 10.ss),
        width: size.width*1.2/4,
        decoration: BoxDecoration(
          color: AppColors.colorWhite,
          borderRadius: BorderRadius.all(Radius.circular(15.ss)),


        ),
        child:
        Column(

          children: [

            Container(
              height: 140.ss,
              decoration: BoxDecoration(
                  borderRadius:  BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors:  [ AppColors.colorShopDailyDealsBodySection,AppColors.colorWhite,])
                  ,
                 // image: DecorationImage(image: AssetImage(ImageUtils.recomentedResturent),fit: BoxFit.cover)
              ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 10.ss,),
                Image.asset(ImageUtils.shopDailyDealsLogo,width: size.width*1.2/4,height: 20.ss,fit: BoxFit.contain,),
                SizedBox(height: 20.ss,),
                Image.asset(ImageUtils.shopDailyDealsItem, width: size.width*1.2/4,height: 90.ss,
                fit: BoxFit.fitHeight,)
              ],
              
            ),
            ),
            Container(
              height: 30.ss,
              decoration: BoxDecoration(
                  borderRadius:  BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                 color: AppColors.colorShopDailyDealsBottomSection
                 // image: DecorationImage(image: AssetImage(ImageUtils.recomentedResturent),fit: BoxFit.cover)
              ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Up to 24%OFF",
                  style: TextStyle(
                    color: AppColors.colorWhite,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            ),





          ],
        ));
}

Widget TopDestinationCard (Size size){
  return
    Container(
        margin: EdgeInsets.only(right: 10.ss),
        width: size.width*1/2.5,
        decoration: BoxDecoration(
          color: AppColors.colorWhite,
          borderRadius: BorderRadius.all(Radius.circular(15.ss)),


        ),
        child:
        Column(

          children: [
            Stack(
              children: [
                Container(
                  height: 180.ss,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.ss)),
                      image: DecorationImage(image: AssetImage(ImageUtils.topDestination),fit: BoxFit.fill)
                  ),),
                Positioned(
                  bottom: 0.ss,
                  child: Container(
                    width: size.width*1/2.5,
                    height: 60.ss,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft:Radius.circular(20.ss),bottomRight:Radius.circular(20.ss),),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black,
                          Colors.transparent
                        ],),
                    ),),
                ),
                Positioned(
                    bottom: 2.ss,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.ss,vertical: 10.ss),
                      width: size.width-20,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.ss),
                        decoration: BoxDecoration(
                        ),
                        child: const Text(
                          "Monrovia",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ],
        ));
}
