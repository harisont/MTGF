abstract MTG = Conjunction-[Card] ** open Numeral, Common, Cat in {
    flags startcat = Card ;

    cat
        Card ;

        -- parts of a card loosely based on 
        -- mtg.fandom.com/wiki/Parts_of_a_card?file=Parts_of_a_Magic_card.jpg
        Name ;              -- title
        ManaCost ;          -- mana cost, e.g. 4RR (4 generic + 2 red mana)
        TypeLine ;          -- type line, e.g. Creature - Dragon
     -- Expansion ;         -- e.g. M10
        TextBox ;           -- abilities & flavor text
        Stats ;             -- power and toughness, e.g. 5/5 
     -- Details ;           -- fine print: artist, collector number...
        Color ;             -- card color, e.g. "red"
        [Color]{0} ;
        
        -- a mana cost is a list of "circles"
        Circle ;            -- single "circle" in a mana cost
        [Circle]{1} ;
        
        -- type lines are composed of an optional supertype, one or more 
        -- main type and, optionally one or two subtypes
        Superclass ;        -- supertype, e.g. "Basic" or "Legendary"
        Class ;             -- main type, e.g. "Creature"
        Subclass ;          -- subtype, e.g. "Dragon"
        
        -- text boxs may contain a list of abilities and a flavor text
        Ability ;           -- e.g. "Flying" (but possibly also longer text)
        [Ability]{0} ;
        Flavor ;            -- flavor text (unconstrained language)

        -- stats are divided into power and toughness
        Power ;             -- usually a positive integer
        Toughness ;         -- usually a positive integer
        
        -- abilities consist of an (optional) activation cost and a keyword 
        -- and/or explanation
        ActivationCost ;    -- cost for activating an effect
        Keyword ;           -- e.g. "Flying"
        [Keyword]{2} ;
        Explanation ;       -- ability text (reminder text or other)

        -- activation costs may or may not include a "self-tap" symbol
        Tap ;               -- "self-tap" symbol

        -- explanations are made of statements or commands
        Statement ;         -- "Enchanted permanent has indestructible"
        [Statement]{0} ;
        Command ;           -- "Tap(pa) enchanted permanent"
        [Command]{0} ;
        
        -- triggerd, actions and statements are used in both statements and
        -- commands
        Trigger ;           -- "When self-assembler enters the battlefield"
        Action ;            -- "Tap(pare) or untap(pare) target permanent"
        Condition ;         -- "If you have an island"

        -- tragets are used in triggers, actions and conditions
        Target ;            -- "target land", "this creature" or "Negate"

    fun 
        BasicLandCard : Subclass -> Flavor -> Card ;
        LandCard : Subclass -> TypeLine -> TextBox -> Card ; 
        SpellCard : 
            Name -> [Color] -> ManaCost -> TypeLine -> TextBox -> Card ;
        CreatureCard : 
            Name -> [Color] -> ManaCost -> TypeLine -> Text -> Stats -> Card ;

        CardManaCost : [Circle] -> ManaCost ;
        
        -- Instant
        ClassTypeLine : Class -> TypeLine ;              
        -- Basic Land           
        SuperTypeLine : Superclass -> Class -> TypeLine ;
        -- Creature - Human
        ClassSubTypeLine : Class -> Subclass -> TypeLine ;
        -- Legendary Creature - Human
        SuperClassSubTypeLine : Superclass -> Class -> Subclass -> TypeLine ;
        -- Creature - Human Warrior 
        ClassSubsTypeLine : Class -> Subclass -> Subclass -> TypeLine ;
        -- Artifact Creature - Scarecrow
        ClassesSubsTypeLine : Class -> Class -> Subclass -> TypeLine ;
        -- Legendary Creature - Human Warrior
        SupersClassSubsTypeLine : 
            Superclass -> Class -> Subclass -> Subclass -> TypeLine ;
        -- Legendary Artifact Creature - Human Warrior  
        SupersClassesSubsTypeLine : 
            Superclass -> Class -> Class -> Subclass -> Subclass -> TypeLine ;

        CardTextBox : [Ability] -> Flavor -> TextBox ;
        
        CardStats : Power -> Toughness -> Stats ;

        WhiteColor : Color ;
        BlueColor : Color ;
        BlackColor : Color ;
        RedColor : Color ;
        GreenColor : Color ;
        
        -- cost could also be X but we'll se about that later
        ManaCostCircle : Color -> Decimal -> Circle ;

        -- supertypes, from mtg.fandom.com/wiki/Supertype
        BasicSuperclass : Superclass ;
        LegendarySuperclass : Superclass ;
     -- OngoingSuperclass : Superclass ;
     -- SnowSuperclass : Superclass ;
     -- WorldSuperclass : Superclass ;

        -- types, from mtg.fandom.com/wiki/Card_type
        LandClass : Class ;
        CreatureClass : Class ;
        ArtifactClass : Class ;
        EnchantmentClass : Class ;
        InstantClass : Class ;
        SorceryClass : Class ;
     -- PlaneswalkerClass : Class ;
     -- BattleClass : Class ;
     -- ClassClass : Class -> Class -> Class ; -- Artifact Creature

        -- basic lands (more subypes to come) 
        PlainSubclass : Subclass ;
        IslandSubclass : Subclass ;
        SwampSubclass : Subclass ;
        MountainSubclass : Subclass ;
        ForestSubclass : Subclass ;
        
        BasicAbility : Explanation -> Ability ;
        KeywordAbility : Keyword -> Ability ;
        KeywordReminderAbility : Keyword -> Explanation -> Ability ;
        ActivatedBasicAbility : ActivationCost -> Explanation -> Ability ;
        ActivatedKeywordAbility : ActivationCost -> Keyword -> Ability ;
        ActivatedKeywordReminderAbility : 
            ActivationCost -> Keyword -> Explanation -> Ability ;

        AbilityActivationCost : ManaCost -> Tap -> ActivationCost ;

        -- so-called "evergreen" keywords (more to come)
        DeathtouchKeyword : Keyword ;
        DefenderKeyword : Keyword ;
        DoubleStrikeKeyword : Keyword ; 
        EnchantKeyword : Class -> Keyword ;
        EquipKeyword : ActivationCost -> Keyword ;
        FirstStrikeKeyword : Keyword ;
        FlashKeyword : Keyword ;
        FlyingKeyword : Keyword ;
        HasteKeyword : Keyword ;
        HexproofKeyword : Keyword ;
        IndestructibleKeyword : Keyword ;
        IntimidateKeyword : Keyword ;
        LandwalkKeyword : Subclass -> Keyword ;
        LifelinkKeyword : Keyword ;
        MenaceKeyword : Keyword ;
        ProtectionFromKeyword : Color -> Keyword ; -- IDK if it's just colors
        ProwessKeyword : Keyword ;
        ReachKeyword : Keyword ;
        ShroudKeyword : Keyword ;
        TrampleKeyword : Keyword ;
        VigilanceKeyword : Keyword ;

        AbilityExplanation : [Statement] -> [Command] -> Explanation ;
        
        -- "this creature can('t) block creatures with flying"
        TargetCanActionStatement : Target -> Pol -> Action -> Statement ;
        -- "this creature can attack as soon as it comes under your control"
        TargetCanActionTriggerStatement : 
            Target -> Action -> Trigger -> Statement ;

        ThisClassTarget : Class -> Target ; -- "this creature"
        -- could be "class with" but I think this is only used for creatures
        CreaturesWithKeywordTarget : Keyword -> Target ;
        CreaturesWithKeywordsTarget : [Keyword] -> Target ;
        CreaturesThatShareAColorWithIt : Target ;
        YouTarget : Target ;
        ItTarget : Target ;
        -- "artifact creatures"
        ClassClassesTarget : Class -> Class -> Target ;

        -- "as soon as it comes under your control"
        SubTargetActionTrigger : Subj -> Target -> Action -> Trigger ;
        
        AttackAction : Action ;
        BlockAction : Action ;
        BlockTargetAction : Target -> Action ;
        BeBlockedAction : Action ;
        OnlyBeBlockedByTargetAction : Target -> Action ;
        OnlyBeBlockedByTarget1AndOrTarget2Action : 
            Target -> Target -> Action ;
        ComeUnderYourControlAction : Action ;

        -- basic vocab
        attack_V : V ;
        attach_V : V ;
        block_V : V ;
        share_V : V ;
        tap_V : V ;
	    come_V : V ;
        block_V2 : V2 ;
        share_V3 : V3 ;
        color_N : N ;
        control_N : N  ;
        only_AdV : AdV ;
        andOr_Conj : Conj ;
        asSoonAs_Subj : Subj ;
}