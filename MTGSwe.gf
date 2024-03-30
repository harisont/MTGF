concrete MTGSwe of MTG = ConjunctionSwe-[Card] ** open 
    Prelude,
    ResSwe,
    LangSwe, 
    ConjunctionSwe,
    ConstructorsSwe,
    ParadigmsSwe,
    ExtraSwe in {
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
        Explanation = Text ;

        Tap = Bool ;

        Statement = S ;
        Command = Imp ;

        Trigger = Adv ;
        Action = VP ;
        Condition = Cl ;

        Target = NP ;

    lin             
        WhiteColor = mkColor "vit" ;
        BlueColor = mkColor "blå" ;
        BlackColor = mkColor "svart" ;
        RedColor = mkColor "röd" ;
        GreenColor = mkColor "grön" ;

        BasicSuperclass = mkA "standard" "standard" ;
        LegendarySuperclass = mkA "legendarisk" ;

        LandClass = mkClass "land" "landet" "länder" "länderna" neutrum ;
        CreatureClass = 
            mkClass "varelse" "varelsen" "varelser" "varelsena" utrum ;
        ArtifactClass = mkClass "artefakt" "artefakter" ;
        EnchantmentClass = mkClass "förhäxning" ;
        InstantClass = mkClass "instant" "instanter" ;
        SorceryClass = mkClass "svartkonst" "svartkonster" ;

        -- basic lands (more subypes to come) 
        PlainSubclass = 
            mkCN (mkN "fält" "fältet" "fälter" "fältena" neutrum) ;
        IslandSubclass = mkCN (mkN "ö") ;
        SwampSubclass = mkCN (mkN "träsk") ;
        MountainSubclass = mkCN (mkN "berg" "berg") ;
        ForestSubclass = mkCN (mkN "skog") ;     

        -- so-called "evergreen" keywords (more to come)
        -- from en.wikipedia.org/wiki/List_of_Magic:_The_Gathering_keywords
        DeathtouchKeyword = mkNP (mkPN "dödsberöring") ;
        DefenderKeyword = mkNP (mkPN "skyddare") ;
        DoubleStrikeKeyword = mkNP (mkPN "dubbel anfall") ; 
     -- EnchantKeyword type = mkNP (mkPN ("förhäxa" ++ type.n.s ! Sg ! Res.Nom));
     -- EquipKeyword cost = mkNP (mkPN ("utrusta" ++ cost)) ;
        FirstStrikeKeyword = mkNP (mkPN "första anfall") ;
        FlashKeyword = mkNP (mkPN "blixt") ;
        FlyingKeyword = mkNP (mkPN "flygande") ;
        HasteKeyword = mkNP (mkPN "hastig") ;
        HexproofKeyword = mkNP (mkPN "häxsäker") ;
        IndestructibleKeyword = mkNP (mkPN "oförstörbar") ;
        IntimidateKeyword = mkNP (mkPN "skrämmande") ;
        LifelinkKeyword = mkNP (mkPN "livlänk") ;
        MenaceKeyword = mkNP (mkPN "hotelse") ;
     -- ProtectionFromKeyword color = 
         -- mkNP (mkPN ("skydd från" ++ color.n.s ! Sg ! Res.Nom)) ;
        ProwessKeyword = mkNP (mkPN "skicklighet") ;
        ReachKeyword = mkNP (mkPN "nå") ;
        ShroudKeyword = mkNP (mkPN "kamouflera") ;
        TrampleKeyword = mkNP (mkPN "överväldigande") ;
        VigilanceKeyword = mkNP (mkPN "vaksam") ;

        ThisClassTarget c = mkNP this_Quant c.n ;
        YouTarget = mkNP youSg_Pron ;
        ItTarget = mkNP it_Pron ;
        ClassClassesTarget c1 c2 = 
            mkNP aPl_Det (mkCN c1.a c2.n) ;
        
        AttackAction = mkVP attack_V ;
        BlockAction = mkVP block_V ;
        BlockTargetAction t = mkVP block_V2 t ;
        BeBlockedAction = passiveVP block_V2 ;
        OnlyBeBlockedByTargetAction t = mkVP only_AdV (passiveVP block_V2 t) ;
        
        -- basic vocab
	    attack_V = mkV "attackera" ;
        attach_V = mkV "fästa" ;
        block_V = mkV "blockera" ;
        share_V = mkV "dela" ;
        tap_V = mkV "TAPpa" ;
	    come_V = mkV "komma" "kom" "kommit" ;
        block_V2 = mkV2 block_V ;
        share_V3 = mkV3 share_V with_Prep ;
        color_N = mkN "färg" "färger" ;
        control_N = mkN "kontroll" "kontroller" ;
        only_AdV = mkAdV "endast" ;
        --andOr_Conj = mkConj "och/eller" ;
        --asSoonAs_Subj = mkSubj "så snart som" ;

    oper

        -- should be applicable to other languages too
        mkColor : Str -> Color = \s -> lin Color {
            a = mkA s ; 
            n = mkCN (mkN s) } ;
        
        mkClass = overload {
            mkClass : Str -> Class = \s -> lin Class {
                a = mkA s s s s s s s ; 
                n = (mkCN (mkN s)) } ;
            mkClass : Str -> Gender -> Class = \s, g -> lin Class {
                a = mkA s s s s s s s ; 
                n = (mkCN (mkN s g)) } ;
            mkClass : Str -> Str -> Class = \s, p -> lin Class {
                a = mkA s s s s s s s ; 
                n = (mkCN (mkN s p)) } ;
            mkClass : Str -> Str -> Str -> Str -> Gender -> Class = 
                \o1, b1, o2, b2, g -> lin Class {
                    a = mkA o1 o1 o1 o1 o1 o1 o1 ; 
                    n = (mkCN (mkN o1 b1 o2 b2 g)) } ;
        } ;
}
