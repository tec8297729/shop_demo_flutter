import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ErrorStore extends ProviderNotFoundError {
  ErrorStore(Type valueType, Type widgetType) : super(valueType, widgetType);

  @override
  // TODO: implement valueType
  Type get valueType => super.valueType;

  @override
  // TODO: implement widgetType
  Type get widgetType => super.widgetType;
}
