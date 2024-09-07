import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:cached_network_image/cached_network_image.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

late List pokedex = [];
Color? color(index){
  Color? setColor;
  switch (pokedex[index]["type"][0]){

    case "Grass" : setColor = const Color.fromARGB(148, 4, 168, 78);

    break;

    case"Fire" : setColor = const Color.fromARGB(207, 161, 13, 13);

    break;

    case "Poison" : setColor = const Color.fromARGB(255, 79, 25, 88);

    break;

    case "Ice" : setColor = const Color.fromARGB(255, 49, 147, 196);

    break;

    case "Flying" : setColor = const Color.fromARGB(255, 159, 204, 218);

    break;

    case "Psychic" : setColor = const Color.fromARGB(255, 179, 34, 118);

    break;

    case "Electric" : setColor = const Color.fromARGB(255, 253, 234, 63);

    break;

    case "Rock" : setColor = const Color.fromARGB(255, 61, 55, 48);

    break;

    case "Bug" : setColor = const Color.fromARGB(255, 44, 107, 1);

    break;

    case "Ground" : setColor = const Color.fromARGB(255, 145, 112, 62);

    break;

    case "Fighting" : setColor = const Color.fromARGB(255, 88, 29, 21);

    break;

    case "Steel" : setColor = const Color.fromARGB(158, 255, 255, 255);

    break;

    case "Normal" : setColor = const Color.fromARGB(255, 137, 172, 212);

    break;

    case "Water" : setColor = const Color.fromARGB(255, 4, 5, 95);

    break;

    case "Dragon" : setColor = const Color.fromARGB(255, 62, 42, 94);

    break;

    case "Fairy" : setColor = const Color.fromARGB(255, 221, 62, 155);

    break;

    case "Ghost" : setColor = const Color.fromARGB(255, 95, 35, 107);

    default : setColor = const Color.fromARGB(255, 85, 53, 72);
  }
  return setColor;

}
  @override
void initState(){
  super.initState();
  if(mounted){
  fetchPokeapi();
  }
}
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: width,
        height: height,

        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 128, 64, 48),
            Color.fromARGB(255, 0, 0, 0)
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft
          )),
          child: Stack(
            children: [
              Positioned(
                top: -50,
                right: -50,
                child: Image.asset('assets/transparente.png',
                width: 170,
                fit: BoxFit.fitWidth,)),

                Positioned(
                  top: 100,
                  left: 20,
                  child: Text('Pokedex',
                  style: TextStyle(
                  color: Colors.black12.withOpacity(.6),
                  fontWeight: FontWeight.bold,
                  fontSize: 30
                ),)),
                Positioned(
                  top: 150,
                  bottom: 0,
                  width: width,
                  child: Column(
                    children: [
                      pokedex != null ?

                      Expanded(child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3/5


                        ),
                          itemCount: pokedex.length,
                        itemBuilder: (context, index){
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                              child: InkWell(
                                child: SafeArea(
                                  child: Stack(
                                    children: [
                                      Container(

                                        width: width,
                                        margin: const EdgeInsets.only(top: 80),
                                        decoration: const BoxDecoration(
                                          color: Colors.black26,
                                          borderRadius: BorderRadius.all(Radius.circular(25)
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                          top: 90,
                                          left: 15,
                                          child: Text(pokedex
                                          [index]["num"],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black87
                                          ),)),

                                          Positioned(
                                          top: 130,
                                          left: 15,
                                          child: Text(pokedex
                                          [index]["name"],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.white54
                                          ),)),
                                          Positioned(
                                            top: 170,
                                            left: 15,
                                            child: Container(
                                              padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                                              decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                color: Colors.black.withOpacity(0.5)
                                              ),
                                              child: Text(pokedex[index]["type"][0],
                                              style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: color(index)
                                              ),),
                                            ))]
                                      )
                                      ),
                                      Container(
                                        alignment: Alignment.topCenter,
                                        child: CachedNetworkImage(
                                          imageUrl: pokedex[index]["img"],
                                          height: 180,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              );
                        },
                      ))
                      : const Center(child: CircularProgressIndicator()),

                    ],
                  ))
            ],
          ),
      ),
    );
  }

void fetchPokeapi(){
  var url = Uri.https('raw.githubusercontent.com', 
      '/Biuni/PokemonGO-Pokedex/master/pokedex.json');

      http.get(url).then((value){
        if(value.statusCode==200){
          var data = jsonDecode(value.body);
          pokedex = data['pokemon'];
          setState(() {});
          if (kDebugMode) {
            print(pokedex);
          }
        }
      }).catchError((e){
        if (kDebugMode) {
          print(e);
        }
      });
}
}