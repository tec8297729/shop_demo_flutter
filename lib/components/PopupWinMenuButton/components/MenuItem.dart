import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// 控制item组件动画效果，先onLayout盒子大小动画，在处理child动画
class MenuItem extends SingleChildRenderObjectWidget {
  const MenuItem({
    Key key,
    @required this.onLayout,
    Widget child,
  })  : assert(onLayout != null),
        super(key: key, child: child);

  final ValueChanged<Size> onLayout;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderMenuItem(onLayout);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _RenderMenuItem renderObject) {
    renderObject.onLayout = onLayout;
  }
}

class _RenderMenuItem extends RenderShiftedBox {
  _RenderMenuItem(this.onLayout, [RenderBox child])
      : assert(onLayout != null),
        super(child);

  ValueChanged<Size> onLayout;
  // 计算这个渲染对象的布局
  @override
  void performLayout() {
    if (child == null) {
      size = Size.zero;
    } else {
      child.layout(constraints, parentUsesSize: true);
      size = constraints.constrain(child.size);
    }
    final BoxParentData childParentData = child.parentData;
    childParentData.offset = Offset.zero;
    onLayout(size);
  }
}
