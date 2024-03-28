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
        TypeLine = Str ;
        TextBox = Str ;
        Stats = Str ;
        Color = {a : A; n : CN} ;

        Circle = Str ;

        Superclass = A ;
        Class = {a : A; n : CN} ;
        Subclass = CN ;

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
        ClassTypeLine c = c.n.s ! Sg ! Nom ;
        SuperTypeLine supc c = supc.s ! (AAdj Posit Nom) ++ c.n.s ! Sg ! Nom ;
        ClassSubTypeLine c subc = 
            c.n.s ! Sg ! Nom ++ "-" ++ subc.s ! Sg ! Nom ;
        SuperClassSubTypeLine supc c subc = supc.s ! (AAdj Posit Nom) 
                                         ++ c.n.s ! Sg ! Nom ++ "-"  
                                         ++ subc.s ! Sg ! Nom ;
        ClassSubsTypeLine c subc1 subc2 = c.n.s ! Sg ! Nom ++ "-" 
                                       ++ subc1.s ! Sg ! Nom 
                                       ++ subc2.s ! Sg ! Nom ; 
        ClassesSubsTypeLine c1 c2 subc = c1.n.s ! Sg ! Nom
                                      ++ c2.n.s ! Sg ! Nom ++ "-" 
                                      ++ subc.s ! Sg ! Nom ;
        SupersClassSubsTypeLine supc c subc1 subc2 = supc.s ! (AAdj Posit Nom)
                                                  ++ c.n.s ! Sg ! Nom
                                                  ++ "-" ++ subc1.s ! Sg ! Nom
                                                  ++ subc2.s ! Sg ! Nom ;
        SupersClassesSubsTypeLine supc c1 c2 subc1 subc2 =                     
            supc.s ! (AAdj Posit Nom)
         ++ c1.n.s ! Sg ! Nom        
         ++ c2.n.s ! Sg ! Nom        
         ++ "-" ++ subc1.s ! Sg ! Nom   
         ++ subc2.s ! Sg ! Nom ;     
             
        WhiteColor = mkColor "white" ;
        BlueColor = mkColor "blue" ;
        BlackColor = mkColor "black" ;
        RedColor = mkColor "red" ;
        GreenColor = mkColor "green" ;

        BasicSuperclass = mkA "basic" ;
        LegendarySuperclass = mkA "legendary" ;

        LandClass = mkClass "land" ;
        CreatureClass = mkClass "creature" ;
        ArtifactClass = mkClass "artifact" ;
        EnchantmentClass = mkClass "enchantment" ;
        IstantClass = mkClass "instant" ;
        SorceryClass = mkClass "sorcery" ;
        -- I think this is genius, why doesn't it work!?
     -- ClassClass c1 c2 = mkClass ((mkCN c1.a c2.n).s ! Sg ! Nom) ;

        -- basic lands (more subypes to come) 
        PlainSubclass = mkCN (mkN "plain") ; -- actually "plainS" but I refuse
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
     -- ProtectionFromKeyword color = 
         -- mkNP (mkPN ("protection from" ++ color.n.s ! Sg ! Nom)) ;
        ProwessKeyword = mkNP (mkPN "prowess") ;
        ReachKeyword = mkNP (mkPN "reach") ;
        ShroudKeyword = mkNP (mkPN "shroud") ;
        TrampleKeyword = mkNP (mkPN "trample") ;
        VigilanceKeyword = mkNP (mkPN "vigilance") ;

        TargetCanActionStatement trg pol act = mkS pol (mkCl trg can_VV act) ;
 
        ThisClassTarget c = mkNP this_Quant c.n ;
        CreaturesWithKeywordTarget k = mkNP 
            (DetQuant IndefArt NumPl) 
            (mkCN (mkN2 CreatureClass.n "with") k) ;
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
        ClassClassesTarget c1 c2 = 
            mkNP (DetQuant IndefArt NumPl) (mkCN c1.a c2.n) ;
        
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
        mkColor : Str -> Color = \s -> lin Color {
            a = mkA s ; 
            n = mkCN (mkN s) } ;
        
        mkClass : Str -> Class = \s -> lin Class {
            a = mkA s ; 
            n = (mkCN (mkN s)) } ;
        
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