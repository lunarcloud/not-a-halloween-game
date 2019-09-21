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
+ [jeremy] hi -> explore_map
* [fire1] -> fire1
* [fire2] -> fire2
+ [bob] -> bob
+ {not totem1.defeat} [totem1] -> totem1
+ {not totem2.defeat} [totem2] -> totem2
+ [witch] -> witch
+ {bob.save_again} [fishman1] -> fishman1
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