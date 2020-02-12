import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'PopupWindowMenu.dart';

const Duration _kMenuDuration = Duration(milliseconds: 300); // 动画持续时间
const double _kMenuCloseIntervalEnd = 2.0 / 3.0;
const double _kMenuScreenPadding = 0.0; // 弹层盒子左右间隔

/// 自定义弹窗路由：参照_PopupMenuRoute修改的
class PopupWinMenuRoute<T> extends PopupRoute<T> {
  PopupWinMenuRoute({
    this.position,
    this.items,
    this.initialValue,
    this.elevation,
    this.theme,
    this.popupMenuTheme,
    this.barrierLabel,
    this.semanticLabel,
    this.shape,
    this.color,
    this.showMenuContext,
    this.captureInheritedThemes,
    this.isShowBg = true,
  }) : itemSizes = List<Size>(items.length);

  final RelativeRect position;
  final List<Widget> items;
  final List<Size> itemSizes;
  final dynamic initialValue;
  final double elevation;
  final ThemeData theme;
  final String semanticLabel;
  final ShapeBorder shape;
  final Color color;
  final PopupMenuThemeData popupMenuTheme;
  final BuildContext showMenuContext;
  final bool captureInheritedThemes;

  /// 是否需要遮罩层
  final bool isShowBg;

  /// 创建动画组件
  @override
  Animation<double> createAnimation() {
    return CurvedAnimation(
      parent: super.createAnimation(),
      curve: Curves.linear,
      reverseCurve: const Interval(0.0, _kMenuCloseIntervalEnd),
    );
  }

  @override
  Duration get transitionDuration => _kMenuDuration;

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor => null;

  @override
  final String barrierLabel;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    // 显示的菜单组件
    Widget menu = PopupWindowMenu<T>(route: this, semanticLabel: semanticLabel);
    if (captureInheritedThemes) {
      menu = InheritedTheme.captureAll(showMenuContext, menu);
    } else {
      if (theme != null) menu = Theme(data: theme, child: menu);
    }

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: Builder(
        builder: (BuildContext context) {
          return Material(
            type: MaterialType.transparency,
            child: Stack(
              children: <Widget>[
                GestureDetector(
                  // 遮罩层颜色
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: isShowBg ? Color(0x99000000) : Colors.transparent,
                  ),
                ),
                CustomSingleChildLayout(
                  delegate: _PopupMenuRouteLayout(
                    position, // 自定义定位显示组件
                    itemSizes,
                    null,
                    Directionality.of(context),
                  ),
                  child: menu,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// 自定义委托内容：子控件大小及其位置计算后呈现
class _PopupMenuRouteLayout extends SingleChildLayoutDelegate {
  _PopupMenuRouteLayout(
    this.position,
    this.itemSizes,
    this.selectedItemOffset,
    this.textDirection,
  );

  /// 自定义子组件显示的位置
  final RelativeRect position;

  final double selectedItemOffset;

  List<Size> itemSizes;

  final TextDirection textDirection;

  /// 在布局中给子组件约束尺寸
  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(constraints.biggest -
        const Offset(_kMenuScreenPadding * 2.0, _kMenuScreenPadding * 2.0));
  }

  /// 处理子组件放置的位置
  @override
  Offset getPositionForChild(Size size, Size childSize) {
    // 找到理想的垂直y轴位置
    double y = position.top;
    if (selectedItemOffset == null) {
      y = position.top;
    } else {
      y = position.top +
          (size.height - position.top - position.bottom) / 2.0 -
          selectedItemOffset;
    }

    // 找到理想的水平x轴位置
    double x;
    if (position.left > position.right) {
      // 菜单按钮是靠近右边缘,所以长到左边,右边缘对齐。
      x = size.width - position.right - childSize.width;
    } else if (position.left < position.right) {
      // 菜单按钮更接近左边缘,所以长到右边,左边缘对齐。
      x = position.left;
    } else {
      // Menu button is equidistant from both edges, so grow in reading direction.
      assert(textDirection != null);
      switch (textDirection) {
        case TextDirection.rtl:
          x = size.width - position.right - childSize.width;
          break;
        case TextDirection.ltr:
          x = position.left;
          break;
      }
    }

    // 定义外部区域为矩形，并且有安全距离像素--屏幕的边缘。
    if (x < _kMenuScreenPadding)
      x = _kMenuScreenPadding;
    else if (x + childSize.width > size.width - _kMenuScreenPadding)
      x = size.width - childSize.width - _kMenuScreenPadding;
    if (y < _kMenuScreenPadding)
      y = _kMenuScreenPadding;
    else if (y + childSize.height > size.height - _kMenuScreenPadding)
      y = size.height - childSize.height - _kMenuScreenPadding;
    return Offset(x, y);
  }

  // 组件渲染机制
  @override
  bool shouldRelayout(_PopupMenuRouteLayout oldDelegate) {
    assert(itemSizes.length == oldDelegate.itemSizes.length);
    return position != oldDelegate.position ||
        textDirection != oldDelegate.textDirection ||
        !listEquals(itemSizes, oldDelegate.itemSizes);
  }
}
