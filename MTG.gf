abstract MTG = open Numeral, Common in {
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
        [Superclass]{0} ;
        Class ;             -- main type, e.g. "Creature"
        [Class]{1} ;
        Subclass ;          -- subtype, e.g. "Dragon"
        [Subclass]{0} ;
        
        -- text boxs may contain a list of abilities and a flavor text
        Ability ;            -- e.g. "Flying" (but possibly also longer text)
        [Ability]{0} ;
        Flavor ;            -- flavor text (unconstrained language)

        -- stats are divided into power and toughness
        Power ;             -- usually a positive integer
        Toughness ;         -- usually a positive integer
        
        -- abilities consist of an (optional) activation cost and a keyword 
        -- and/or explanation
        ActivationCost ;    -- cost for activating an effect
        Keyword ;           -- e.g. "Defender"
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

        Polarity ;

    fun 
        card : Name -> [Color] -> ManaCost -> TypeLine -> TextBox -> Stats -> Card ;
        basicLand : Subclass -> Card ; -- basic land with no flavor text

        manaCost : [Circle] -> ManaCost ;
        
        --typeLine : [Superclass] -> [Class] -> [Subclass] -> TypeLine ;
        typeLine : Superclass -> Class -> Subclass -> TypeLine ;

        textBox : [Ability] -> Flavor -> TextBox ;

        stats : Power -> Toughness -> Stats ;
        
        -- cost could also be X but we'll se about that later
        circle : Color -> Decimal -> Circle ;

        -- colors
        white : Color ;
        blue : Color ;
        black : Color ;
        red : Color ;
        green : Color ;

        -- supertypes, from mtg.fandom.com/wiki/Supertype
        basic : Superclass ;
        legendary : Superclass ;
     -- ongoing : Superclass ;
     -- snow : Superclass ;
     -- world : Superclass ;

        -- types, from mtg.fandom.com/wiki/Card_type
        land : Class ;
        creature : Class ;
        artifact : Class ;
        enchantment : Class ;
     -- planeswalker : Class ;
     -- battle : Class ;
        instant : Class ;
        sorcery : Class ;

        -- basic lands (more subypes to come) 
        plain : Subclass ;
        island : Subclass ;
        swamp : Subclass ;
        mountain : Subclass ;
        forest : Subclass ;
        
        -- overload?
        ability : Explanation -> Ability ;
        keywordAbility : Keyword -> Ability ;
        keywordAbilityWithReminder : Keyword -> Explanation -> Ability ;
        abilityWithCost : ActivationCost -> Explanation -> Ability ;
        keywordAbilityWithCost : ActivationCost -> Keyword -> Ability ; 
        keywordAbilityWithReminderAndCost : ActivationCost -> Keyword -> Explanation -> Ability ; 

        activationCost : ManaCost -> Tap -> ActivationCost ;

        -- so-called "evergreen" keywords (more to come)
        deathtouch : Keyword ;
        defender : Keyword ;
        doubleStrike : Keyword ; 
        enchant : Class -> Keyword ;
        equip : ActivationCost -> Keyword ;
        firstStrike : Keyword ;
        flash : Keyword ;
        flying : Keyword ;
        haste : Keyword ;
        hexproof : Keyword ;
        indestructible : Keyword ;
        intimidate : Keyword ;
        landwalk : Subclass -> Keyword ;
        lifelink : Keyword ;
        menace : Keyword ;
        protectionFrom : Color -> Keyword ; -- IDK if it's just colors
        prowess : Keyword ;
        reach : Keyword ;
        shroud : Keyword ;
        trample : Keyword ;
        vigilance : Keyword ;

        explanation : [Statement] -> [Command] -> Explanation ;
        oneStatementExplanation : Statement -> Explanation ;
        
        -- "this creature can('t) block creatures with flying"
        targetCanAction : Target -> Polarity -> Action -> Statement ;

        thisCreature : Target ;
        creaturesWithKeyword : Keyword -> Target ;
        you : Target ;

        attack : Action ;
        block : Action ;
        blockTarget : Target -> Action ;

        positive : Polarity ;
        negative : Polarity ;
}