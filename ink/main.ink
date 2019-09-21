/*
    Main Project File
*/
INCLUDE bob.ink
INCLUDE totem1.ink
INCLUDE totem2.ink
INCLUDE witch.ink

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
+ [fire1] -> fire1
+ [fire2] -> fire2
+ [bob] -> bob -> explore_map
+ [totem1] -> totem1 -> explore_map
+ [totem2] -> totem2 -> explore_map
+ [witch] -> witch -> explore_map
-

-> END

= fire1
There's that fire put out...
 -> explore_map
 
= fire2
Who would vandalize a graveyard like this?
Someone is doing Halloween wrong. It's not until tomorrow, people!
 -> explore_map