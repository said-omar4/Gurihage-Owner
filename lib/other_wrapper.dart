// import 'package:flutter/material.dart';
// import 'appbar.dart';

// class OtherScreenWrapper extends StatelessWidget {
//   final Widget screen;
//   final DrawerItem activeItem;

//   const OtherScreenWrapper({
//     super.key,
//     required this.screen,
//     required this.activeItem,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar.buildAppBar(context),
//       drawer: CustomAppBar.buildDrawer(context, activeItem, (item) {
//         Navigator.pop(context);

//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (_) => OtherScreenWrapper(
//               screen: getScreen(item),
//               activeItem: item,
//             ),
//           ),
//         );
//       }),
//       body: screen,
//     );
//   }
// }
