concrete MTGEng of MTG = open 
    Prelude, 
    ResEng,
    StructuralEng,
    LangEng, 
    ConstructorsEng,
    ParadigmsEng,
    ExtraEng,
    ParamX,
    CatEng in {
    lincat
        Card = Str ;

        Name = PN ;
        ManaCost = Str ; 
        TypeLine = {s : Str} ;
        TextBox = Str ;
        Stats = Str ;
        Color = {a : A; n : N} ;

        Circle = Str ;

        Superclass = AP ;
        ListSuperclass = ListAP ;
        Class = {a : AP; n : CN} ;
        ListClass = {as : ListAP; ns : ListCN } ;
        Subclass = CN ;
        ListSubclass = ListCN ; 

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
        Land subt = 
            let tl : TypeLine = CardTypeLine basic land subt
            in subt.s ! Sg ! Nom ++ "\n" ++ tl.s ;

        CardTypeLine supts ts subts = {
            s = supts.s1 ! (AgP1 Sg) ++ supts.s2 ! (AgP1 Sg) ++
                ts.ns.s1 ! Sg ! Nom ++ ts.ns.s2 ! Sg ! Nom ++
                subts.s1 ! Sg ! Nom ++ subts.s2 ! Sg ! Nom  
        } ;
            --s = supt.s ! (AAdj Posit Nom) ++ t.n.s ! Sg ! Nom ++ 
            --    "-" ++ subt.s ! Sg ! Nom ; } ;

        white = mkColor "white" ;
        blue = mkColor "blue" ;
        black = mkColor "black" ;
        red = mkColor "red" ;
        green = mkColor "green" ;

        BaseSuperclass = lin ListAP {s1 = \\_ => ""; s2 = \\_ => ""; isPre = False} ;
        ConsSuperclass = mkListAP ;
        basic = mkAP (mkA "basic") ;
        legendary = mkAP (mkA "legendary") ;

        BaseClass c = lin ListClass {
            as = lin ListAP {s1 = c.a.s ; s2 = \\_ => ""; isPre = False} ;
            ns = lin ListCN {s1 = c.n.s ; s2 = \\_,_ => ""} ;
        } ;
        ConsClass c cs = {
            as = mkListAP c.a cs.as ;
            ns = mkListCN c.n cs.ns ;
        } ; 
        land = mkClass "land" ;
        creature = mkClass "creature" ;
        artifact = mkClass "artifact" ;
        enchantment = mkClass "enchantment" ;
        instant = mkClass "instant" ;
        sorcery = mkClass "sorcery" ;

        BaseSubclass = lin ListCN {s1 = \\_,_ => ""; s2 = \\_,_ => ""} ;
        ConsSubclass = mkListCN ;
        -- basic lands (more subypes to come) 
        plain = mkCN (mkN "plain") ; -- should be "plainS" but that's dumb
        island = mkCN (mkN "island") ;
        swamp = mkCN (mkN "swamp") ;
        mountain = mkCN (mkN "mountain") ;
        forest = mkCN (mkN "forest") ;     

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

        mkListCN : CN -> [CN] -> [CN] = \n,ns -> lin ListCN {
            s1 = n.s ;
            s2 = \\num,cas => ns.s1 ! num ! cas ++ ns.s2 ! num ! cas ; 
        };
        -- should be applicable to other languages too
        mkColor : Str -> Color = \s -> lin Color {a = mkA s ; n = mkN s} ;
        mkClass : Str -> Class = \s -> lin Class {a = (mkAP (mkA s)) ; n = (mkCN (mkN s))} ;
        
        attack_V = mkV "attack" ;
        attach_V = mkV "attach" ;
        block_V = mkV "block" ;
        share_V = mkV "share" ;

        block_V2 = mkV2 block_V ;
        share_V3 = mkV3 share_V with_Prep ;

        color_N = mkN "color" ;

        only_Adv = mkAdV "only" ;

        this_Quant = mkQuant "this" "these" ;

        andOr_Conj = mkConj "and/or" ;
}