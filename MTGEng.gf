concrete MTGEng of MTG = open Prelude, CatEng, ParadigmsEng in {
    lincat
        Card = Str ;

        Name = NP ; -- not always NP but used that way in effect descriptions
        ManaCost = Str ; 
        TypeLine = Str ;
        TextBox = Str ;
        Stats = Str ;

        Circle = Str ;
        Superclass = A ;
        Class = N ;
        Subclass = N ;
        Effect = Text ;
        Flavor = Text ;
        Power = Decimal ;
        Toughness = Decimal ;

        Color = A ;
        ActivationCost = Str ;
        Keyword = NP ; -- used as NP way in effect descriptions (?)
        Explanation = Text ;

        Tap = Bool ;
    
    lin
        -- supertypes
        basic = mkA "basic" ;
        legendary = mkA "legendary" ;
        -- types
        land = mkN "land" ;
        creature = mkN "creature" ;
        artifact = mkN "artifact" ;
        enchantment = mkN "enchantment" ;
        instant = mkN "instant" ;
        sorcery = mkN "sorcery" ;

        -- colors
        white = mkA "white" ;
        blue = mkA "blue" ;
        black = mkA "black" ;
        red = mkA "red" ;
        green = mkA "green" ;
}