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
  Node create_map(List tags){
    Node node = new Node();
    for(List tag in tags){
      //print(tag[0]);
      //print(tag.sublist(1));
      create(tag[0], tag.sublist(1), node);
    }
    return node;
  }
  Future<List<String>> string_to_array() async{
    String posTags = await rootBundle.loadString('assets/patterns.txt');
    //String texts = nl.sent_tokenize(pos_tags) as String;
    List texts = posTags.split("\n");
    List tags = [];
    for(String sent in texts){
      sent = sent.replaceAll(">}","").replaceAll("><","").replaceAll("{<","").replaceAll("\r"," ");
      List sents = sent.split(" ");
      //print(sents);
      tags.addAll(sents);
    }
    return tags;
  }
  List<List<String>> strip_to_array(){
    String posTags = """{<CC7><CC7><VRB>}
    {<CC7><CC7><L01><VRB>}
    {<CC7><CC7><ADJ8>}
    {<CC7><CC7><L02><VRB>}
    {<CC7><CC7><L03><VRB>}
    {<CC7><CC7><L04><CC7><VRB>}
    {<CC7><CC7><L02><L05><CC7><VRB>}
    {<CC7><CC7><L03><L06><CC7><VRB>}
    {<CC7><CC7><L03><L06><CC7><L07><CC7><VRB>}
    {<CC7><CC7><CC8><L08><CC7><VRB>}
    {<CC7><CC7><L02><L01><L10><CC7><VRB>}
    {<CC7><CC7><L02><L11><C15><VRB>}
    {<CC5><CC5><L01><CC8><L01><L10><L12><VRB>}
    {<CC7><CC7><L02><C11><VRB>}
    {<CC7><CC7><CC8><L01><L10><CC7><C11><VRB>}
    {<CC7><CC7><L02><L05><CC7><L02><VRB>}
    {<CC7><CC7><L02><L05><CC7><L03><VRB>}
    {<CC7><CC8><L01><L10><CC7><L03><CC7><VRB>}
    {<CC7><CC7><CC8><L01><L10><CC7><L03><C15><VRB>}
    {<CC7><CC7><L02><L13><CC7><VRB>}""";
    //String texts = nl.sent_tokenize(pos_tags) as String;
    List texts = posTags.split("\n");
    List<List<String>> tags = [["CC7","CC7","VRB+ng"],["CC3","CC3","VRB+ng"],["C15","C15","VRB+ng"],["C12","C13","VRB+ng"],["C11","C11","VRB+ng"],["CC4","CC4","VRB+ng"],["CC8","CC8","ADJ8"],["CC9","C10","VRB+ng"],["CC6","CC6","VRB+ng"],["CC1","CC4","VRB+ng"]];
    //int i = 0;
    //for(String sent in texts){
      //sent = sent.replaceAll("{<","").replaceAll(">}","").replaceAll("><"," ").replaceAll("\r"," ");
      //List<String> sents = sent.split(" ");
      //print(sents);
      //tags[i].addAll(sents);
      //i++;
    //}
    return tags;
  }
  void futureToList(List lst) async{
    lst = await strip_to_array();
  }
  String search(var tup, List arr, Node node, String identified){
    String tagg = "No leamanyi";
    if(node.children.containsKey(tup.item2)){
      node = node.children[tup.item2];
      identified+=tup.item1+" ";

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
    print(tagg);
    return tagg;
  }
  String pattern_match(List tagged, Node node){
    String tag_lea = "";
    for(var tags in tagged) {
      List a_mod = [];
      //for(int i = 0;i<tags.length;i++){
      //if(node.children.containsValue(tags[1])){
      // a_mod = tags.sublist(1,tags.length-1);
      // return search_trie(a_mod, node);
      //}
      if(node.children.containsKey(tags.item2)){
        //print(node.children[tags.item2]);
        a_mod = tagged.sublist(1,tagged.length);
        tag_lea = search_trie(a_mod, node);
      }
    //}
    }
    //print(tag_lea);
    return tag_lea;
  }

  String search_trie(List probale,Node node){
    String identified = "";
    //print(node.children["CC7"]);
    return search(probale[0], probale.sublist(1), node, identified);
  }
}