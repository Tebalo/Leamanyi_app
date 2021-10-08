// ignore_for_file: unused_local_variable

import 'package:flutter/services.dart' show rootBundle;
import 'package:validators/validators.dart';
import 'dart:async' show Future;
import 'dart:convert';
import 'dart:core';
import 'package:tuple/tuple.dart';

class Nltk{
  String tagger(Map tagset, String key){
    String pos = 'XX';
    //print(key);
    var magokedi = {
      'mo':'ADJ1',
      'ba':'ADJ1',
      'me':'ADJ3',
      'le':'ADJ4',
      'ma':'ADJ5',
      'se':'ADJ6',
      'lo':'ADJ7',
      'bo':'ADJ8',
      'go':'ADJ9',
      'di':'ADJ9'
    };
    if((tagset.containsKey(key) || tagset.containsKey(key.toLowerCase()) && key!=null) ){
      if(tagset[key] == 'ADJ' || tagset[key.toLowerCase()] == 'ADJ'){
        if((magokedi.containsKey(key.substring(0,2)) && (key.length > 2)) ||
            (magokedi.containsKey(key.toLowerCase().substring(0,2)) && (key.length > 2))){
          return magokedi[key.toLowerCase().substring(0,2)];
        }else{
          return tagset[key.toLowerCase()];
        }
      }else if(tagset[key] == 'VRB'){
        int start = key.length - 2;
        int end = key.length;

        if(key.substring(start, end) == 'ng' || key.substring(start, end) == 'NG'){
          return 'VRB+ng';
        }
      }
      return tagset[key.toLowerCase()];
    }else if(tagset.containsKey(key.toLowerCase())){
      return tagset[key.toLowerCase()];
    }else if(key == '.' || key == ','){
      return key;
    }else if(isUppercase(key.substring(0,1))){
      return 'NN';
    }else if(key.substring(0,2)=='goo' || key.substring(0,7)=='goo=rra-'){
      return 'EE1';
    }else{
      return pos;
    }
  }
  Map array_to_dictionary(List array){
    //Input: ['NN',legapu', 'lesole', 'lesedi', 'letagwa']
    //Output: {'legapu':'NN', 'lesole':'NN','lesedi':'NN','letagwa':'NN'}
    return {for(var i in array.sublist(1)) i:array[0]};
  }
  Future<Map> create_dictionary() async {
    String corpus = await rootBundle.loadString('assets/setswana_corpus.txt');
    LineSplitter ls = new LineSplitter();
    List<String> lines = ls.convert(corpus);
    Map map = new Map();
    for(var i = 0; i < lines.length; i++){
      Map new_map = array_to_dictionary(text_to_array(lines[0]));
      map = {}..addAll(map)..addAll(new_map);
    }
    return map;
  }
  Map create_dictionary1(){
    Map map = {
      "ya":"VRB",
      "itse":"VRB",
      "lemang":"VRB",
      "itse":"VRB",
      "botshelo":"NN",
      "ntlo":"NN",
      "masimo":"NN",
      "yo":"CC1",
      "gore":"CC2",
      "ba":"CC3",
      "o":"CC4",
      "e":"CC5",
      "le":"CC6",
      "a":"CC7",
      "se":"CC8",
      "tse":"CC9",
      "di":"C10",
      "lo":"C11",
      "jo":"C12",
      "bo":"C13",
      "mo":"C14",
      "go":"C15",
      "ka":"L01",
      "sa":"L02",
      "tla":"L03",
      "neng":"L04",
      "ntseng":"L05",
      "bong":"L06",
      "santse":"L07",
      "kitlang":"L08",
      "keng":"L10",
      "bolong":"L11",
      "ya":"L12",
      "nkeng":"L13",
      "setseng":"L14",
      "nang":"L15",
      "leng":"L16",
      "tlholang":"L17",
      "ntse":"L18",
      "kitla":"L19",
      "na":"L20",
      "nale":"L21",
      "tsa":"L22",
      "jaaka":"L23",
      "kwa":"L24",
      "fa":"L25",
      "kgotsa":"L26",
      "jwa":"L27",
      "ke":"L28",
      "la":"L29",
      "me":"L30",
      "ga":"L31",
      "wa":"L31",
      "lwa":"L32",
      "kapa":"L33",
      "gago":"L34",
      "gagwe":"L35",
      "kileng":"L36",
      "jaanong":"L37",
      "jaana":"L38",
      "re":"L39",
      "reng":"L40",
      "fela":"L41",
      "bogompienong":"L42",
      "mme":"L43",
      "ne":"L44",
      "bolo":"L45"
    };
    //LineSplitter ls = new LineSplitter();
    //List<String> lines = ls.convert(corpus);
    //Map map = new Map();
    //for(var i = 0; i < lines.length; i++){
      //Map new_map = array_to_dictionary(text_to_array(lines[0]));
      //map = {}..addAll(map)..addAll(new_map);
    //}
    //print(map);
    return map;
  }
  List text_to_array(String line){
    return line.split(".");
  }
  Map array0_to_map(List array){
    //Input: ['NN',legapu', 'lesole', 'lesedi', 'letagwa']
    //Output: {'legapu':'NN', 'lesole':'NN','lesedi':'NN','letagwa':'NN'}
    return {for(var i in array.sublist(1)) i:array[0]};
  }
  List pos_tagger(List sent){
    Map tagset = create_dictionary1() as Map;
    List tagged = <Tuple2<String, String>>[];
    List words = sent;

    for(String word in words){
      String tag = tagger(tagset,word);
      Tuple2 t = Tuple2<String,String>(word, tag);
      tagged.add(t);
    }
    return tagged;
  }
  List tag(String paragraph){
    List tagged = [];
    List tagged_sent = [];
    List tokenized_sent = [];
    List sents = sent_tokenize(paragraph);

    for(String sent in sents){
      tokenized_sent = word_tokenize(sent);
      tagged_sent = pos_tagger(tokenized_sent);
      //print(tagged_sent);
      tagged.add(tagged_sent);
    }
    return tagged_sent;
  }
  List word_tokenize(String sent){
    List words = sent.split(" ");
    return words;
  }
  List sent_tokenize(String paragraph){
    paragraph = paragraph.replaceAll(".", "");
    List sents = paragraph.split(". ");
    return sents;
  }
}