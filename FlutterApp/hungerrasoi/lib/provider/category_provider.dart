import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier{
    String _category;
    String get category => _category;

    setCategory(String category){
        _category = category;
    }
}