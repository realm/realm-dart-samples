import 'package:flutter/material.dart';

Widget buildErrorWidget(Object error, StackTrace? stackTrace) =>
    ErrorWidget(error);

Widget buildLoadingWidget() => const Center(child: CircularProgressIndicator());
