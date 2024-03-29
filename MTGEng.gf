concrete MTGEng of MTG = ConjunctionEng-[Card] ** open 
  Prelude,
  ParamX,
    (Res=ResEng),
--    LangEng, 
  --    ConstructorsEng,
  (Conjunction=ConjunctionEng),
  (Paradigms=ParadigmsEng),
  SyntaxEng,
  ExtraEng
  in {
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
        ListKeyword = Conjunction.ListNP ;
        Explanation = Text ;

        Tap = Bool ;

        Statement = S ;
        Command = Imp ;

        Trigger = Adv ;
        Action = VP ;
        Condition = Cl ;

        Target = NP ;
--	ListCN = Conjunction.ListCN;

    lin
        ClassTypeLine c = c.n.s ! Sg ! Res.Nom ;
        SuperTypeLine supc c = supc.s ! (Res.AAdj Posit Res.Nom) ++ c.n.s ! Sg ! Res.Nom ;
        ClassSubTypeLine c subc = 
            c.n.s ! Sg ! Res.Nom ++ "-" ++ subc.s ! Sg ! Res.Nom ;
        SuperClassSubTypeLine supc c subc = supc.s ! (Res.AAdj Posit Res.Nom) 
                                         ++ c.n.s ! Sg ! Res.Nom ++ "-"  
                                         ++ subc.s ! Sg ! Res.Nom ;
        ClassSubsTypeLine c subc1 subc2 = c.n.s ! Sg ! Res.Nom ++ "-" 
                                       ++ subc1.s ! Sg ! Res.Nom 
                                       ++ subc2.s ! Sg ! Res.Nom ; 
        ClassesSubsTypeLine c1 c2 subc = c1.n.s ! Sg ! Res.Nom
                                      ++ c2.n.s ! Sg ! Res.Nom ++ "-" 
                                      ++ subc.s ! Sg ! Res.Nom ;
        SupersClassSubsTypeLine supc c subc1 subc2 = supc.s ! (Res.AAdj Posit Res.Nom)
                                                  ++ c.n.s ! Sg ! Res.Nom
                                                  ++ "-" ++ subc1.s ! Sg ! Res.Nom
                                                  ++ subc2.s ! Sg ! Res.Nom ;
        SupersClassesSubsTypeLine supc c1 c2 subc1 subc2 =                     
            supc.s ! (Res.AAdj Posit Res.Nom)
         ++ c1.n.s ! Sg ! Res.Nom        
         ++ c2.n.s ! Sg ! Res.Nom        
         ++ "-" ++ subc1.s ! Sg ! Res.Nom   
         ++ subc2.s ! Sg ! Res.Nom ;     
             
        WhiteColor = mkColor "white" ;
        BlueColor = mkColor "blue" ;
        BlackColor = mkColor "black" ;
        RedColor = mkColor "red" ;
        GreenColor = mkColor "green" ;

        BasicSuperclass = Paradigms.mkA "basic" ;
        LegendarySuperclass = Paradigms.mkA "legendary" ;

        LandClass = mkClass "land" ;
        CreatureClass = mkClass "creature" ;
        ArtifactClass = mkClass "artifact" ;
        EnchantmentClass = mkClass "enchantment" ;
        IstantClass = mkClass "instant" ;
        SorceryClass = mkClass "sorcery" ;
        -- I think this is genius, why doesn't it work!?
     -- ClassClass c1 c2 = mkClass ((mkCN c1.a c2.n).s ! Sg ! Res.Nom) ;

        -- basic lands (more subypes to come) 
        PlainSubclass = mkCN (Paradigms.mkN "plain") ; -- actually "plainS" but I refuse
        IslandSubclass = mkCN (Paradigms.mkN "island") ;
        SwampSubclass = mkCN (Paradigms.mkN "swamp") ;
        MountainSubclass = mkCN (Paradigms.mkN "mountain") ;
        ForestSubclass = mkCN (Paradigms.mkN "forest") ;     

        BasicAbility e = e ;

        BaseKeyword k1 k2 = lin ListNP {
            s1 = k1.s ;
            s2 = k2.s ;
            a = Res.AgP1 Sg } ;
        ConsKeyword ks = mkListNP ks ;
        -- so-called "evergreen" keywords (more to come)
        -- from en.wikipedia.org/wiki/List_of_Magic:_The_Gathering_keywords
        DeathtouchKeyword = mkNP (Paradigms.mkPN "deathtouch") ;
        DefenderKeyword = mkNP (Paradigms.mkPN "defender") ;
        DoubleStrikeKeyword = mkNP (Paradigms.mkPN "double strike") ; 
     -- EnchantKeyword type = mkNP (Paradigms.mkPN ("enchant" ++ type.n.s ! Sg ! Res.Nom));
     -- EquipKeyword cost = mkNP (Paradigms.mkPN ("equip" ++ cost)) ;
        FirstStrikeKeyword = mkNP (Paradigms.mkPN "first strike") ;
        FlashKeyword = mkNP (Paradigms.mkPN "flash") ;
        FlyingKeyword = mkNP (Paradigms.mkPN "flying") ;
        HasteKeyword = mkNP (Paradigms.mkPN "haste") ;
        HexproofKeyword = mkNP (Paradigms.mkPN "hexproof") ;
        IndestructibleKeyword = mkNP (Paradigms.mkPN "indestructible") ;
        IntimidateKeyword = mkNP (Paradigms.mkPN "intimidate") ;
        LifelinkKeyword = mkNP (Paradigms.mkPN "lifelink") ;
        MenaceKeyword = mkNP (Paradigms.mkPN "menace") ;
     -- ProtectionFromKeyword color = 
         -- mkNP (mkPN ("protection from" ++ color.n.s ! Sg ! Res.Nom)) ;
        ProwessKeyword = mkNP (Paradigms.mkPN "prowess") ;
        ReachKeyword = mkNP (Paradigms.mkPN "reach") ;
        ShroudKeyword = mkNP (Paradigms.mkPN "shroud") ;
        TrampleKeyword = mkNP (Paradigms.mkPN "trample") ;
        VigilanceKeyword = mkNP (Paradigms.mkPN "vigilance") ;

        TargetCanActionStatement trg pol act = mkS pol (mkCl trg can_VV act) ;
 
        ThisClassTarget c = mkNP this_Quant c.n ;
        CreaturesWithKeywordTarget k = mkNP 
            aPl_Det 
            (mkCN (Paradigms.mkN2 CreatureClass.n "with") k) ;
        CreaturesWithKeywordsTarget ks = mkNP 
            aPl_Det
            (mkCN (Paradigms.mkN2 CreatureClass.n "with") (mkNP andOr_Conj ks)) ;
        CreaturesThatShareAColorWithIt = mkNP 
            aPl_Det 
            (mkCN CreatureClass.n (mkRS (mkRCl 
                that_RP 
                share_V3 
                (mkNP aSg_Det color_N)
                (mkNP it_Pron)))) ;
        YouTarget = mkNP youSg_Pron ;
        ItTarget = mkNP it_Pron ;
        ClassClassesTarget c1 c2 = 
            mkNP aPl_Det (mkCN c1.a c2.n) ;
        
        -- ...no idea why mkAdv does not work (instead of SubjS)
        SubTargetActionTrigger sub trg act = mkAdv sub (mkS (mkCl trg act)) ;

        AttackAction = mkVP attack_V ;
        BlockAction = mkVP block_V ;
        BlockTargetAction t = mkVP block_V2 t ;
        BeBlockedAction = passiveVP block_V2 ;
        OnlyBeBlockedByTargetAction t = mkVP only_Adv (passiveVP block_V2 t) ;
        OnlyBeBlockedByTarget1AndOrTarget2Action t1 t2 = 
            mkVP only_Adv (passiveVP block_V2 (mkNP andOr_Conj t1 t2)) ;
        -- ...no idea why mkAdv does not work (instead of PrepNP)
        ComeUnderYourControlAction = 
          mkVP (mkVP come_V) (mkAdv under_Prep (mkNP youSg_Pron (mkCN control_N))) ;
	
        AsSoonAsSub = Paradigms.mkSubj "as soon as" ;

    oper
        mkListCN : CN -> [CN] -> [CN] = \n,ns -> lin ListCN {
            s1 = n.s ;
            s2 = \\num,cas => ns.s1 ! num ! cas ++ ns.s2 ! num ! cas ; 
        };

        -- should be applicable to other languages too
        mkColor : Str -> Color = \s -> lin Color {
            a = Paradigms.mkA s ; 
            n = mkCN (Paradigms.mkN s) } ;
        
        mkClass : Str -> Class = \s -> lin Class {
            a = Paradigms.mkA s ; 
            n = (mkCN (Paradigms.mkN s)) } ;
        
        attack_V = Paradigms.mkV "attack" ;
        attach_V = Paradigms.mkV "attach" ;
        block_V = Paradigms.mkV "block" ;
        share_V = Paradigms.mkV "share" ;
        tap_V = Paradigms.mkV "TAP" ;
	come_V = Paradigms.mkV "come" ;

        block_V2 = Paradigms.mkV2 block_V ;
        share_V3 = Paradigms.mkV3 share_V with_Prep ;

        color_N = Paradigms.mkN "color" ;
        control_N = Paradigms.mkN "control" ;
        only_Adv = Paradigms.mkAdV "only" ;

--        this_Quant = mkQuant "this" "these" ;

        andOr_Conj = Paradigms.mkConj "and/or" ;
}
