import 'package:flutter/material.dart';
import 'screens/settings_screen.dart';
import 'package:meals/screens/tabs_screen.dart';
import 'screens/categories_meals.dart';
import 'screens/categories_screens.dart';
import 'screens/meal_detail_screen.dart';
import 'utils/app_roudes.dart';
import 'models/meal.dart';
import 'data/dummy_data.dart';
import 'models/settings.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Settings settings = Settings();
  List<Meal> _availableMeals = dummyMeals;
  List<Meal> _favoriteMeals = [];

  void _filterMeals(Settings settings) {
    setState(() {
      this.settings = settings;
      _availableMeals = dummyMeals.where((meal) {
        final filterGluten = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = settings.isVegan && !meal.isVegan;
        final filterVegetarian = settings.isVegetarian && !meal.isVegetarian;
        return !filterGluten &&
            !filterLactose &&
            !filterVegan &&
            !filterVegetarian;
      }).toList();
    });
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      _favoriteMeals.contains(meal)
          ? _favoriteMeals.remove(meal)
          : _favoriteMeals.add(meal);
    });
  }

  bool _isFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromRGBO(28, 46, 115, 1),
          secondary: const Color.fromRGBO(125, 151, 245, 1),
          tertiary: Colors.black,
        ),
        canvasColor: Colors.white,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                fontSize: 18,
                fontFamily: 'RobotoCondensed',
              ),
            ),
      ),
      routes: {
        AppRoutes.HOME: (_) => TabsScreen(_favoriteMeals),
        AppRoutes.CATEGORIES_MEALS: (_) =>
            CategoriesMealScreen(_availableMeals),
        AppRoutes.MEAL_DETAIL: (_) =>
            MealDetailScreen(_toggleFavorite, _isFavorite),
        AppRoutes.SETTINGS: (_) => SettingsScreen(_filterMeals, settings),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (_) {
          return const CategoriesScreen();
        });
      },
    );
  }
}
