concrete MTGEng of MTG = open 
    Prelude, 
    ResEng,
    LangEng, 
    ConstructorsEng,
    ParadigmsEng,
    ParamX in {
    lincat
        Card = Str ;

        Name = NP ; -- not always NP but used that way in effect descriptions
        ManaCost = Str ; 
        TypeLine = {s : Str} ;
        TextBox = Str ;
        Stats = Str ;

        Circle = Str ;
        Superclass = A ;
        Class = N ;
        Subclass = N ;
        Effect = Text ;
        Flavor = Str ; -- should be Text, using Str as it is unconstrained
        Power = Decimal ;
        Toughness = Decimal ;

        Color = {a : A; n : N} ;
        ActivationCost = Str ;
        Keyword = Utt ; -- often NP-like but not always
        Explanation = Text ;

        Tap = Bool ;
    
    lin
        -- doesn't work!
      basicLand subt = 
        let tl : TypeLine = typeLine basic land subt
        in subt.s ! Sg ! Nom ++ "\n" ++ tl.s ;

        typeLine supt t subt = {
            s = supt.s ! (AAdj Posit Nom) ++ t.s ! Sg ! Nom ++ 
                "-" ++ subt.s ! Sg ! Nom ; } ;

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

        -- basic lands (more subypes to come) 
        plain = mkN "plain" ; -- should be "plainS" but that's dumb
        island = mkN "island" ;
        swamp = mkN "swamp" ;
        mountain = mkN "mountain" ;
        forest = mkN "forest" ;        

        -- colors
        white = mkColor "white" ;
        blue = mkColor "blue" ;
        black = mkColor "black" ;
        red = mkColor "red" ;
        green = mkColor "green" ;

        -- so-called "evergreen" keywords (more to come)
        -- from en.wikipedia.org/wiki/List_of_Magic:_The_Gathering_keywords
        deathtouch = mkUtt (mkNP (mkN "deathtouch")) ;
        defender = mkUtt (mkNP (mkN "defender")) ;
        doubleStrike = mkUtt (mkNP (mkCN (mkAP (mkA "double")) strike)) ; 
        enchant type = mkUtt (mkImp (mkV2 "enchant") (mkNP type));
        --equip cost = mkUtt (mkImp (mkV2 "equip") (mkNP (mkN cost))) ;
        firstStrike = mkUtt (mkNP (mkCN (mkAP (mkA "first")) strike)) ;
        flash = mkUtt (mkNP (mkN "flash")) ;
        flying = mkUtt (mkNP (mkN "flying")) ;
        haste = mkUtt (mkNP (mkN "haste")) ;
        hexproof = mkUtt (mkNP (mkN "hexproof")) ;
        indestructible = mkUtt (mkAP (mkA "indestructible")) ;
        lifelink = mkUtt (mkNP (mkN "lifelink")) ;
        menace = mkUtt (mkImp (mkV "menace")) ;
        protectionFrom color = mkUtt (mkNP (mkCN 
                                        (mkN2 (mkN "protection") "from") 
                                        (mkNP (color.n)))) ;
        prowess = mkUtt (mkNP (mkN "prowess")) ;
        reach = mkUtt (mkNP (mkN "reach")) ;
        trample = mkUtt (mkNP (mkN "trample")) ;
        vigilance = mkUtt (mkNP (mkN "vigilance")) ;
    
    oper
        -- should be applicable to other languages too
        mkColor : Str -> Color = \s -> lin Color {a = mkA s ; n = mkN s} ;
        
        strike = mkN "strike" ;
}