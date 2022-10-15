import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterminimalweb/components/components.dart';
import 'package:flutterminimalweb/components/spacing.dart';
import 'package:flutterminimalweb/routes/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ImageWrapper extends StatelessWidget {
  final String image;
  const ImageWrapper({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width =MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      child: Image.asset(
        image, 
        width: width,
        height: width/1.618,
        fit: BoxFit.cover,
      ),
    );
  }
}

class TagWrapper extends StatelessWidget {
  final List<Tag> tags;
  const TagWrapper({Key? key, this.tags = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: paddingBottom24,
      child: Wrap(
        spacing: 8,
        runSpacing: 0,
        children: [ ... tags],
      ),
    );
  }
}

class Tag extends StatelessWidget {
  final String tag;
  const Tag({Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: (){},
      fillColor: const Color(0xFF242424),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 0,
      hoverElevation: 0,
      hoverColor: const Color(0xFFC7C7C7),
      highlightElevation: 0,
      focusElevation: 0,
      child: Text(
        tag,
        style: GoogleFonts.openSans(color: Colors.white, fontSize: 14),
      ),
    );
  }
}

class ReadMoreButton extends StatelessWidget {
  final VoidCallback onPressed;
  const ReadMoreButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed, 
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all<Color>(textPrimary),
        side: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.hovered) ||
              states.contains(MaterialState.pressed)) {
            return const BorderSide(color: textPrimary, width: 2);
          }
        }),
        foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.hovered) ||
              states.contains(MaterialState.pressed)) {
            return Colors.white;
          }
          return textPrimary;
        }),
        textStyle: MaterialStateProperty.resolveWith<TextStyle>((states) {
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.hovered) ||
              states.contains(MaterialState.pressed)) {
            return GoogleFonts.montserrat(
              textStyle: const TextStyle(
                  fontSize: 14, color: Colors.white, letterSpacing: 1),
            );
          }

          return GoogleFonts.montserrat(
            textStyle: const TextStyle(
                fontSize: 14, color: textPrimary, letterSpacing: 1),
          );
        }),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal: 12, vertical: 16)),
        ),
        child: const Text(
          'READ MORE',
        ),
    );
  }
}

List<Widget> authorSection({String? imageUrl, String? name, String? bio}) {
  return [
    divider,
    Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Row(
        children: <Widget>[
          if (imageUrl != null)
            Container(
              margin: const EdgeInsets.only(right: 25),
              child: Material(
                shape: const CircleBorder(),
                clipBehavior: Clip.hardEdge,
                color: Colors.transparent,
                child: Image.asset(
                  imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          Expanded(
            child: Column(
              children: <Widget>[
                if (name != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextHeadlineSecondary(text: name),
                  ),
                if (bio != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      bio,
                      style: bodyTextStyle,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    ),
    divider,
  ];
}

class PostNavigation extends StatelessWidget {
  const PostNavigation({Key? key}) : super(key: key);

  // Example: String currentPage = RouteController.of(context).currentPage;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(
              Icons.keyboard_arrow_left,
              size: 25,
              color: textSecondary,
            ),
            Text('PREVIOUS POST', style: buttonTextStyle),
          ],
        ),
        const Spacer(),
        Row(
          children: <Widget>[
            Text('NEXT POST', style: buttonTextStyle),
            const Icon(
              Icons.keyboard_arrow_right,
              size: 25,
              color: textSecondary,
            ),
          ],
        )
      ],
    );
  }
}

class ListNavigation extends StatelessWidget {
  const ListNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.keyboard_arrow_left,
              size: 15,
              color: textSecondary,
            ),
            Text('NEWER POSTS', style: buttonTextStyle,)
          ],
        ),
        const Spacer(),
        Row(
          children: [
            Text('OLDER POST', style: buttonTextStyle,),
            const Icon(
              Icons.keyboard_arrow_right,
              size: 25,
              color: textSecondary,
            )
          ],
        )
      ],
    );
  }
}


class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: const Align(
        alignment: Alignment.centerRight,
        child: TextBody(text: 'Copyright © 2020'),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final String? description;
  const ListItem({Key? key, required this.title, this.imageUrl, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(imageUrl != null)
          ImageWrapper(image: imageUrl!),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: marginBottom12,
            child: Text(
              title,
              style: headlineTextStyle,
            ),
          ),
        ),
        if( description != null )
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: marginBottom12,
              child: Text( description!, style: bodyTextStyle,),
            ),
          ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: marginBottom24,
            child: ReadMoreButton(onPressed: () => Navigator.pushNamed(context, Routes.post) ),
          ),
        )
      ],
    );
  }
}

const Widget divider = Divider(color: Color(0xFFEEEEEE), thickness: 1,);
Widget dividerSmall = Container(
  width: 40,
  decoration: const BoxDecoration(
    border: Border(
      bottom: BorderSide(
        color: Color(0xFFA0A0A0),
        width: 1
      )
    )
  ),
);

class MenuBar extends StatelessWidget {
  const MenuBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 30),
          child: Row(
            children: [
              InkWell(
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () => Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName)),
                child: Text(
                  'MINIMAL',
                  style: GoogleFonts.montserrat(
                    color: textPrimary,
                    fontSize: 30,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w500)
                  ),
              ),
              Flexible(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children:  [
                      const ResponsiveVisibility(
                        visible: false,
                        visibleWhen: [
                          Condition.largerThan(name: TABLET)
                        ],
                        child: ItemsMenu(),
                      ),
                      // * menu bar
                      ResponsiveVisibility(
                        hiddenWhen: const [
                          Condition.largerThan(name: TABLET)
                        ],
                        child: IconButton(
                          icon: const Icon(Icons.menu), 
                          onPressed: (){
                            showMenu(
                              context: context, 
                              position: const RelativeRect.fromLTRB(1, 0, 0, 0), items: [
                                ...List.generate(
                                  menuOptions(context).length, 
                                  (index) =>PopupMenuItem<dynamic>(
                                      value: index,
                                      child: menuOptions(context)[index]
                                    ),
                                  )
                            ]);                            
                        }),
                      )
                    ],
                  ),
                )
              )
            ],
          ),
        )
      ],
    );
  }
}

class ItemsMenu extends StatelessWidget {
  const ItemsMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ...menuOptions(context)
      ],
    );
  }
}

List<Widget> menuOptions (BuildContext context) {
  return [ 
    TextButton(
          style: menuButtonStyle,
          onPressed: () => Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName)),
          child: const Text('HOME', style: TextStyle(color: textPrimary)),
        ),
        TextButton(
          style: menuButtonStyle,
          onPressed: () => Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName)),
          child: const Text('PORTFOLIO', style: TextStyle(color: textPrimary)),
        ),
        TextButton(
          style: menuButtonStyle,
          onPressed: () => Navigator.pushNamed(context,Routes.style),
          child: const Text('STYLE', style: TextStyle(color: textPrimary)),
        ),
        TextButton(
          style: menuButtonStyle,
          onPressed: () => Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName)),
          child: const Text('ABOUT', style: TextStyle(color: textPrimary)),
        ),
        TextButton(
          style: menuButtonStyle,
          onPressed: () => Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName)),
          child: const Text('CONTACT', style: TextStyle(color: textPrimary)),
        ),
  ];
}
