// import 'package:flutter/material.dart';
//
// import '../../components/grid_square_card.dart';
// import '../../helpers/main_helpers.dart';
// import '../my_dashboard_pages/wallet/my_wallet.dart';
//
// class AccountGrid extends StatefulWidget {
//   const AccountGrid({super.key});
//
//   @override
//   State<AccountGrid> createState() => _AccountGridState();
// }
//
// class _AccountGridState extends State<AccountGrid> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         if (settingIsActive("wallet_system", "1"))
//           GridSquareCard(
//             onpressed: MyWallet(),
//             icon: "icon_wallet.png",
//             isSmallScreen: false,
//             text: AppLocalizations.of(context)!.profile_screen_my_wallet,
//           ),
//         GridSquareCard(
//           onpressed: LanguageScreen(),
//           icon: "icon_white_lang.png",
//           isSmallScreen: false,
//           text: AppLocalizations.of(context)!.public_profile_Lang,
//         ),
//         GridSquareCard(
//           onpressed: ChatList(
//             backButtonAppearance: true,
//           ),
//           icon: "icon_messages.png",
//           isSmallScreen: false,
//           text: AppLocalizations.of(context)!.profile_screen_messages,
//         ),
//         GridSquareCard(
//           onpressed: const Notifications(),
//           icon: "icon_notifications.png",
//           isSmallScreen: false,
//           text: AppLocalizations.of(context)!.profile_screen_notifications,
//         ),
//         GridSquareCard(
//           onpressed: const MyInterest(),
//           icon: "icon_love.png",
//           isSmallScreen: false,
//           text: AppLocalizations.of(context)!.profile_screen_my_interest,
//         ),
//         if (settingIsActive("profile_picture_privacy", "only_me"))
//           GridSquareCard(
//             onpressed: const PictureProfileViewRqst(),
//             icon: "icon_picture_view.png",
//             isSmallScreen: false,
//             text: AppLocalizations.of(context)!
//                 .profile_picture_screen_appbar_title,
//           ),
//         if (settingIsActive("gallery_image_privacy", "only_me"))
//           GridSquareCard(
//             onpressed: const GalleryProfileViewRqst(),
//             icon: "icon_gallery_view.png",
//             isSmallScreen: false,
//             text: AppLocalizations.of(context)!
//                 .gallery_picture_screen_appbar_title,
//           ),
//         GridSquareCard(
//           onpressed: const MyShortlist(),
//           icon: "icon_shortlist.png",
//           isSmallScreen: false,
//           text: AppLocalizations.of(context)!.my_shortlist_lower,
//         ),
//         GridSquareCard(
//           onpressed: const Ignore(),
//           icon: "icon_ignore.png",
//           isSmallScreen: false,
//           text: AppLocalizations.of(context)!.profile_ignore_users,
//         ),
//         GridSquareCard(
//           onpressed: const MyHappyStories(),
//           middleware: PackageCheckMiddleware(
//               context: OneContext().context!,
//               user: store.state.authState!.userData),
//           icon: "icon_happy_s.png",
//           isSmallScreen: false,
//           text: AppLocalizations.of(context)!.my_happy_stories_appbar_title,
//         ),
//         if (settingIsActive("show_blog_section", "on"))
//           GridSquareCard(
//             onpressed: const BlogPage(),
//             icon: "icon_blogs.png",
//             isSmallScreen: false,
//             text: AppLocalizations.of(context)!.common_screen_blogs,
//           ),
//         if (store.state.addonState!.data!.supportTickets!)
//           GridSquareCard(
//             onpressed: const SupportTicket(),
//             icon: "icon_support.png",
//             isSmallScreen: false,
//             text: AppLocalizations.of(context)!.support_ticket,
//           ),
//         if (store.state.addonState!.data!.referralSystem!)
//           GridSquareCard(
//             onpressed: const Referral(),
//             icon: "icon_referral_user.png",
//             isSmallScreen: false,
//             text: AppLocalizations.of(context)!.referral_screen_lower,
//           ),
//         if (store.state.addonState!.data!.referralSystem!)
//           GridSquareCard(
//             onpressed: const RefferalEarnings(),
//             icon: "icon_referral_earnings.png",
//             isSmallScreen: false,
//             text: AppLocalizations.of(context)!.referral_earnings,
//           ),
//         if (store.state.addonState!.data!.referralSystem!)
//           GridSquareCard(
//             onpressed: const ReferralEarningsWallet(),
//             icon: "icon_referral_wallet.png",
//             isSmallScreen: false,
//             text: AppLocalizations.of(context)!.referral_wallet,
//           ),
//       ],
//     );
//   }
// }
//
// class AppLocalizations {}
