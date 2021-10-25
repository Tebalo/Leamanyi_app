import 'dart:async' show Future;
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
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
      //print(tag[0]);
      //print(tag.sublist(1));
      create(tag[0], tag.sublist(1), node);
    }
    return node;
  }
  Future<List<List<dynamic>>> string_to_array() async{
     String posTags = await rootBundle.loadString('assets/patterns.txt');
     posTags = posTags.replaceAll("{<", "").replaceAll("><", " ");
     List lines = posTags.split(">}");

     var patterns = [];
     for(var line in lines){
       patterns.add(line.split(" "));
     }

    return patterns;
  }
  handleLines(List<String> lines){
    for(var I in lines) log('$lines');
  }
  List<List<String>> strip_to_array(){
    //String test = await rootBundle.loadString('assets/patterns.txt');
    //print(test);
    var config = new File("assets/patterns.txt");
    config.readAsLines().then(handleLines);
    log('$config');
    String posTags = """{<CC7><CC7><VRB+ng>}
    {<CC3><CC3><VRB+ng>}
    {<C15><C15><VRB+ng>}
    {<C12><C13><VRB+ng>}
    {<C12><C13><VRB+ng>}
    {<CC9><C10><VRB+ng>}
    {<CC1><CC4><VRB+ng>}
    {<CC7><CC7><L01><VRB+ng>}
    {<CC7><CC7><ADJ8>}
    {<CC7><CC7><L02><VRB+ng>}
    {<CC7><CC7><L03><VRB+ng>}
    {<CC7><CC7><L04><CC7><VRB+ng>}
    {<CC7><CC7><L02><L05><CC7><VRB+ng>}
    {<CC7><CC7><L03><L06><CC7><VRB+ng>}
    {<CC7><CC7><L03><L06><CC7><L07><CC7><VRB+ng>}
    {<CC7><CC7><CC8><L08><CC7><VRB+ng>}
    {<CC7><CC7><L02><L01><L10><CC7><VRB+ng>}
    {<CC7><CC7><L02><L11><C15><VRB+ng>}
    {<CC5><CC5><L01><CC8><L01><L10><L12><VRB+ng>}
    {<CC7><CC7><L02><C11><VRB+ng>}
    {<CC7><CC7><CC8><L01><L10><CC7><C11><VRB+ng>}
    {<CC7><CC7><L02><L05><CC7><L02><VRB+ng>}
    {<CC7><CC7><L02><L05><CC7><L03><VRB+ng>}
    {<CC7><CC8><L01><L10><CC7><L03><CC7><VRB+ng>}
    {<CC7><CC7><CC8><L01><L10><CC7><L03><C15><VRB+ng>}
    {<CC7><CC7><L02><L13><CC7><VRB+ng>}""";

    //String texts = nl.sent_tokenize(pos_tags) as String;
    //List texts = posTags.split("\n");
    List<List<String>> tags = [["CC7","CC7","VRB+ng"],["CC3","CC3","VRB+ng"],["C15","C15","VRB+ng"],["C12","C13","VRB+ng"],["C11","C11","VRB+ng"],["CC4","CC4","VRB+ng"],["CC8","CC8","ADJ8"],["CC9","C10","VRB+ng"],["CC6","CC6","VRB+ng"],["CC1","CC4","VRB+ng"]];
    //int i = 0;
    //List<List<String>> tagset = [];
   // for(String sent in texts){
     // sent = sent.replaceAll("{<","").replaceAll(">}","").replaceAll("><"," ").replaceAll("\r"," ");
     // print(sent);
     // List<String> sents = sent.split(" ");
      //print(sents);
      //tagset.add(sents);
    //}
    //print(tagset);
    return tags;
  }
  void futureToList(List lst) async{
    lst = await strip_to_array();
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
      if(node.children.containsKey(tags.item2)){
        //print(node.children[tags.item2]);
        aMod = tagged.sublist(1,tagged.length);
        tagLea = search_trie(aMod, node);
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