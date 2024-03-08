import 'package:flutter/material.dart';

InputDecoration roundedLabel = new InputDecoration(
  border: new OutlineInputBorder(
    borderRadius: const BorderRadius.all(
      const Radius.circular(10.0),
    ),
  ),
  filled: true,
  hintStyle: new TextStyle(color: Colors.grey[800]),
  hintText: "Type in your text",
  fillColor: Colors.white70),
);
