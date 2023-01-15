# money_record_app

# File structure 📁

```
lib
  - _widget_store/
  
  - components/
    - graph/
      - graph_list_tile.dart
  
  - database/
    - db_bloc.dart
    - db_provider.dart
  
  - model/
    - chart_data.dart
    - money.dart
  
  - preference/
    - shared_preference.dart
  
  - screen/
    - calendar
      - calendar_screen.dart
      - calendar_screen_controller.dart
    - detail/
      - detail_screen.dart
      - detail_screen_controller.dart
    - graph/
      - graph_screen.dart
      - graph_screen_controller.dart
    - home/
      - category
        - category_screen.dart
        - category_screen_controller.dart
      - home_screen.dart
      - home_screen_controller.dart
    - setting/
      - setting_screen.dart
      - setting_screen_controller.dart
    - tab/
      - tab_screen.dart
      - tab_screen_controller.dart
    
  - main.dart
  - my_app.dart
```

# Architecture 😃 [MVVM]

![to1719_mvvm001-01_MASK](https://user-images.githubusercontent.com/67954894/175755106-76e20f74-f68b-4ef1-a9bb-c7f4cd45f14d.jpeg)

# Package for State Management 📦

・GetX.   
・Provider

# Naming convention 😄

| variable name | code style | example |
| :--- | :--- | :--- |
| Class name | UpperCamelCase | `HomeScreen` |
| File/Directory/Package | lowercase_with_underscores | `lib/screen/home/home_screen.dart` |
| Field/Function name | lowerCamelCase | `routeName` |
| Constant name | lowerCamelCase | `parameter` |

