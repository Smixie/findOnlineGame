(deftemplate message
    (slot name (type STRING))
    (slot question (type STRING))
    (multislot answers (type STRING))
)

(deftemplate online-game
    (slot name (type STRING))
)

; Start
(defrule genre
    =>
    (assert (message (name "genre") (question "What type of game are you looking for?") (answers "SHOOTERS" "RPGS" "STRATEGY" "VIRTUAL WORLDS")))
)

; SHOOTERS
(defrule ground-or-space
    ?f <- (genre "SHOOTERS")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "ground-or-space") (question "Fight on the ground or while flying through space?") (answers "Ground" "Flying")))
)

; SHOOTERS FLYING
(defrule fight-place-space
    ?f <- (ground-or-space "Flying")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "fight-place-space") (question "Big battles or precise control of your ship?") (answers "Precise control" "Big battles")))
)

(defrule precise-control-result
    ?f <- (fight-place-space "Precise control")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "BATTLESTAR GALACTICA")))
)

(defrule big-battles-result
    ?f <- (fight-place-space "Big battles")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "ACE ONLINE")))
)

; SHOOTERS GROUND
(defrule fight-place-ground
    ?f <- (ground-or-space "Ground")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "fight-place-ground") (question "Who would you rather fight:") (answers "Monsters" "Military")))
)

; MILITARY PATH
(defrule tank-or-soldiers
    ?f <- (fight-place-ground "Military")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "tank-or-soldiers") (question "Would you see yourself in tank or as a soldier:") (answers "Tank" "Soldier")))
)

(defrule tank-result
    ?f <- (tank-or-soldiers "Tank")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "WORLD OF TANKS")))
)

(defrule soldier-result
    ?f <- (tank-or-soldiers "Soldier")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "LOST SAGA")))
)

; MONSTER PATH
(defrule mummies-or-werewolves
    ?f <- (fight-place-ground "Monsters")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "mummies-or-werewolves") (question "Mummies or Werewolves:") (answers "Mummies" "Werewolves")))
)

(defrule mummies-result
    ?f <- (mummies-or-werewolves "Mummies")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "MISSION AGAINST TERROR")))
)

(defrule werewolves-result
    ?f <- (mummies-or-werewolves "Werewolves")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "WOLF TEAM")))
)

; STRATEGY
(defrule fantasy-historical-real
    ?f <- (genre "STRATEGY")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "fantasy-historical-real") (question "Would you like fantasy, real world or 'the family'?") (answers "Fantasy" "Historical" "Mafia")))
)

; MAFIA
(defrule family-result
    ?f <- (fantasy-historical-real "Mafia")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "GODFATHER: FIVE FAMILIES")))
)

; FANTASY 
(defrule rpgs-strategy 
        ?f <- (fantasy-historical-real "Fantasy")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "rpgs-strategy") (question "Would you like a game with some RPGS or straight-up strategy?") (answers "RPG elements" "Just strategy")))
)

(defrule some-rpgs-result
    ?f <- (rpgs-strategy "RPG elements")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "CALL OF GODS")))
)

(defrule just-strategy-result
    ?f <- (rpgs-strategy "Just strategy")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "GREPOLIS")))
)

; HISTORICAL
(defrule involved-casula 
    ?f <- (fantasy-historical-real "Historical")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "involved-casula") (question "Would you like a game for casual play or more involving?") (answers "Involving" "Casual")))
)

; INVOLVED HISTORICAL
(defrule single-multi 
    ?f <- (involved-casula "Involving")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "single-multi") (question "Would you like a game to play on your own or with friends?") (answers "Solo" "With friends")))
)

(defrule single-result
    ?f <- (single-multi "Solo")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "CASTLE EMPIRE")))
)

(defrule multi-result
    ?f <- (single-multi "With friends")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "TRAVIAN")))
)

; CASUAL HISTORICAL
(defrule realtime-strategic 
    ?f <- (involved-casula "Casual")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "realtime-strategic") (question "Game should be more strategic or real time tactics?") (answers "Real time tactics" "Strategic")))
)

(defrule real-time-tactics-result
    ?f <- (realtime-strategic "Real time tactics")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "1100 AD")))
)

(defrule strategic-result
    ?f <- (realtime-strategic "Strategic")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "TRIBAL WARS")))
)

;VIRTUAL  WORLDS
(defrule buildin-freedom
    ?f <- (genre "VIRTUAL WORLDS")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "buildin-freedom") (question "World with games build in or completely freedom experience?") (answers "Build in games" "Open-ended")))
)

(defrule blocks-legos
    ?f <- (buildin-freedom "Build in games")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "blocks-legos") (question "Which do you prefer to build with: blocks or legos?") (answers "Blocks" "Legos")))
)

(defrule blocks-result
    ?f <- (blocks-legos "Blocks")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "MINECRAFT CLASSIC")))
)

(defrule legos-result
    ?f <- (blocks-legos "Legos")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "ROBLOX")))
)

(defrule chat-create
    ?f <- (buildin-freedom "Open-ended")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "chat-create") (question "Chat and make new friends or do you want to create things?") (answers "Chat" "Create")))
)

(defrule chat-result
    ?f <- (chat-create "Chat")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "IMVU")))
)

(defrule create-result
    ?f <- (chat-create "Create")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "SECOND LIFE")))
)

; RPGS
(defrule rpgs-genre
    ?f <- (genre "RPGS")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "rpgs-genre") (question "What genre would you like? Swords and sorcery, starships, superheroes or something else?") (answers "Fantasy" "Science Fiction" "Superheroes" "Something different")))
)

; RPGS fantasy path
(defrule rpgs-wow
    ?f <- (rpgs-genre "Fantasy")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "rpgs-wow") (question "Have you played World of Warcraft?") (answers "Yes" "No")))
)

; RPGS fantasy wow yes
(defrule fantasy-casual-or-involved
    ?f <- (rpgs-wow "Yes")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "fantasy-casual-or-involved") (question "Are you looking for something casual, or something more involved?") (answers "Casual" "Involved")))
)

; RPGS fantasy wow no
(defrule world-of-warcraft-no
    ?f <- (rpgs-wow "No")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "World of Warcraft")))
)

; RPGS fantasy casual
(defrule fantasy-intensity
    ?f <- (fantasy-casual-or-involved "Casual")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "fantasy-intensity") (question "But would you still like the option for more intense play when you have the time for it?") (answers "Yes" "No")))
)

; RPGS fantasy involved
(defrule fantasy-age-digits
    ?f <- (fantasy-casual-or-involved "Involved")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "fantasy-age-digits") (question "How many digits are in your age?") (answers "1 or not sure" "2 or more")))
)

; RPGS fantasy casual intense
(defrule fantasy-intensity-yes
    ?f <- (fantasy-intensity "Yes")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "Shaiya")))
)

; RPGS fantasy casual not intense
(defrule fantasy-more-social
    ?f <- (fantasy-intensity "No")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "fantasy-more-social") (question "Would you like more social features for group play?") (answers "Yes" "No")))
)

; RPGS fantasy casual not social
(defrule fantasy-social-no
    ?f <- (fantasy-more-social "No")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "Adventure Quest Worlds")))
)

; RPGS fantasy casual social
(defrule fantasy-social-yes
    ?f <- (fantasy-more-social "Yes")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "Dragon Fable")))
)

; RPGS fantasy age 1
(defrule fantasy-age-digits-one
    ?f <- (fantasy-age-digits "1 or not sure")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "Wizard 101")))
)

; RPGS fantasy age >=2
(defrule fantasy-anime
    ?f <- (fantasy-age-digits "2 or more")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "fantasy-anime") (question "Do you like cute, wide-eyed anime characters?") (answers "Yes" "No")))
)

; RPGS fantasy anime yes
(defrule fantasy-servants
    ?f <- (fantasy-anime "Yes")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "fantasy-servants") (question "Would you like to have magical servants?") (answers "Yes" "No")))
)

; RPGS fantasy servants no
(defrule fantasy-commitments
    ?f <- (fantasy-servants "No")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "fantasy-commitments") (question "How are you at making commitments?") (answers "Great" "Not so great")))
)

; RPGS fantasy servants yes
(defrule fantasy-servants-yes
    ?f <- (fantasy-servants "Yes")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)

    (assert (online-game (name "Grand Fantasia")))
)

; RPGS fantasy commitments yes
(defrule fantasy-commitments-yes
    ?f <- (fantasy-commitments "Great")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)

    (assert (online-game (name "Dream of Mirror")))
)

; RPGS fantasy commitments no
(defrule fantasy-commitments-no
    ?f <- (fantasy-commitments "Not so great")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)

    (assert (online-game (name "Eden Eternal")))
)

; RPGS fantasy anime no
(defrule fantasy-large-battles
    ?f <- (fantasy-anime "No")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "fantasy-large-battles") (question "Do you enjoy large scale battles?") (answers "Yes" "No")))
)

; RPGS fantasy large battles no
(defrule fantasy-pvp
    ?f <- (fantasy-large-battles "No")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "fantasy-pvp") (question "Are you looking for a game with an emphasis on player-vs-player fighting?") (answers "Yes" "No")))
)

; RPGS fantasy large battles yes
(defrule fantasy-lotr
    ?f <- (fantasy-large-battles "Yes")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "fantasy-lotr") (question "Did you like the Lord of the Rings trilogy?") (answers "Yes" "No")))
)

; RPGS fantasy lotr yes
(defrule fantasy-lotr-yes
    ?f <- (fantasy-lotr "Yes")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "Lord of the Rings Online")))
)

; RPGS fantasy lotr no
(defrule fantasy-quests-pets
    ?f <- (fantasy-lotr "No")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "fantasy-quests-pets") (question "Do you prefer a game with strong quests, or awesome pets?") (answers "Quests" "Pets")))
)

; RPGS fantasy quests
(defrule fantasy-quests
    ?f <- (fantasy-quests-pets "Quests")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "4Story")))
)

; RPGS fantasy pets
(defrule fantasy-pets
    ?f <- (fantasy-quests-pets "Pets")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "Aika")))
)

; RPGS fantasy pvp yes
(defrule fantasy-close-wow
    ?f <- (fantasy-pvp "Yes")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "fantasy-close-wow") (question "Would you like to find a game as close as possible to World of Warcraft?") (answers "Yes" "No")))
)

; RPGS fantasy pvp no
(defrule fantasy-grand-daddy
    ?f <- (fantasy-pvp "No")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "fantasy-grand-daddy") (question "Are you looking for something based on the grand-daddy of all RPGs, pen-and-paper Dungeons and Dragons? Or a more complex combat system") (answers "Dungeons and Dragons" "Combat system")))
)

; RPGS close wow yes
(defrule fantasy-close-wow-yes
    ?f <- (fantasy-close-wow "Yes")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "Runes of Magic")))
)

; RPGS close wow no
(defrule fantasy-distinctive-features
    ?f <- (fantasy-close-wow "No")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "fantasy-distinctive-features") (question "Which of these distinctive features appeals to you the most?") (answers "Auto-pilot" "Become a God" "Hack-n-slash")))
)

; RPGS auto-pilot
(defrule fantasy-distinctive-autopilot
    ?f <- (fantasy-distinctive-features "Auto-pilot")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "Crystal Saga")))
)

; RPGS become a God
(defrule fantasy-distinctive-god
    ?f <- (fantasy-distinctive-features "Become a God")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "Forsaken World")))
)

; RPGS hack-n-slash
(defrule fantasy-distinctive-hacknslash
    ?f <- (fantasy-distinctive-features "Hack-n-slash")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "Drakensang")))
)

; RPGS fantasy d&d yes
(defrule fantasy-dd-old
    ?f <- (fantasy-grand-daddy "Dungeons and Dragons")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "fantasy-dd-old") (question "Do you want an old-school D&D game or a cutting edge 3D experience?") (answers "Old-school" "Cutting edge")))
)

; RPGS fantasy d&d combat
(defrule fantasy-grand-daddy-combat
    ?f <- (fantasy-grand-daddy "Combat system")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "Age of Conan")))
)

; RPGS fantasy d&d oldschool
(defrule fantasy-dd-old-oldschool
    ?f <- (fantasy-dd-old "Old-school")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "Dark Swords")))
)

; RPGS fantasy d&d edge
(defrule fantasy-dd-old-cuttingedge
    ?f <- (fantasy-dd-old "Cutting edge")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "Dungeons and Dragons Online")))
)


; RPGS science fiction path
(defrule rpgs-ground-or-space
    ?f <- (rpgs-genre "Science Fiction")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "rpgs-ground-or-space") (question "Would you like to go on ground-based missions or stick to your spaceship?") (answers "Ground" "Space")))
)

;RPGS sf ground
(defrule rpgs-ground
    ?f <- (rpgs-ground-or-space "Ground")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "Star-Trek Online")))
)

; RPGS sf space
(defrule rpgs-space
    ?f <- (rpgs-ground-or-space "Space")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "rpgs-space") (question "Would you like a game that's easy to pick up, or one that takes some getting used to but is huge, epic and involved?") (answers "Easy" "Epic")))
)

;RPGS sf space easy
(defrule rpgs-space-easy
    ?f <- (rpgs-space "Easy")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "DarkOrbit")))
)

;RPGS sf space epic
(defrule rpgs-space-epic
    ?f <- (rpgs-space "Epic")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "Eve Online")))
)



; RPGS superheroes
(defrule incredibles-old
    ?f <- (rpgs-genre "Superheroes")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "incredibles-old") (question "Are you old enough to remember when The Incredibles came out?") (answers "Yes" "No")))
)

;RPGS superheroes old
(defrule superheroes-old-yes
    ?f <- (incredibles-old "Yes")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "DC Universe Online")))
)
;RPGS superheroes not old
(defrule superheroes-old-no
    ?f <- (incredibles-old "No")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "Superhero Squad Online")))
)



; RPGS different
(defrule vampire-hunting-werewolf-strange
    ?f <- (rpgs-genre "Something different")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "vampire-hunting-werewolf-strange") (question "Is being a vampire-hunting werewolf strange enough for you?") (answers "Yes" "No")))
)

;RPGS vampire hunting strange
(defrule vampire-hunting-yes
    ?f <- (vampire-hunting-werewolf-strange "Yes")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "Bitefight")))
)

;RPGS vampire hunting not strange
(defrule vampire-hunting-no
    ?f <- (vampire-hunting-werewolf-strange "No")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (online-game (name "Glitch")))
)