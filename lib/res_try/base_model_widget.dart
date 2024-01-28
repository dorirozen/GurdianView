import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// this code is for extending BaseModelWidget<DrawerItemData> in some class
///  in the [Widget build(BuildContext context, DrawerItemData data)] we will add [DrawerItemData data] to get the provided data
abstract class BaseModelWidget<T> extends Widget {
  const BaseModelWidget({super.key});

  @protected
  Widget build(BuildContext context, T model);
  @override
  _DataProviderElement<T> createElement() => _DataProviderElement<T>(this);
}

class _DataProviderElement<T> extends ComponentElement {
  _DataProviderElement(BaseModelWidget widget) : super(widget);
  @override
  BaseModelWidget get widget => super.widget as BaseModelWidget<T>;

  @override
  Widget build() => widget.build(this, Provider.of<T>(this));
}
