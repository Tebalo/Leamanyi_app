import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:leamanyi_app/nltoolkit/nltk.dart';

class Node{
  Map children;
  bool isLast;
  Node(){
    this.children = {};
    this.isLast = false;
  }
}
class Trie{
  Nltk nl;
  void create(String tag, List tags, Node node){
    if(node.children.containsKey(tag)){
      node = node.children[tag];
      if(tags.length >=1){
        create(tags[0], tags.sublist(1), node);
      }
    }else{
      node.children[tag] = Node();
      node = node.children[tag];

      if(tags.length >=1){
        create(tags[0], tags.sublist(1), node);
      }
      if(tags.length==0){
        node.isLast = true;
      }
    }
  }
  Node create_map(List<List<String>> tags){
    Node node = new Node();
    print(tags);
    for(List<String> tag in tags){
      create(tag[0], tag.sublist(1), node);
    }
    return node;
  }
  Future<List<List<dynamic>>> string_to_array() async{
     String posTags = await rootBundle.loadString('assets/patterns.txt');
     posTags = posTags.replaceAll("{<", "").replaceAll("><", " ");
     List lines = posTags.split(">}");

     var patterns;
     for(var line in lines){
       patterns.add(line.split(" "));
     }
    return patterns;
  }

  String search(var tup, List arr, Node node, String identified){
    String tagg = "No leamanyi";
    if(node.children.containsKey(tup.item2)){
      node = node.children[tup.item2];
      identified+=tup.item2+" ";

      if(arr.length >=1){
        tagg = search(arr[0], arr.sublist(1), node, identified);
      }
      if(arr.length==0 && node.isLast==true){
        print("("+identified.trimRight()+")/Leamanyi");
        tagg =  "("+identified.trimRight()+")/Leamanyi";
      }else if(node.isLast==true){
        print("("+identified.trimRight()+")/Leamanyi");
        tagg = "("+identified.trimRight()+")/Leamanyi";
      }
    }
    return tagg;
  }
  String pattern_match(List tagged, Node node){
    String tagLea = "";
    for(var tags in tagged) {
      List aMod = [];
      //for(int i = 0;i<tags.length;i++){
      //if(node.children.containsValue(tags[1])){
      // a_mod = tags.sublist(1,tags.length-1);
      // return search_trie(a_mod, node);
      //}
      if(node.children!=null) {
        if (node.children.containsKey(tags.item2)) {
          //print(node.children[tags.item2]);
          aMod = tagged.sublist(1, tagged.length);
          tagLea = search_trie(aMod, node);
        }
      }
    //}
    }
    //print(tag_lea);
    return tagLea;
  }

  String search_trie(List probale,Node node){
    String identified = "";
    //print(node.children["CC7"]);
    return search(probale[0], probale.sublist(1), node, identified);
  }
}