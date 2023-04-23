import '../models/meal.dart';

import 'package:flutter/material.dart';

class MealDetailScreen extends StatelessWidget {
  final Function(Meal) onToggleFavorite;
  final bool Function(Meal) isFavorite;

  const MealDetailScreen(this.onToggleFavorite, this.isFavorite);

  Widget _createSectionTitle(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 11),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget _createSectionContainer(Widget child) {
    return Container(
      width: 300,
      height: 200,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blueGrey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context)?.settings.arguments as Meal;
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 250,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            _createSectionTitle(context, 'Ingredientes'),
            _createSectionContainer(
              ListView.builder(
                itemCount: meal.ingredients.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Text(meal.ingredients[index]),
                    ),
                    color: Theme.of(context).colorScheme.secondary,
                  );
                },
              ),
            ),
            _createSectionTitle(context, 'Passos'),
            _createSectionContainer(
              ListView.builder(
                itemCount: meal.steps.length,
                itemBuilder: (ctx, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          foregroundColor:
                              Theme.of(context).colorScheme.primary,
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          child: Text('${index + 1}'),
                        ),
                        title: Text(meal.steps[index]),
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isFavorite(meal) ? Icons.star : Icons.star_border,
        ),
        onPressed: (() {
          onToggleFavorite(meal);
        }),
      ),
    );
  }
}
