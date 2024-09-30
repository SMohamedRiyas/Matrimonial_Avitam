import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/components/percentage_calculator.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class MyProfileListData {
  dynamic title;
  dynamic subtitle;
  Widget? link;
  dynamic icon;
  Widget? pp;
  dynamic percentage;

  dynamic title2;
  dynamic subtitle2;
  dynamic icon2;
  Widget? pp2;

  MyProfileListData(
      {this.title,
      this.subtitle,
      this.link,
      this.icon,
      this.pp,
      this.percentage,
      this.title2,
      this.subtitle2,
      this.icon2,
      this.pp2});

  double? getPercent(value) {
    return PercentageCalculator(data: value).getPercentage();
  }

  Widget getExpandableWidget(context, {index}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        boxShadow: [CommonWidget.box_shadow()],
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 20.0,
          top: index == 0 ? 20 : 18.0,
          right: 20,
          bottom: index == 0 ? 20 : 12,
        ),
        child: ExpandablePanel(
          theme: const ExpandableThemeData(
            iconPadding: EdgeInsets.zero,
            iconColor: Colors.grey,
          ),
          header: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                this.icon2,
                height: 16,
                width: 16,
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      this.title2,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.medium_arsenic_14,
                    ),
                    if (this.subtitle2 != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          this.subtitle2 ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Styles.regular_light_grey_12,
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
          expanded: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(child: pp2),
          ),
          collapsed: SizedBox.shrink(),
        ),
      ),
    );
  }

  Widget getWidget(context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => this.link!),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          boxShadow: [CommonWidget.box_shadow()],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      this.icon,
                      height: 16,
                      width: 16,
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => this.link!),
                        );
                      },
                      child: SizedBox(
                        width: DeviceInfo(context).width! * .68,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              this.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Styles.medium_arsenic_14,
                            ),
                            if (this.subtitle != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  this.subtitle ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Styles.regular_light_grey_12,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // IconButton(
                //   padding: EdgeInsets.zero,
                //   constraints: BoxConstraints(),
                //   onPressed: () {},
                //   icon: Icon(Icons.chevron_right),
                //   color: Color.fromRGBO(115, 122, 128, 1),
                // ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: DeviceInfo(context).width! * .065),
                  width: DeviceInfo(context).width! * .65,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    child: LinearProgressIndicator(
                      backgroundColor: MyTheme.zircon,
                      color: MyTheme.light_sea_green,
                      minHeight: 5,
                      value: this.percentage,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  '${(this.percentage == null ? 0 : this.percentage * 100).toStringAsFixed(0)}%',
                  style: TextStyle(color: MyTheme.storm_grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
