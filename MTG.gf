abstract MTG = open Numeral in {
    flags startcat = Card ;

    cat
        Card ;

        -- parts of a card loosely based on 
        -- mtg.fandom.com/wiki/Parts_of_a_card?file=Parts_of_a_Magic_card.jpg
        Name ;              -- title
        ManaCost ;          -- mana cost, e.g. 4RR (4 generic + 2 red mana)
        TypeLine ;          -- card type including subtypes, e.g. Creature - Dragon
     -- Expansion ;         -- e.g. M10
        TextBox ;           -- abilities & flavor text
        Stats ;             -- power and toughness, e.g. 5/5 
     -- Details ;           -- fine print: artist, collector number...
        
        Circle ;            -- single "circle" in a mana cost
        [Circle]{1} ;
        Superclass ;        -- supertype, e.g. "Basic" or "Legendary"
        [Superclass]{0} ;
        Class ;             -- main type, e.g. "Creature"
        [Class]{1} ;
        Subclass ;          -- subtype, e.g. "Dragon"
        [Subclass]{0} ;
        Ability ;            -- e.g. "Flying" (but possibly also longer text)
        [Ability]{0} ;
        Flavor ;            -- flavor text (unconstrained language)
        Power ;             -- usually a positive integer
        Toughness ;         -- usually a positive integer
        
        Color ;             -- color, e.g. "red"
        [Color]{0} ;
        ActivationCost ;    -- cost for activating an effect
        Keyword ;           -- e.g. "Defender"
        Explanation ;       -- ability text (reminder text or other)

        Tap ;               -- "self-tap" symbol (for activation costs)
        -- parts of explanations 
        Trigger ;           -- "When self-assembler enters the battlefield"
        Possibility ;       -- "You may search your library for..."
        Command ;           -- "Tap enchanted permanent"
        Statement ;         -- "Enchanted permanent has indestructible"
        Condition ;         -- "If you have an island"

    fun 
        card : Name -> [Color] -> ManaCost -> TypeLine -> TextBox -> Stats -> Card ;
        basicLand : Subclass -> Card ; -- basic land with no flavor text

        manaCost : [Circle] -> ManaCost ;
        
        --typeLine : [Superclass] -> [Class] -> [Subclass] -> TypeLine ;
        typeLine : Superclass -> Class -> Subclass -> TypeLine ; -- simplified

        textBox : [Ability] -> Flavor -> TextBox ;

        stats : Power -> Toughness -> Stats ;
        
        -- cost could also be X but we'll se about that later
        circle : Color -> Decimal -> Circle ;

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

        -- colors
        white : Color ;
        blue : Color ;
        black : Color ;
        red : Color ;
        green : Color ;

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

}