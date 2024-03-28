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
        Keyword = NP ;
        ListKeyword = ListNP ;
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

        CardTypeLine supts ts subts = {
            s = supts.s1 ! (AgP1 Sg) ++ supts.s2 ! (AgP1 Sg) ++
                ts.ns.s1 ! Sg ! Nom ++ ts.ns.s2 ! Sg ! Nom ++
                subts.s1 ! Sg ! Nom ++ subts.s2 ! Sg ! Nom  
        } ;
            --s = supt.s ! (AAdj Posit Nom) ++ t.n.s ! Sg ! Nom ++ 
            --    "-" ++ subt.s ! Sg ! Nom ; } ;

        WhiteColor = mkColor "white" ;
        BlueColor = mkColor "blue" ;
        BlackColor = mkColor "black" ;
        RedColor = mkColor "red" ;
        GreenColor = mkColor "green" ;

        BaseSuperclass = lin ListAP {
            s1 = \\_ => ""; 
            s2 = \\_ => ""; 
            isPre = False} ;
        ConsSuperclass = mkListAP ;
        BasicSuperclass = mkAP (mkA "basic") ;
        LegendarySuperclass = mkAP (mkA "legendary") ;

        BaseClass c = lin ListClass {
            as = lin ListAP {s1 = c.a.s ; s2 = \\_ => ""; isPre = False} ;
            ns = lin ListCN {s1 = c.n.s ; s2 = \\_,_ => ""} ;
        } ;
        ConsClass c cs = {
            as = mkListAP c.a cs.as ;
            ns = mkListCN c.n cs.ns ;
        } ; 
        LandClass = mkClass "land" ;
        CreatureClass = mkClass "creature" ;
        ArtifactClass = mkClass "artifact" ;
        EnchantmentClass = mkClass "enchantment" ;
        IstantClass = mkClass "instant" ;
        SorceryClass = mkClass "sorcery" ;

        BaseSubclass = lin ListCN {s1 = \\_,_ => ""; s2 = \\_,_ => ""} ;
        ConsSubclass = mkListCN ;
        -- basic lands (more subypes to come) 
        PlainSubclass = mkCN (mkN "plain") ; -- should be "plainS" but that's dumb
        IslandSubclass = mkCN (mkN "island") ;
        SwampSubclass = mkCN (mkN "swamp") ;
        MountainSubclass = mkCN (mkN "mountain") ;
        ForestSubclass = mkCN (mkN "forest") ;     

        BasicAbility e = e ;

        BaseKeyword k1 k2 = lin ListNP {
            s1 = k1.s ;
            s2 = k2.s ;
            a = AgP1 Sg } ;
        ConsKeyword ks = mkListNP ks ;
        -- so-called "evergreen" keywords (more to come)
        -- from en.wikipedia.org/wiki/List_of_Magic:_The_Gathering_keywords
        DeathtouchKeyword = mkNP (mkPN "deathtouch") ;
        DefenderKeyword = mkNP (mkPN "defender") ;
        DoubleStrikeKeyword = mkNP (mkPN "double strike") ; 
     -- EnchantKeyword type = mkNP (mkPN ("enchant" ++ type.s ! Sg ! Nom));
     -- EquipKeyword cost = mkNP (mkPN ("equip" ++ cost)) ;
        FirstStrikeKeyword = mkNP (mkPN "first strike") ;
        FlashKeyword = mkNP (mkPN "flash") ;
        FlyingKeyword = mkNP (mkPN "flying") ;
        HasteKeyword = mkNP (mkPN "haste") ;
        HexproofKeyword = mkNP (mkPN "hexproof") ;
        IndestructibleKeyword = mkNP (mkPN "indestructible") ;
        IntimidateKeyword = mkNP (mkPN "intimidate") ;
        LifelinkKeyword = mkNP (mkPN "lifelink") ;
        MenaceKeyword = mkNP (mkPN "menace") ;
     -- ProtectionFromKeyword color = mkNP (mkPN ("protection from" ++ color.n.s ! Sg ! Nom)) ;
        ProwessKeyword = mkNP (mkPN "prowess") ;
        ReachKeyword = mkNP (mkPN "reach") ;
        ShroudKeyword = mkNP (mkPN "shroud") ;
        TrampleKeyword = mkNP (mkPN "trample") ;
        VigilanceKeyword = mkNP (mkPN "vigilance") ;

        TargetCanActionStatement trg pol act = mkS pol (mkCl trg can_VV act) ;
 
        ThisClassTarget c = mkNP this_Quant c.n ;
        CreaturesWithKeyword k = mkNP 
            (DetQuant IndefArt NumPl) 
            (mkCN (mkN2 CreatureClass.n "with") (mkNP k)) ;
        CreaturesWithKeywordsTarget ks = mkNP 
            (DetQuant IndefArt NumPl)
            (mkCN (mkN2 CreatureClass.n "with") (mkNP andOr_Conj ks)) ;
        CreaturesThatShareAColorWithIt = mkNP 
            (DetQuant IndefArt NumPl) 
            (mkCN CreatureClass.n (mkRS (mkRCl 
                that_RP 
                share_V3 
                (mkNP (DetQuant IndefArt NumSg) color_N)
                (mkNP it_Pron)))) ;
        YouTarget = youSg_Pron ;
        ClassClassesTarget c1 c2 = mkNP (DetQuant IndefArt NumPl) (mkCN c1.a c2.n) ;
        
        AttackAction = mkVP attack_V ;
        BlockAction = mkVP block_V ;
        BlockTargetAction t = mkVP block_V2 t ;
        BeBlockedAction = passiveVP block_V2 ;
        OnlyBeBlockedByTargetAction t = mkVP only_Adv (passiveVP block_V2 t) ;
        OnlyBeBlockedByTarget1AndOrTarget2Action t1 t2 = 
            mkVP only_Adv (passiveVP block_V2 (mkNP andOr_Conj t1 t2)) ;

        PositivePolarity = PPos ;
        NegativePolarity = PNeg ;

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