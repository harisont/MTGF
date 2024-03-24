concrete MTGEng of MTG = open 
    Prelude, 
    ResEng,
    StructuralEng,
    LangEng, 
    ConstructorsEng,
    ParadigmsEng,
    ParamX in {
    lincat
        Card = Str ;

        Name = PN ;
        ManaCost = Str ; 
        TypeLine = {s : Str} ;
        TextBox = Str ;
        Stats = Str ;
        Color = {a : A; n : N} ;

        Circle = Str ;

        Superclass = A ;
        Class = N ;
        Subclass = N ;

        Ability = Text ;
        Flavor = Str ; -- should be Text, using Str as it is unconstrained

        Power = Decimal ;
        Toughness = Decimal ;

        ActivationCost = Str ;
        Keyword = PN ;
        Explanation = Text ;

        Tap = Bool ;

        Statement = S ;
        Command = Imp ;

        Trigger = Cl ;
        Action = VP ;
        Condition = Cl ;

        Target = NP ;

        Polarity = Pol ;
    
    lin
        basicLand subt = 
            let tl : TypeLine = typeLine basic land subt
            in subt.s ! Sg ! Nom ++ "\n" ++ tl.s ;

        typeLine supt t subt = {
            s = supt.s ! (AAdj Posit Nom) ++ t.s ! Sg ! Nom ++ 
                "-" ++ subt.s ! Sg ! Nom ; } ;

        white = mkColor "white" ;
        blue = mkColor "blue" ;
        black = mkColor "black" ;
        red = mkColor "red" ;
        green = mkColor "green" ;

        basic = mkA "basic" ;
        legendary = mkA "legendary" ;

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

        ability e = e ;

        -- so-called "evergreen" keywords (more to come)
        -- from en.wikipedia.org/wiki/List_of_Magic:_The_Gathering_keywords
        deathtouch = mkPN "deathtouch" ;
        defender = mkPN "defender" ;
        doubleStrike = mkPN "double strike" ; 
     -- enchant type = mkPN ("enchant" ++ type.s ! Sg ! Nom);
     -- equip cost = mkPN ("equip" ++ cost) ;
        firstStrike = mkPN "first strike" ;
        flash = mkPN "flash" ;
        flying = mkPN "flying" ;
        haste = mkPN "haste" ;
        hexproof = mkPN "hexproof" ;
        indestructible = mkPN "indestructible" ;
        lifelink = mkPN "lifelink" ;
        menace = mkPN "menace" ;
     -- protectionFrom color = 
     --     mkPN ("protection from" ++ color.n.s ! Sg ! Nom) ;
        prowess = mkPN "prowess" ;
        reach = mkPN "reach" ;
        trample = mkPN "trample" ;
        vigilance = mkPN "vigilance" ;

        oneStatementExplanation s = mkText (mkUtt s) ;

        targetCanAction trg pol act = mkS pol (mkCl trg can_VV act) ;
 
        thisCreature = mkNP (mkQuant "this" "these") (creatureN) ;
        creaturesWithKeyword a = mkNP 
            (DetQuant IndefArt NumPl) 
            (mkCN (mkN2 creatureN "with") (mkNP a));
        you = youSg_Pron ;

        attack = mkVP (mkV "attack") ;
        block = mkVP blockV ;
        blockTarget t = mkVP blockV2 t ;
        beBlocked = passiveVP blockV2 ;
        beBlockedByTarget t = passiveVP blockV2 t ;

        positive = PPos ;
        negative = PNeg ;

    oper
        -- should be applicable to other languages too
        mkColor : Str -> Color = \s -> lin Color {a = mkA s ; n = mkN s} ;
        
        creatureN = mkN "creature" ;
        blockV = mkV "block" ;
        blockV2 = mkV2 blockV ;
}