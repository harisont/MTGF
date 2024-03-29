concrete MTGSwe of MTG = ConjunctionSwe-[Card] ** open 
    Prelude,
    ParamX,
    (Res=ResSwe),
    (Conj=ConjunctionSwe),
    (Par=ParadigmsSwe),
    SyntaxSwe,
    ExtraSwe
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
        ListKeyword = Conj.ListNP ;
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
        WhiteColor = mkColor "vit" ;
        BlueColor = mkColor "blå" ;
        BlackColor = mkColor "svart" ;
        RedColor = mkColor "röd" ;
        GreenColor = mkColor "grön" ;

        BasicSuperclass = Par.mkA "standard" "standard" ;
        LegendarySuperclass = Par.mkA "legendarisk" ;

        LandClass = mkClass "land" "landet" "länder" "länderna" Par.neutrum ;
        CreatureClass = 
            mkClass "varelse" "varelsen" "varelser" "varelsena" Par.utrum ;
        ArtifactClass = mkClass "artefakt" "artefakter" ;
        EnchantmentClass = mkClass "förhäxning" ;
        InstantClass = mkClass "instant" "instanter" ;
        SorceryClass = mkClass "svartkonst" "svartkonster" ;

        -- basic lands (more subypes to come) 
        PlainSubclass = 
            mkCN (Par.mkN "fält" "fältet" "fälter" "fältena" Par.neutrum) ;
        IslandSubclass = mkCN (Par.mkN "ö") ;
        SwampSubclass = mkCN (Par.mkN "träsk") ;
        MountainSubclass = mkCN (Par.mkN "berg" "berg") ;
        ForestSubclass = mkCN (Par.mkN "skog") ;     

        BasicAbility e = e ;

        -- so-called "evergreen" keywords (more to come)
        -- from en.wikipedia.org/wiki/List_of_Magic:_The_Gathering_keywords
        DeathtouchKeyword = mkNP (Par.mkPN "dödsberöring") ;
        DefenderKeyword = mkNP (Par.mkPN "skyddare") ;
        DoubleStrikeKeyword = mkNP (Par.mkPN "dubbel anfall") ; 
     -- EnchantKeyword type = mkNP (Par.mkPN ("förhäxa" ++ type.n.s ! Sg ! Res.Nom));
     -- EquipKeyword cost = mkNP (Par.mkPN ("utrusta" ++ cost)) ;
        FirstStrikeKeyword = mkNP (Par.mkPN "första anfall") ;
        FlashKeyword = mkNP (Par.mkPN "blixt") ;
        FlyingKeyword = mkNP (Par.mkPN "flygande") ;
        HasteKeyword = mkNP (Par.mkPN "hastig") ;
        HexproofKeyword = mkNP (Par.mkPN "häxsäker") ;
        IndestructibleKeyword = mkNP (Par.mkPN "oförstörbar") ;
        IntimidateKeyword = mkNP (Par.mkPN "skrämmande") ;
        LifelinkKeyword = mkNP (Par.mkPN "livlänk") ;
        MenaceKeyword = mkNP (Par.mkPN "hotelse") ;
     -- ProtectionFromKeyword color = 
         -- mkNP (mkPN ("skydd från" ++ color.n.s ! Sg ! Res.Nom)) ;
        ProwessKeyword = mkNP (Par.mkPN "skicklighet") ;
        ReachKeyword = mkNP (Par.mkPN "nå") ;
        ShroudKeyword = mkNP (Par.mkPN "kamouflera") ;
        TrampleKeyword = mkNP (Par.mkPN "överväldigande") ;
        VigilanceKeyword = mkNP (Par.mkPN "vaksam") ;

        TargetCanActionStatement trg pol act = mkS pol (mkCl trg can_VV act) ;
 
        ThisClassTarget c = mkNP this_Quant c.n ;
        YouTarget = mkNP youSg_Pron ;
        ItTarget = mkNP it_Pron ;
        ClassClassesTarget c1 c2 = 
            mkNP aPl_Det (mkCN c1.a c2.n) ;
        
        SubTargetActionTrigger sub trg act = mkAdv sub (mkS (mkCl trg act)) ;

        AttackAction = mkVP attack_V ;
        BlockAction = mkVP block_V ;
        BlockTargetAction t = mkVP block_V2 t ;
        BeBlockedAction = passiveVP block_V2 ;
        OnlyBeBlockedByTargetAction t = mkVP only_Adv (passiveVP block_V2 t) ;
        ComeUnderYourControlAction = 
          mkVP (mkVP come_V) (mkAdv under_Prep (mkNP youSg_Pron (mkCN control_N))) ;
	
        --AsSoonAsSub = Par.mkSubj "så snart som" ;

    oper

        -- should be applicable to other languages too
        mkColor : Str -> Color = \s -> lin Color {
            a = Par.mkA s ; 
            n = mkCN (Par.mkN s) } ;
        
        mkClass = overload {
            mkClass : Str -> Class = \s -> lin Class {
                a = Par.mkA s s s s s s s ; 
                n = (mkCN (Par.mkN s)) } ;
            mkClass : Str -> Par.Gender -> Class = \s, g -> lin Class {
                a = Par.mkA s s s s s s s ; 
                n = (mkCN (Par.mkN s g)) } ;
            mkClass : Str -> Str -> Class = \s, p -> lin Class {
                a = Par.mkA s s s s s s s ; 
                n = (mkCN (Par.mkN s p)) } ;
            mkClass : Str -> Str -> Str -> Str -> Par.Gender -> Class = 
                \o1, b1, o2, b2, g -> lin Class {
                    a = Par.mkA o1 o1 o1 o1 o1 o1 o1 ; 
                    n = (mkCN (Par.mkN o1 b1 o2 b2 g)) } ;
        } ;
        
        attack_V = Par.mkV "attackera" ;
        attach_V = Par.mkV "fästa" ;
        block_V = Par.mkV "blockera" ;
        share_V = Par.mkV "dela" ;
        tap_V = Par.mkV "TAPpa" ;
	    come_V = Par.mkV "komma" "kom" "kommit" ;

        block_V2 = Par.mkV2 block_V ;
        share_V3 = Par.mkV3 share_V with_Prep ;

        color_N = Par.mkN "färg" "färger" ;
        control_N = Par.mkN "kontroll" "kontroller" ;

        only_Adv = Par.mkAdV "endast" ;

        --andOr_Conj = Par.mkConj "och/eller" ;
}
