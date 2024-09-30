import 'package:active_matrimonial_flutter_app/components/btn_padding_zero.dart';
import 'package:active_matrimonial_flutter_app/components/my_images.dart';
import 'package:active_matrimonial_flutter_app/components/my_text_button.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/helpers/grid_items.dart';
import 'package:active_matrimonial_flutter_app/helpers/lang_text.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/auth_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/deactivate_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/feature/feature_check_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/matched_profile/matched_profile_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/account/account_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/verify/verify_page.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/happy_story/my_happy_stories/get_happy_story_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/manage_profiles/manage_profile.dart';
import 'package:active_matrimonial_flutter_app/screens/my_dashboard_pages/gallery/my_gallery.dart';
import 'package:active_matrimonial_flutter_app/screens/package/package_details.dart';
import 'package:active_matrimonial_flutter_app/screens/package/package_history.dart';
import 'package:active_matrimonial_flutter_app/screens/package/premium_plans.dart';
import 'package:active_matrimonial_flutter_app/screens/user_pages/user_public_profile.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/common_privacy_and_terms_page.dart';
import '../../components/grid_square_card.dart';
import '../../components/matched_profile_widget.dart';
import '../../components/remaining_box.dart';
import '../../helpers/main_helpers.dart';
import '../../helpers/shared_pref.dart';
import '../../middleware/check_package_middleware.dart';
import '../../redux/libs/auth/acccount_delete_middleware.dart';
import '../../redux/libs/auth/signout_middleware.dart';
import '../../redux/libs/drop_down/profile_dropdown_middleware.dart';
import '../../redux/libs/staticPage/static_page.dart';
import '../auth/change_password/change_password.dart';
import '../auth/verify/verify_action.dart';
import '../blog/blogs.dart';
import '../chat/chat_list.dart';
import '../contact_us/contact_us.dart';
import '../happy_story/my_happy_stories/my_happy_stories.dart';
import '../ignore/ignore.dart';
import '../my_dashboard_pages/interest/my_interest.dart';
import '../my_dashboard_pages/language/language_screen.dart';
import '../my_dashboard_pages/shortlist/my_shortlist.dart';
import '../my_dashboard_pages/wallet/my_wallet.dart';
import '../notifications/notifications.dart';
import '../profile_and_gallery_picure_rqst/gallery_picture_view_rqst.dart';
import '../profile_and_gallery_picure_rqst/profile_picture_view_rqst.dart';
import '../referral/referral.dart';
import '../referral/referral_earnings.dart';
import '../referral/referral_earnings_wallet.dart';
import '../support_ticket/support_ticket.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  bool? isSupport = store.state.addonState?.data?.supportTickets ?? false;
  bool? isReferral = store.state.addonState?.data?.referralSystem ?? false;
  var _menuList;

  void fnc_deactivate(deactivate, items) {
    if (deactivate) {
      if (myMenuItems.length == 6) {
        items.removeLast();
      }
      items.add(MyMenuItem("Reactivate Account"));
    } else {
      if (myMenuItems.length == 6) {
        items.removeLast();
      }
      items.add(MyMenuItem("Deactivate account"));
    }
  }

  List<MyMenuItem> myMenuItems = [
    MyMenuItem('FAQ'),
    MyMenuItem('Logout'),
    MyMenuItem('Contact Us'),
    MyMenuItem('Delete account'),
    MyMenuItem('Change Password'),
  ];

  fetchMenu(BuildContext context) {
    var obj = GridItems();
    obj.addMenu(context); // Pass the BuildContext here
    _menuList = obj.gridMenuItems;
  }

  @override
  Widget build(BuildContext context) {
    if (SharedPref().deactivate != true) {
      SharedPref().deactivate = false;
    }
    var deactivate = SharedPref().deactivate;
    fnc_deactivate(deactivate, myMenuItems);

    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      onInit: (store) => [
        fetchMenu(context),
        store.dispatch(accountMiddleware()),
        store.dispatch(getUserIsApproveAction()),
        store.dispatch(happyStoryCheckMiddleware()),
        store.dispatch(fetchStaticPageAction()),
        store.dispatch(matchedProfileFetchAction()),
        store.dispatch(profiledropdownMiddleware()),
        store.dispatch(getUserIsApproveAction()),
      ],
      builder: (_, state) {
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () {
              fetchMenu(context);
              store.dispatch(getUserIsApproveAction());
              store.dispatch(authMiddleware());
              store.dispatch(accountMiddleware());
              store.dispatch(featureCheckMiddleware());
              store.dispatch(matchedProfileFetchAction());

              return Future.delayed(const Duration(seconds: 2));
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // gradient box
                  buildGradientBoxContainer(context, state),

                  // gird container
                  buildGridContainer(context, state),

                  // package section
                  Padding(
                    padding: EdgeInsets.only(
                        left: Const.kPaddingHorizontal,
                        right: Const.kPaddingHorizontal,
                        bottom: 10),
                    child: buildPackageDetails(context, state),
                  ),

                  // verification section
                  // if verify section will not show
                  if (!state.userVerifyState!.isApprove!)
                    Padding(
                      padding: EdgeInsets.only(
                          left: Const.kPaddingHorizontal,
                          right: Const.kPaddingHorizontal,
                          bottom: 10),
                      child: buildVerify(context, state),
                    ),

                  // match profile box
                  MatchedProfileWidget(
                      matched_profile_controller:
                          state.accountState!.matched_profile_controller,
                      state: state),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildGradientBoxContainer(mainContext, AppState state) {
    return Container(
      width: DeviceInfo(context).width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(32.0),
            bottomRight: Radius.circular(32.0)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: const Alignment(0.8, 1),
          colors: [
            MyTheme.gradient_color_1,
            MyTheme.gradient_color_2,
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0, left: 10.0, top: 10),
          child: Column(
            children: [
              // image name email and other more vertz field
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25.0),
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: MyImages.normalImage(
                            state.accountState?.profileData?.memberPhoto!,
                          ),
                        ),
                      ),
                      Const.width10,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            store.state.authState?.userData?.name ?? "",
                            style: Styles.bold_white_14,
                          ),
                          Text(
                            store.state.authState?.userData?.email ?? "",
                            style: Styles.regular_white_12,
                          )
                        ],
                      )
                    ],
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 30.0,
                      maxWidth: 25.0,
                    ),
                    child: PopupMenuButton<MyMenuItem>(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0))),
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.white,
                        size: 20,
                      ),
                      onSelected: (value) {
                        switch (value.title.toString().toLowerCase()) {
                          case 'contact us':
                            NavigatorPush.push(context, const ContactUs());
                            break;

                          case 'faq':
                            NavigatorPush.push(
                                context,
                                CommonPrivacyAndTerms(
                                  title: "Frequently Asked Questions (FAQ)",
                                  content: state.staticPageState!.faq,
                                ));
                            break;

                          case 'change password':
                            NavigatorPush.push(context, ChangePassword());
                            break;

                          case 'deactivate account':
                            _dialogBuilder(mainContext, state);
                            break;

                          case 'reactivate account':
                            store.dispatch(
                                deactivateMiddleware(deactivate_status: 0));
                            SharedPref().deactivate = false;

                            break;

                          case 'delete account':
                            accountDeletion(state);
                            break;

                          case 'logout':
                            store.dispatch(signOutMiddleware(context));
                            break;
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          myMenuItems.map((MyMenuItem item) {
                        return PopupMenuItem<MyMenuItem>(
                          value: item,
                          child: Text(item.title),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),

              // common white back widgets
              Const.height15,
              SizedBox(
                height: 40, // You can adjust the height as needed
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    // public profile
                    MyTextButton(
                      text: Padding(
                        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                        child: Text(
                          AppLocalizations.of(context)!
                              .profile_screen_public_profile,
                          style: Styles.regularWhite(context, 3),
                        ),
                      ),
                      onPressed: () => NavigatorPush.push(
                        context,
                        UserPublicProfile(
                          userId: store.state.authState!.userData!.id!,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    // manage profile
                    MyTextButton(
                      onPressed: () =>
                          NavigatorPush.push(context, const MyProfile()),
                      text: Padding(
                        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                        child: Text(
                          AppLocalizations.of(context)!
                              .profile_screen_manage_profile,
                          style: Styles.regularWhite(context, 3),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    // gallery
                    MyTextButton(
                      onPressed: () =>
                          NavigatorPush.push(context, const MyGallery()),
                      text: Padding(
                        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                        child: Text(
                          AppLocalizations.of(context)!.profile_screen_gallery,
                          style: Styles.regularWhite(context, 3),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Const.height15,

              // horizontal line
              Const.whiteDivider,

              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  dragStartBehavior: DragStartBehavior.start,
                  children: [
                    RemainingBox(
                      context: context,
                      localization_text: AppLocalizations.of(context)!
                          .profile_screen_r_interest,
                      value: state.accountState!.profileData?.remainingInterest,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    RemainingBox(
                      context: context,
                      localization_text: AppLocalizations.of(context)!
                          .profile_screen_r_contact_view,
                      value:
                          state.accountState!.profileData?.remainingContactView,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    RemainingBox(
                        context: context,
                        localization_text: AppLocalizations.of(context)!
                            .profile_screen_r_gallery_image_upload,
                        value: state
                            .accountState!.profileData?.remainingPhotoGallery),

                    /// remaining profile image view
                    state.accountState!.profileData
                                ?.remainingProfileImageView !=
                            ""
                        ? RemainingBox(
                            context: context,
                            localization_text: AppLocalizations.of(context)!
                                .profile_screen_r_profile_image_view,
                            value: state.accountState!.profileData
                                ?.remainingProfileImageView)
                        : const SizedBox.shrink(),

                    state.accountState!.profileData
                                ?.remainingGalleryImageView !=
                            ""
                        ? RemainingBox(
                            context: context,
                            localization_text: AppLocalizations.of(context)!
                                .profile_screen_r_gallery_image_view,
                            value: state.accountState!.profileData
                                ?.remainingGalleryImageView)
                        : const SizedBox.shrink(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGridContainer(BuildContext context, AppState state) {
    final List<GridSquareCard> gridItems = [];

    // Add GridSquareCard items conditionally
    if (settingIsActive("wallet_system", "1")) {
      gridItems.add(GridSquareCard(
        onpressed: MyWallet(),
        icon: "icon_wallet.png",
        isSmallScreen: false,
        text: AppLocalizations.of(context)!.profile_screen_my_wallet,
      ));
    }

    gridItems.add(GridSquareCard(
      onpressed: LanguageScreen(),
      icon: "icon_white_lang.png",
      isSmallScreen: false,
      text: AppLocalizations.of(context)!.public_profile_Lang,
    ));

    gridItems.add(GridSquareCard(
      onpressed: ChatList(backButtonAppearance: true),
      icon: "icon_messages.png",
      isSmallScreen: false,
      text: AppLocalizations.of(context)!.profile_screen_messages,
    ));

    gridItems.add(GridSquareCard(
      onpressed: const Notifications(),
      icon: "icon_notifications.png",
      isSmallScreen: false,
      text: AppLocalizations.of(context)!.profile_screen_notifications,
    ));

    gridItems.add(GridSquareCard(
      onpressed: const MyInterest(),
      icon: "icon_love.png",
      isSmallScreen: false,
      text: AppLocalizations.of(context)!.profile_screen_my_interest,
    ));

    if (settingIsActive("profile_picture_privacy", "only_me")) {
      gridItems.add(GridSquareCard(
        onpressed: const PictureProfileViewRqst(),
        icon: "icon_picture_view.png",
        isSmallScreen: false,
        text: AppLocalizations.of(context)!.profile_picture_screen_appbar_title,
      ));
    }

    if (settingIsActive("gallery_image_privacy", "only_me")) {
      gridItems.add(GridSquareCard(
        onpressed: const GalleryProfileViewRqst(),
        icon: "icon_gallery_view.png",
        isSmallScreen: false,
        text: AppLocalizations.of(context)!.gallery_picture_screen_appbar_title,
      ));
    }

    gridItems.add(GridSquareCard(
      onpressed: const MyShortlist(),
      icon: "icon_shortlist.png",
      isSmallScreen: false,
      text: AppLocalizations.of(context)!.my_shortlist_lower,
    ));

    gridItems.add(GridSquareCard(
      onpressed: const Ignore(),
      icon: "icon_ignore.png",
      isSmallScreen: false,
      text: AppLocalizations.of(context)!.profile_ignore_users,
    ));

    gridItems.add(GridSquareCard(
      onpressed: const MyHappyStories(),
      middleware: PackageCheckMiddleware(
          context: OneContext().context!,
          user: store.state.authState!.userData),
      icon: "icon_happy_s.png",
      isSmallScreen: false,
      text: AppLocalizations.of(context)!.my_happy_stories_appbar_title,
    ));

    if (settingIsActive("show_blog_section", "on")) {
      gridItems.add(GridSquareCard(
        onpressed: const BlogPage(),
        icon: "icon_blogs.png",
        isSmallScreen: false,
        text: AppLocalizations.of(context)!.common_screen_blogs,
      ));
    }

    if (store.state.addonState!.data!.supportTickets!) {
      gridItems.add(GridSquareCard(
        onpressed: const SupportTicket(),
        icon: "icon_support.png",
        isSmallScreen: false,
        text: AppLocalizations.of(context)!.support_ticket,
      ));
    }

    if (store.state.addonState!.data!.referralSystem!) {
      gridItems.add(GridSquareCard(
        onpressed: const Referral(),
        icon: "icon_referral_user.png",
        isSmallScreen: false,
        text: "Referral",
      ));

      gridItems.add(GridSquareCard(
        onpressed: const RefferalEarnings(),
        icon: "icon_referral_earnings.png",
        isSmallScreen: false,
        text: AppLocalizations.of(context)!.referral_earnings,
      ));

      gridItems.add(GridSquareCard(
        onpressed: const ReferralEarningsWallet(),
        icon: "icon_referral_wallet.png",
        isSmallScreen: false,
        text: AppLocalizations.of(context)!.referral_wallet,
      ));
    }

    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _menuList.length,
        controller: state.accountState!.gridScrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 5,
            childAspectRatio: 1),
        padding: const EdgeInsets.only(left: 24.0, top: 20, right: 24),
        itemBuilder: (context, index) {
          return gridItems[index];
        });
  }

  Widget buildVerify(BuildContext context, AppState state) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: MyTheme.app_accent_color),
        color: MyTheme.app_accent_color.withOpacity(.09),
        borderRadius: const BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      // height: 111,
      child: Padding(
        padding: const EdgeInsets.only(
            left: 20.0, top: 15.0, right: 8.0, bottom: 15.0),
        child: Column(
          children: [
            /// package and upgrade package
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/icon/verify.png',
                          width: 40,
                          height: 40,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(LangText(context).local.not_verified)
                      ],
                    )
                  ],
                ),
                // package list
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: MyTextButton(
                onPressed: () {
                  NavigatorPush.push(context, const VerifyPage());
                },
                text: Text(
                  LangText(context).local.verify_now,
                  style: Styles.bold_white_10,
                ),
                color: MyTheme.app_accent_color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPackageDetails(BuildContext context, AppState state) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: MyTheme.app_accent_color),
        color: MyTheme.solitude,
        borderRadius: const BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      // height: 111,
      child: Padding(
        padding: const EdgeInsets.only(
            left: 8.0, top: 15.0, right: 8.0, bottom: 15.0),
        child: Column(
          children: [
            /// package and upgrade package
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${AppLocalizations.of(context)!.profile_screen_package}: ",
                          style: Styles.regular_arsenic_12,
                        ),
                        Text(
                          state.accountState!.profileData?.currentPackageInfo
                                  ?.packageName ??
                              "",
                          style: Styles.bold_storm_grey_12,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!
                              .profile_screen_expire_on,
                          style: Styles.regular_arsenic_12,
                        ),
                        Text(
                          state.accountState!.profileData?.currentPackageInfo
                                  ?.packageExpiry ??
                              "",
                          style: Styles.bold_storm_grey_12,
                        ),
                      ],
                    ),
                  ],
                ),
                // package list
                MyTextButton(
                  onPressed: () {
                    NavigatorPush.push(context, const PremiumPlans());
                  },
                  text: Text(
                    AppLocalizations.of(context)!.profile_screen_upgrade,
                    style: Styles.bold_white_10,
                  ),
                  color: MyTheme.app_accent_color,
                ),
              ],
            ),
            Const.height5,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // package details button
                ButtonPaddingZero(
                  text: Text(
                      AppLocalizations.of(context)!
                          .profile_screen_package_details,
                      style: Styles.bold_app_accent_12),
                  onPressed: () => NavigatorPush.push(
                    context,
                    PackageDetails(
                        packageId: state.accountState!.profileData!
                            .currentPackageInfo!.packageId),
                  ),
                ),
                // package history button

                ButtonPaddingZero(
                  text: Text(
                      AppLocalizations.of(context)!
                          .profile_screen_package_history,
                      style: Styles.bold_app_accent_12),
                  onPressed: () => NavigatorPush.push(
                    context,
                    PackageHistory(),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  accountDeletion(AppState state) {
    return OneContext().showDialog(builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          LangText(context).local.delete_account,
          style: Styles.bold_arsenic_14,
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: const Color.fromRGBO(255, 221, 218, 1),
              ),
              child: Text(
                LangText(context).local.common_cancel,
                style: TextStyle(color: MyTheme.arsenic),
              ),
            ),
            onPressed: () {
              OneContext().popDialog();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: const Color.fromRGBO(201, 227, 202, 1),
              ),
              child: Text(
                LangText(context).local.common_confirm,
                style: TextStyle(color: MyTheme.arsenic),
              ),
            ),
            onPressed: () {
              store.dispatch(accountDeletionMiddleware());
              OneContext().popDialog();
            },
          ),
        ],
      );
    });
  }

  _dialogBuilder(mainContext, AppState state) {
    return showDialog<void>(
      context: mainContext,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          content: SizedBox(
            height: 200,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Text(AppLocalizations.of(context)!.deactivate,
                    textAlign: TextAlign.center,
                    style: Styles.bold_app_accent_20),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                          gradient: Styles.buildLinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          borderRadius: BorderRadius.circular(12.0)),
                      child: TextButton(
                        onPressed: () {
                          store.dispatch(
                            deactivateMiddleware(deactivate_status: 1),
                          );
                          SharedPref().deactivate = true;

                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(
                          fixedSize:
                              WidgetStateProperty.all(const Size(90.0, 45.0)),
                          overlayColor:
                              WidgetStateProperty.all(MyTheme.app_accent_color),
                          shape: WidgetStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                side: BorderSide(
                                    color: MyTheme.app_accent_color)),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.yes,
                          style: Styles.bold_arsenic_16,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        fixedSize:
                            WidgetStateProperty.all(const Size(90.0, 45.0)),
                        overlayColor:
                            WidgetStateProperty.all(MyTheme.app_accent_color),
                        shape: WidgetStateProperty.all(
                          const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              side:
                                  BorderSide(color: MyTheme.app_accent_color)),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.no,
                        style: Styles.bold_arsenic_16,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class MyMenuItem {
  final String title;

  MyMenuItem(this.title);
}
