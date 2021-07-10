import 'package:flutter/material.dart';
import 'package:menu_button/menu_button.dart';
import 'package:myads_app/Constants/colors.dart';
import 'package:myads_app/Constants/dimens.dart';
import 'package:myads_app/Constants/styles.dart';

// class DropDowmPage extends StatefulWidget {
//   const DropDowmPage({Key key, @required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   _DropDowmPageState createState() => _DropDowmPageState();
// }
//
// class _DropDowmPageState extends State<DropDowmPage> {
//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//
//     return  Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//
//           Padding(
//             padding: const EdgeInsets.only(bottom: 12),
//             child: MenuButtonWithoutShowingSameSelectedIitem(
//               theme: theme,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class MenuButtonWithoutShowingSameSelectedIitem extends StatefulWidget {
  const MenuButtonWithoutShowingSameSelectedIitem({
    Key key,
    @required this.country,
  }) : super(key: key);

  final List country;

  @override
  _MenuButtonWithoutShowingSameSelectedIitemState createState() =>
      _MenuButtonWithoutShowingSameSelectedIitemState();
}

class _MenuButtonWithoutShowingSameSelectedIitemState
    extends State<MenuButtonWithoutShowingSameSelectedIitem> {
  String selectedKey;
  String initialValue;

  List<String> keys = <String>[
    'Australia',
    'India',
    'Europe',
    'America',
    'Thailand',
  ];

  @override
  void initState() {
    initialValue = keys[0];
    selectedKey = keys[0];
    super.initState();
    print(widget.country);
  }

  @override
  Widget build(BuildContext context) {
    final Widget childButtonWithoutSameItem = Container(
      padding: const EdgeInsets.only(left: 16, right: 11),
      height: 50.0,
      width: 300.0,
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.accentsColors),
        color: MyColors.blueShade,
        borderRadius: const BorderRadius.all(
          Radius.circular(2.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              selectedKey,
              // overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            width: 12,
            height: 17,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Icon(
                Icons.arrow_drop_down,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            'Country',
            style: MyStyles.robotoMedium16.copyWith(
                letterSpacing: Dimens.letterSpacing_14,
                color: MyColors.accentsColors,
                fontWeight: FontWeight.w100),
          ),
        ),
        MenuButton<String>(
          child: childButtonWithoutSameItem,
          items: keys,
          topDivider: true,
          showSelectedItemOnList: false,
          selectedItem: selectedKey,
          itemBackgroundColor: MyColors.blueShade,
          edgeMargin: 5.0,
          itemBuilder: (String value) => Container(
            height: 40,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
            child: Text(value),
          ),
          toggledChild: Container(
            child: childButtonWithoutSameItem,
          ),
          divider: Container(
            height: 1,
            color: MyColors.accentsColors,
          ),
          onItemSelected: (String value) {
            setState(() {
              selectedKey = value;
              print(selectedKey);
            });
          },
          decoration: BoxDecoration(
            border: Border.all(color: MyColors.accentsColors),
            borderRadius: const BorderRadius.all(
              Radius.circular(3.0),
            ),
          ),
          onMenuButtonToggle: (bool isToggle) {
            // print(isToggle);
          },
        ),
      ],
    );
  }
}
