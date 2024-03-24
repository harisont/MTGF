## Evergreen keyword abilities
| Keyword | Reminder text | Covered |
| --- | --- | --- |
| First strike | This creature deals combat damage before creatures without first strike |  |
| Double strike | This creature deals both first-strike and regular combat damage |  |
| Enchant | This card can only be attached to a X |  |
| Trample | This creature can deal excess combat damage to a player, planeswalker or battle it's attacking |  |
| Haste | This creature can attack and TAPs as soon as it comes under your control |  |
| Reach | This creature can block creatures with flying | X |
| Defender | This creature can't attack | X |
| Flying | ~~This creature can't be blocked except by creatures with flying and/or reach~~ (reformulated as "This creature can only be blocked by creatures with flying and/or reach") | x |
| Intimidate | ~~This creature can't be blocked except by artifact creatures and/or creatures that share a color with it~~ (reformulated as "this creature can only be blocked by artifact creatures and/or creatures that share a color with it") | x |
| X-walk | This creature can't be blocked as long as defending player controls a X (land) |  |
| Protection from X | This can't be blocked, targeted, dealt damage, enchanted, or equipped by anything X |  |
| Hexproof | This permanent can't be the target of spells or abilities your opponents control |  |
| Shroud | This permanent or player can’t be the target of spells or abilities |  |
| Flash | You may cast this spell any time you could cast an instant |  |
| Indestructible | Damage and effects that say "destroy" don’t destroy this |  |
| Lifelink | Damage dealt by this creature also causes you to gain that much life |  |
| Deathtouch | Any amount of damage this deals to a creature is enough to destroy it |  |
| Vigilance | Attacking doesn't cause this creature to tap |  |
| Equip | Attach this permanent to target X creature you control. Activate this ability only any time you could cast a sorcery |  |

## Current problems
- [ ] keywords with arguments, such as "protection from X"
- [x] reducing `targetCanAction` and `targetCantAction` to a single `targetCanAction` with `Pol` as a parameters
- [ ] "plains" is technically a plural, can types be NPs in English then? 
- [ ] reducing `creaturesWithKeyword` and `creaturesWithKeyword1AndOrKeyword2` to `creaturesWithKeywords`, using lists (I don't know how to map `mkNP` on a list of `Keyword`s)