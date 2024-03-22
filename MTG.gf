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
        Effect ;            -- e.g. "Flying" (but possibly also longer text)
        [Effect]{0} ;
        Flavor ;            -- flavor text (unconstrained language)
        Power ;             -- usually a positive integer
        Toughness ;         -- usually a positive integer
        
        Color ;             -- color, e.g. "red"
        [Color]{0} ;
        ActivationCost ;    -- cost for activating an effect
        Keyword ;           -- e.g. "Defender"
        Explanation ;       -- explanation of an effect 

        Tap ;               -- "self-tap" symbol (for activation costs)

    fun 
        card : Name -> [Color] -> ManaCost -> TypeLine -> TextBox -> Stats -> Card ;
        
        manaCost : [Circle] -> ManaCost ;
        
        typeLine : [Superclass] -> [Class] -> [Subclass] -> TypeLine ;

        text : [Effect] -> Flavor -> TextBox ;

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

        effect : ActivationCost -> Keyword -> Explanation -> Effect ;


        -- colors
        white : Color ;
        blue : Color ;
        black : Color ;
        red : Color ;
        green : Color ;

        activationCost : ManaCost -> Tap -> ActivationCost ;
}