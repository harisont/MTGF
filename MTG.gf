abstract MTG = {
    flags startcat = Card ;

    cat
        Card ;

        -- only non-planeswalkers types covered, see mtg.fandom.com/wiki/Parts_of_a_card?file=Parts_of_a_Magic_card.jpg
        Name ;      -- title
        Cost ;      -- mana cost, e.g. 4RR (4 generic + 2 red mana)
        TypeLine ;  -- card type including subtypes, e.g. Creature - Dragon
        Expansion ; -- e.g. M10
        TextBox ;   -- abilities & flavor text
        Stats ;     -- power and toughness, e.g. 5/5 
        Details ;   -- fine print: artist, collector number etc.

        MainType ;  -- e.g. "Creature"
        SubType ;   -- e.g. "Dragon"

        Ability ;   -- e.g. "Flying" (but possibly also longer text)
        [Ability]{0} ;
        FlavorText ;-- whatever random sentence

        Power ;     -- usually a positive integer
        Toughness ; -- usually a positive integer

    fun
        -- not everything is mandatory but we'll see about that
        card : Name -> Cost -> TypeLine -> Expansion -> TextBox -> Stats -> Details -> Card ;
        -- the stuff I personally consider important
        miniCard : Name -> Cost -> TypeLine -> TextBox -> Stats -> Card ;
        
        -- not everything is mandatory but we'll see about that
        typeLine : MainType -> SubType -> TypeLine ;

        -- nothing is mandatory but we'll see about that
        textBox : [Ability] -> FlavorText -> TextBox ;

        stats : Power -> Toughness -> Stats ;
        
}