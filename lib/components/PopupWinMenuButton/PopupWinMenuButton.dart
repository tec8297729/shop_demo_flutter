import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'components/PopupWinMenuRoute.dart';

/// 显示下拉框弹层方法
///
/// [isShowBg] 是否显示遮罩层
Future<T> showWinMenu<T>({
  @required BuildContext context,
  @required RelativeRect position,
  @required List<Widget> items,
  T initialValue,
  double elevation,
  String semanticLabel,
  ShapeBorder shape,
  Color color,
  bool captureInheritedThemes = true,
  bool useRootNavigator = false,
  bool isShowBg = false,
}) {
  assert(context != null);
  assert(position != null);
  assert(useRootNavigator != null);
  assert(items != null && items.isNotEmpty);
  assert(captureInheritedThemes != null);
  assert(debugCheckHasMaterialLocalizations(context));

  String label = semanticLabel;
  switch (Theme.of(context).platform) {
    case TargetPlatform.iOS:
      label = semanticLabel;
      break;
    case TargetPlatform.android:
    case TargetPlatform.fuchsia:
      label =
          semanticLabel ?? MaterialLocalizations.of(context)?.popupMenuLabel;
  }

  // 使用自定义路由组件
  return Navigator.of(context, rootNavigator: useRootNavigator)
      .push(PopupWinMenuRoute<T>(
    position: position,
    items: items,
    initialValue: initialValue,
    elevation: elevation,
    semanticLabel: label,
    theme: Theme.of(context, shadowThemeOnly: true),
    popupMenuTheme: PopupMenuTheme.of(context),
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    shape: shape,
    color: color,
    isShowBg: isShowBg,
    showMenuContext: context,
    captureInheritedThemes: captureInheritedThemes,
  ));
}

/// Used by [PopupWinMenuButton.onSelected] 的类型
typedef PopupWinMenuItemSelected<T> = void Function(T value);

/// Used by [PopupWinMenuButton.onCanceled] 的类型
typedef PopupWinMenuCanceled = void Function();

/// [PopupWinMenuButton.itemBuilder] 的类型
typedef PopupWinMenuItemBuilder<T> = List<Widget> Function(
    BuildContext context);

/// 按钮组件（带有下拉框弹层）, 并且 [itemBuilder] 参数不能为空.
class PopupWinMenuButton<T> extends StatefulWidget {
  const PopupWinMenuButton({
    Key key,
    @required this.itemBuilder,
    this.initialValue,
    this.onSelected,
    this.onCanceled,
    this.tooltip,
    this.elevation,
    this.padding = const EdgeInsets.all(8.0),
    @required this.child,
    @required this.onTap,
    this.icon,
    this.offset = Offset.zero,
    this.enabled = true,
    this.shape,
    this.color,
    this.captureInheritedThemes = true,
  })  : assert(itemBuilder != null),
        assert(offset != null),
        assert(enabled != null),
        assert(captureInheritedThemes != null),
        assert(!(child != null && icon != null),
            'You can only pass [child] or [icon], not both.'),
        super(key: key);

  /// 按钮被按下时调用创建菜单中显示的组件。
  final PopupWinMenuItemBuilder itemBuilder;

  final T initialValue;

  final PopupWinMenuItemSelected<T> onSelected;

  /// 取消弹层事件
  final PopupWinMenuCanceled onCanceled;

  /// 长按时显示提示内容
  final String tooltip;

  /// 阴影
  final double elevation;

  /// 内边距
  final EdgeInsetsGeometry padding;

  /// 按钮显示的组件
  final Widget child;

  /// 按钮点击事件
  final Function(BuildContext context) onTap;

  final Widget icon;

  /// 偏移位置
  final Offset offset;

  final bool enabled;

  final ShapeBorder shape;

  final Color color;

  final bool captureInheritedThemes;

  @override
  _PopupMenuButtonState<T> createState() => _PopupMenuButtonState<T>();
}

class _PopupMenuButtonState<T> extends State<PopupWinMenuButton<T>> {
  // 按钮点击事件
  void showButtonMenu() {
    final PopupMenuThemeData popupMenuTheme = PopupMenuTheme.of(context);
    final RenderBox button = context.findRenderObject();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        // 局部坐标系的转换给定的点这个盒子全球坐标系统逻辑像素，必须坐标的祖先组件
        button.localToGlobal(widget.offset, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    final List<Widget> items = widget.itemBuilder(context);

    // 按钮点击事件回调
    if (widget.onTap != null) {
      widget.onTap(context);
    }

    // Only show the menu if there is something to show
    if (items?.isNotEmpty ?? false) {
      // 弹出菜单
      showWinMenu<T>(
        context: context,
        elevation: widget.elevation ?? popupMenuTheme.elevation,
        items: items,
        initialValue: widget.initialValue,
        position: position,
        shape: widget.shape ?? popupMenuTheme.shape,
        color: widget.color ?? popupMenuTheme.color,
        captureInheritedThemes: widget.captureInheritedThemes,
      ).then<void>((T newValue) {
        if (!mounted) return null;
        if (newValue == null) {
          if (widget.onCanceled != null) widget.onCanceled();
          return null;
        }
        if (widget.onSelected != null) widget.onSelected(newValue);
      });
    }
  }

  Icon _getIcon(TargetPlatform platform) {
    assert(platform != null);
    switch (platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return const Icon(Icons.more_vert);
      case TargetPlatform.iOS:
        return const Icon(Icons.more_horiz);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));

    if (widget.child != null)
      return Tooltip(
        message:
            widget.tooltip ?? MaterialLocalizations.of(context).showMenuTooltip,
        child: InkWell(
          onTap: widget.enabled ? showButtonMenu : null,
          canRequestFocus: widget.enabled,
          child: widget.child,
          highlightColor: Colors.yellow,
        ),
      );

    return IconButton(
      icon: widget.icon ?? _getIcon(Theme.of(context).platform),
      padding: widget.padding,
      tooltip:
          widget.tooltip ?? MaterialLocalizations.of(context).showMenuTooltip,
      onPressed: widget.enabled ? showButtonMenu : null,
    );
  }
}
