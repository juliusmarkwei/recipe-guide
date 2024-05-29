// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:recipies_app/services/data_service.dart';
import 'package:recipies_app/models/recipe.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String mealTypeFilter = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RecipeBook'),
        centerTitle: true,
      ),
      body: SafeArea(child: _buildUI()),
    );
  }

  Widget _buildUI() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          _recipeTypedButton(),
          _recipesList(),
        ],
      ),
    );
  }

  Widget _recipeTypedButton() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.05,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: () => setState(() => mealTypeFilter = 'snack'),
              child: const Text('🍊 Snack'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: () => setState(() => mealTypeFilter = 'breakfast'),
              child: const Text('🥕 Breakfast'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: () => setState(() => mealTypeFilter = 'lunch'),
              child: const Text('🍌 Lunch'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: () => setState(() => mealTypeFilter = 'dinner'),
              child: const Text('🍓 Dinner'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _recipesList() {
    return Expanded(
      child: FutureBuilder(
        future: DataService().getRecipes(mealTypeFilter),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Center(child: CircularProgressIndicator()));
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              if (snapshot.data == null) return const SizedBox();
              Recipe recipe = snapshot.data![index];
              return ListTile(
                onTap: () {},
                contentPadding: EdgeInsets.only(top: 20),
                isThreeLine: true,
                subtitle: Text(
                  "${recipe.cuisine}\nDifficulty: ${recipe.difficulty}",
                  style: TextStyle(color: Colors.grey),
                ),
                leading: Image.network(
                  recipe.image,
                  width: 50,
                  height: 70,
                ),
                trailing: Text(
                  '${recipe.rating.toString()} ⭐️',
                  style: TextStyle(fontSize: 15),
                ),
                title: Text(recipe.name),
                // subtitle: Text(snapshot.data![index].instructions),
              );
            },
          );
        },
      ),
    );
  }
}
