import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class XO extends StatefulWidget {
  const XO({super.key});

  @override
  State<XO> createState() => _XOState();
}

class _XOState extends State<XO>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool player1=true;
  bool player2=false;
  bool won=false;
  
  String playerTurn="Player 1";
  List <String> list=["","","","","","","","",""];
  List <List<int>> win=[[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]];
  int compteur=0;
  
  void play(int index){
    
                if (list[index]==""){
            if(player1){
              setState(() {
                list[index]="X";
              });
              
            }else{
              setState(() {
                list[index]="O";
              });
              
            }
            for(List<int> index in win){
              if(list[index[0]]==list[index[1]] && list[index[2]]==list[index[1]] && list[index[1]]!=""){
                won=true;
                if(player1){
                  
                  showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("player 1 won",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700)),
            ));
                  print("player 1 won");
                }else{showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("player 2 won",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700)),
            ));
                  print("player 2 won");}
              }
            }
            player1=!player1;
            player2=!player2;
            compteur++;
            if (compteur==9&& won==false){ showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("Draw",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700)),
            ));}
            if(player1){
              playerTurn="Player 1";
            }
            else{
              playerTurn="Player 2";
            }
            }


  } 

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Padding(
          padding: const EdgeInsets.only(bottom:24),
          child: Text("${playerTurn} turn", style: TextStyle(fontSize: 40),),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center,children: [
          InkWell(onTap: (){
            play(0);

          },child: Ink(height: 50, width: 50, color:Colors.grey,child: Center(child: Text(list[0],style: TextStyle(fontSize: 30),))),),
          SizedBox(width: 30,),
          InkWell(onTap: (){play(1);},child: Ink(height: 50, width: 50, color:Colors.grey,child: Center(child: Text(list[1],style: TextStyle(fontSize: 30),))),),
          SizedBox(width: 30,),
          InkWell(onTap: (){play(2);},child: Ink(height: 50, width: 50, color:Colors.grey,child: Center(child: Text(list[2],style: TextStyle(fontSize: 30),))),),
          
        ],),
        SizedBox(height: 30,),
        Row(mainAxisAlignment: MainAxisAlignment.center,children: [
          InkWell(onTap: (){play(3);},child: Ink(height: 50, width: 50, color:Colors.grey,child: Center(child: Text(list[3],style: TextStyle(fontSize: 30),))),),
          SizedBox(width: 30,),
          InkWell(onTap: (){play(4);},child: Ink(height: 50, width: 50, color:Colors.grey,child: Center(child: Text(list[4],style: TextStyle(fontSize: 30),))),),
          SizedBox(width: 30,),
          InkWell(onTap: (){play(5);},child: Ink(height: 50, width: 50, color:Colors.grey,child: Center(child: Text(list[5],style: TextStyle(fontSize: 30),))),),
          
        ],),
        SizedBox(height: 30,),
        Row(mainAxisAlignment: MainAxisAlignment.center,children: [
          InkWell(onTap: (){play(6);},child: Ink(height: 50, width: 50, color:Colors.grey,child: Center(child: Text(list[6],style: TextStyle(fontSize: 30),))),),
          SizedBox(width: 30,),
          InkWell(onTap: (){play(7);},child: Ink(height: 50, width: 50, color:Colors.grey,child: Center(child: Text(list[7],style: TextStyle(fontSize: 30),))),),
          SizedBox(width: 30,),
          InkWell(onTap: (){play(8);},child: Ink(height: 50, width: 50, color:Colors.grey,child: Center(child: Text(list[8],style: TextStyle(fontSize: 30),))),),
          
        ],),
        Padding(
          padding: const EdgeInsets.only(top:32),
          child: ElevatedButton(onPressed: (){
            setState(() {
              list=["","","","","","","","",""];
               player1=true;
   player2=false;
   playerTurn="Player 1";
   compteur=0;
   won=false;
            });
          }, child: Text("Reset game")),
        )
        ],),
      ),
    );
  }
}