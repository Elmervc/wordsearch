application exampleapp

description {
  Word search
}

imports search/searchconfiguration

section pages

define page root() {
  var query := "";

  title{"Phonetic matching / Stemming demo"}
  <h1>"See which English words will match by different phonetic and stemming analyzers:"</h1>

  if( (select count(t) from Term as t) < 1){
    navigate addWords() { "add words" }
  }

  form{
      "query:"input(query)<br />
      submit showResults(query)[ajax]{"see matches"}
  }

  action showResults(q : String){
      replace(results, results(q));
  }

  placeholder results{}
  gAnalytics
}

define ajax results(query : String){
    var fields : List<String> := getFields();

    table{
        row{
            for (fld : String in fields){
              column{ <b>output(fld)</b> }
            }
        }
        row{
            for (fld : String in fields){
              displayFieldResults(query, fld)
            }
        }
    }

}

define displayFieldResults(query : String, field : String){
    var searcher := search Term matching ~field:+query limit 100 [no lucene];
    column[valign="top"]{
      <i>output(searcher.luceneQuery())</i>
      list{
        for(t : Term in searcher.results()) {
          listitem{output(t)}
        }
      }
    }
}
function getFields() : List<String> {
    return ["snowballEnglish", "kStem", "minimalStem","hunspell_openOffice_EN_US", "metaphone", "doubleMetaphone", "soundex", "refinedSoundex", "caverphone"];
}

define page addWords(){
    var toAdd : Text;
    var splitted : List<String>;

    form{
      submit addAllEnglishWords(){"Add default english word list"} <br /> <br />
      input(toAdd){"Enter words seperated by new line"} <br />
      submit addWords(toAdd){"Add"} <br />
      submit deleteAllTerms(){"Delete all existing terms"} <br />
      submit action{ IndexManager.reindex(); }{"Rebuild search index"} <br />
    }

    action addAllEnglishWords(){
       var currentList : List<String>;
        for( i : Int from 1 to 26 ){
           currentList := Words.get(i);
           storeWordsAsTerms(currentList);
        }
        return root();
    }
    action addWords(toAdd : Text){
        splitted := (toAdd as String).split("\n");
        storeWordsAsTerms(splitted);
        return root();
    }
    action deleteAllTerms(){
        for(t : Term){
          t.delete();
        }
        return root();
    }

    navigate root(){"go back"}
}

function storeWordsAsTerms(splitted : List<String>){

        log("length: " + splitted.length);
        for(w : String in splitted) {
            Term{value:=w}.save();
        }
}
entity Term {
  value :: String (name)

  search mapping{
      value using KeywordLowered  as orig
      value using DoubleMetaphone as doubleMetaphone
      value using Metaphone       as metaphone
      value using Soundex         as soundex
      value using RefinedSoundex  as refinedSoundex
      value using Caverphone      as caverphone
      value using snowballporter  as snowballEnglish
      value using kStem           as kStem
      value using minimalStem     as minimalStem
      value using hunspell        as hunspell_openOffice_EN_US
  }
}

native class Words{
  static get(Int) : List<String>
}

define gAnalytics(){
  <script type="text/javascript">

      var _gaq = _gaq || [];
      _gaq.push(['_setAccount', 'UA-36484787-1']);
      _gaq.push(['_trackPageview']);

      (function() {
        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
      })();

  </script>
}
