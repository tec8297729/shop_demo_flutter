import 'package:flutter/material.dart';
import 'MenuItem.dart';
import 'PopupWinMenuRoute.dart';

const double _kMenuWidthStep = 56.0; // 弹层宽度基数值
const double _kMenuMaxWidth = 5.0 * _kMenuWidthStep; // 弹层最大宽度
const double _kMenuMinWidth = 2.0 * _kMenuWidthStep; // 弹层最小宽度
const double _kMenuVerticalPadding = 0.0; // 子组件垂直间隔边距

/// 下拉菜单组件, 自定义弹窗控件：对自定义的弹窗内容进行再包装，添加长宽、动画等约束条件，参考_PopupMenu改造
class PopupWindowMenu<T> extends StatelessWidget {
  const PopupWindowMenu({
    Key key,
    this.route,
    this.semanticLabel,
    this.fullWidth = true,
  }) : super(key: key);

  final PopupWinMenuRoute<T> route;
  final String semanticLabel;

  /// 是否撑满宽度
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final double unit = 1.0 /
        (route.items.length +
            1.5); // 1.0 for the width and 0.5 for the last item's fade.
    final List<Widget> children = <Widget>[];
    final PopupMenuThemeData popupMenuTheme = PopupMenuTheme.of(context);

    for (int i = 0; i < route.items.length; i += 1) {
      final double start = (i + 1) * unit;
      final double end = (start + 1.5 * unit).clamp(0.0, 1.0);
      final CurvedAnimation opacity = CurvedAnimation(
        parent: route.animation,
        curve: Interval(start, end),
      );
      Widget item = route.items[i];
      // 添加单个子组件
      children.add(
        // 控制先布局盒子动画，在透明文字动画
        MenuItem(
          onLayout: (Size size) {
            route.itemSizes[i] = size;
          },
          child: FadeTransition(
            opacity: opacity,
            child: item,
          ),
        ),
      );
    }

    final CurveTween opacity =
        CurveTween(curve: const Interval(0.0, 1.0 / 3.0));
    final CurveTween width = CurveTween(curve: Interval(0.0, unit));
    final CurveTween height =
        CurveTween(curve: Interval(0.0, unit * route.items.length));

    // 定义组件是否宽度满屏
    final Widget child = ConstrainedBox(
      constraints: new BoxConstraints(
        minWidth: fullWidth ? double.infinity : _kMenuMinWidth,
        maxWidth: fullWidth ? double.infinity : _kMenuMaxWidth,
      ),
      child: Semantics(
        scopesRoute: true,
        namesRoute: true,
        explicitChildNodes: true,
        label: semanticLabel,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: _kMenuVerticalPadding),
          child: ListBody(children: children),
        ),
      ),
    );

    return AnimatedBuilder(
      animation: route.animation,
      builder: (BuildContext context, Widget child) {
        return Opacity(
          opacity: opacity.evaluate(route.animation),
          child: Material(
            shape: route.shape ?? popupMenuTheme.shape,
            color: route.color ?? popupMenuTheme.color,
            type: MaterialType.card,
            elevation: route.elevation ?? popupMenuTheme.elevation ?? 8.0,
            child: Align(
              alignment: AlignmentDirectional.topEnd,
              widthFactor: width.evaluate(route.animation),
              heightFactor: height.evaluate(route.animation),
              child: child,
            ),
          ),
        );
      },
      child: child,
    );
  }
}
