concrete MTGEng of MTG = open 
    Prelude, 
    ResEng,
    StructuralEng,
    LangEng, 
    ConstructorsEng,
    ParadigmsEng,
    ExtraEng,
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
        Class = {a : A; n : N} ;
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
            s = supt.s ! (AAdj Posit Nom) ++ t.n.s ! Sg ! Nom ++ 
                "-" ++ subt.s ! Sg ! Nom ; } ;

        white = mkColor "white" ;
        blue = mkColor "blue" ;
        black = mkColor "black" ;
        red = mkColor "red" ;
        green = mkColor "green" ;

        basic = mkA "basic" ;
        legendary = mkA "legendary" ;

        land = mkClass "land" ;
        creature = mkClass "creature" ;
        artifact = mkClass "artifact" ;
        enchantment = mkClass "enchantment" ;
        instant = mkClass "instant" ;
        sorcery = mkClass "sorcery" ;

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
 
        thisClass c = mkNP this_Quant c.n ;
        creaturesWithKeyword k = mkNP 
            (DetQuant IndefArt NumPl) 
            (mkCN (mkN2 creature.n "with") (mkNP k));
        creaturesWithKeyword1AndOrKeyword2 k1 k2 = mkNP 
            (DetQuant IndefArt NumPl) 
            (mkCN 
                (mkN2 creature.n "with") 
                (mkNP andOr_Conj (mkNP k1) (mkNP k2)));
        you = youSg_Pron ;
        classClasses c1 c2 = mkNP (DetQuant IndefArt NumPl) (mkCN c1.a c2.n) ;
        creaturesThatShareAColorWithIt = mkNP 
            (DetQuant IndefArt NumPl) 
            (mkCN creature.n (mkRS (mkRCl 
                that_RP 
                share_V3 
                (mkNP (DetQuant IndefArt NumSg) color_N)
                (mkNP it_Pron)))) ;
        
        attack = mkVP attack_V ;
        block = mkVP block_V ;
        blockTarget t = mkVP block_V2 t ;
        beBlocked = passiveVP block_V2 ;
        onlyBeBlockedByTarget t = mkVP only_Adv (passiveVP block_V2 t) ;
        onlyBeBlockedByTarget1AndOrTarget2 t1 t2 = 
            mkVP only_Adv (passiveVP block_V2 (mkNP andOr_Conj t1 t2)) ;

        positive = PPos ;
        negative = PNeg ;

    oper
        -- should be applicable to other languages too
        mkColor : Str -> Color = \s -> lin Color {a = mkA s ; n = mkN s} ;
        mkClass : Str -> Class = \s -> lin Class {a = mkA s ; n = mkN s} ;
        
        attack_V = mkV "attack" ;
        attach_V = mkV "attach" ;
        block_V = mkV "block" ;
        share_V = mkV "share" ;

        block_V2 = mkV2 block_V ;
        share_V3 = mkV3 share_V with_Prep ;

        color_N = mkN "color" ;

        only_Adv = mkAdv "only" ;

        this_Quant = mkQuant "this" "these" ;

        andOr_Conj = mkConj "and/or" ;
}