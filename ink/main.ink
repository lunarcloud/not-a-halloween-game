/*
    Main Project File
*/
INCLUDE bob.ink
INCLUDE totem1.ink
INCLUDE totem2.ink
INCLUDE witch.ink
INCLUDE fishmen.ink

VAR PlayerX = 0
VAR PlayerY = 0

-> start

== start
#showdialog
It's the night before Halloween. I've gotta do some work.
Jared said there was a fire to put out in the graveyard. *sigh*
Damn hooligans...

-> explore_map

== explore_map
#music:explore
#hidedialog
Navigate around the world...
+ [Jared] 
    {fire1 and fire2: {~Thanks for taking care of those fires.|What's up? Oh, the brink of destruction you say? Crazy.} | Hey, the graveyard is still burning guy...}
    -> explore_map
* [Fire1] -> fire1
* [Fire2] -> fire2
+ [Bob] -> bob
+ {not totem1.defeat} [Totem1] -> totem1
+ {not totem2.defeat} [Totem2] -> totem2
+ [Witch] -> witch
+ {bob.save_again} [Fishman1] -> fishman1
-

-> END

= fire1
There. That's the {explore_map.fire2: second} fire put out...
-> post_fire
 
= fire2
Who would vandalize a graveyard like this?
-> post_fire

= post_fire
#fog:worse
{
    - fire1 and fire2: 
        Someone is doing Halloween wrong. It's not until tomorrow, people! 
        -> bob.chase 
    - else: 
        -> explore_map 
}