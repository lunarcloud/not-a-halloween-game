

== bob
{last_totem: -> bad_news}
#showdialog
hello

-> explore_map

= chase
#showdialog

Bob: Help ME! #bob:run_from_witch
Witch: I'll get you yet! #witch:enter_attacking_bob
Bob: Please, no!
(watch the cutscene) #hidedialog #witch:throw_fireball
Witch: hahahahaha #showdialog
(put bob out) #hidedialog
Bob: Oh my goodness. Thank you for saving me!
What was all that about? Is that the cranky old lady who yells a lot at town halls?
Bob: Yeah... she's my landlord. It's been awful since I moved here.
Bob: Loretta's a witch. I'm not just being rude, mind you. She's actually practicing some horrible ritual.
Bob: So, Loretta apparently has quite a beef with the town. 
Bob: It's taken her a long time to do it, but she has these totems all over town. #bob:show_totem
Bob: I've found this one, but those fireballs did a number on me. #bob:destroy_totem
Bob: Please, I need you to find and destroy the others... or the fish... #bob_rest

-> explore_map

= last_totem
#showdialog

Bob: Incredible! You've only got one more totem to defeat!
Bob: If only you didn't have to destroy them all, but once the spell gets started, it's gotta be stopped completely.
Bob: But... So... there's a coice you need to make.
Bob: I'm the last totem. There was a clause in my rental agreement that allowed her to curse me as one of her totems.
Bob: Always read the fine print, man.
Bob: Anyway, you gotta kill me to break the spell that's still brewing.
Bob: I'll be down by the southern beach.

-> explore_map

= bad_news
#showdialog

Bob: Did you make your choice?
* [Yes] 
    Bob: So, you ready to kill me? #witch:enter_laughing
    * [Yes] I'm ready... -> kill
    * No[], I'm going to save you yet! -> save_again
    -
* [No] -> explore_map

= kill
You hesitate, but if it's the only way... #stab_bob
Witch: What's happening? #fog:clear
Bob: Take care of my cat for me... and always check your rental agreement...
#fadetoblack
Witch: The spell! It's failing! Noooo
Witch: It's going to take forever scowling ebay for more totems! I can't afford that 'buy it now' price!
Sad End.

-> END

= save_again
Bob: What? But the spell, the summoning!? The fish people are coming! #lightning
(fishmen cutscene) #hidedialog #fishmen:enter_from_sea
... #showdialog
Witch: Yes! Come out of the sea! Take over their homes! Destroy!!
Bob: What... what have you done?
Witch: What are they doing? What have you done?
You notice that the fishmen are just milling about. Maybe we should talk to them.

-> explore_map
