module search/searchconfiguration

section search analyzers

default analyzer standard {
    tokenizer = StandardTokenizer
    token filter = StandardFilter
    token filter = LowerCaseFilter
    token filter = StopFilter
}

analyzer kStem{
        tokenizer = StandardTokenizer
        token filter = StandardFilter
        token filter = LowerCaseFilter
        token filter = StopFilter
        token filter = KStemFilter
}

analyzer minimalStem{
        tokenizer = StandardTokenizer
        token filter = StandardFilter
        token filter = LowerCaseFilter
        token filter = StopFilter
        token filter = EnglishMinimalStemFilter
}

analyzer hunspell{
        tokenizer = StandardTokenizer
        token filter = LowerCaseFilter
        token filter = StopFilter
        token filter = HunspellStemFilter(dictionary="analyzerfiles/en_US.dic", affix="analyzerfiles/en_US.aff") //see http://lucene.apache.org/solr/api/org/apache/solr/analysis/HunspellStemFilterFactory.html for available parameters
}

analyzer standard_no_stop{
    tokenizer = StandardTokenizer
    token filter = StandardFilter
    token filter = LowerCaseFilter
}

analyzer standard_custom_stop{
    tokenizer = StandardTokenizer
    token filter = StandardFilter
    token filter = LowerCaseFilter
    token filter = StopFilter (words="analyzerfiles/stopwords.txt")
}

analyzer synonym{
    index{
        tokenizer = StandardTokenizer
        token filter = StandardFilter
        token filter = SynonymFilter(ignoreCase="true", expand="true", synonyms="analyzerfiles/synonyms.txt")
        token filter = LowerCaseFilter
        token filter = StopFilter (words="analyzerfiles/stopwords.txt")
    }
    query{
        tokenizer = StandardTokenizer
        token filter = StandardFilter
        token filter = LowerCaseFilter
        token filter = StopFilter (words="analyzerfiles/stopwords.txt")
    }
}

analyzer trigram{
    tokenizer = StandardTokenizer
    token filter = LowerCaseFilter
    token filter = StopFilter()
    token filter = NGramFilter(minGramSize = "3", maxGramSize = "3")
}

analyzer autocomplete_untokenized{
    tokenizer = KeywordTokenizer
    token filter = LowerCaseFilter
}

analyzer snowballporter{
    tokenizer = StandardTokenizer
    token filter = StandardFilter
    token filter = LowerCaseFilter
    token filter = StopFilter
    token filter = SnowballPorterFilter(language="English")
}

analyzer phonetic{
    tokenizer = StandardTokenizer
    token filter = StandardFilter
    token filter = LowerCaseFilter
    token filter = PhoneticFilter(encoder = "RefinedSoundex")
}

analyzer DoubleMetaphone{
    tokenizer = WhitespaceTokenizer
    token filter = LowerCaseFilter
    token filter = PhoneticFilter(encoder="DoubleMetaphone", inject="true")
}

analyzer Metaphone{
    tokenizer = WhitespaceTokenizer
    token filter = LowerCaseFilter
    token filter = PhoneticFilter(encoder="Metaphone", inject="true")
}

analyzer Soundex{
    tokenizer = WhitespaceTokenizer
    token filter = LowerCaseFilter
    token filter = PhoneticFilter(encoder="Soundex", inject="true")
}
analyzer RefinedSoundex{
    tokenizer = WhitespaceTokenizer
    token filter = LowerCaseFilter
    token filter = PhoneticFilter(encoder="RefinedSoundex", inject="true")
}
analyzer Caverphone{
    tokenizer = WhitespaceTokenizer
    token filter = LowerCaseFilter
    token filter = PhoneticFilter(encoder="Caverphone", inject="true")
}

analyzer KeywordLowered{
    tokenizer = KeywordTokenizer
    token filter = LowerCaseFilter
}

