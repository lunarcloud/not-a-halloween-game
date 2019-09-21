

== totem2
#showdialog

{ 
    - totem1:
        {totem1.wrong: Hey now, if you thought the other one was hard, watch out for me! Dare you? | Scared of us? Want to try me? }
    - else:
        {not totem2.wrong: Hahaha back for more?} Do you dare disturb me?
}
+ [Sure do] 
+ [No, sorry, nevermind] -> explore_map
-
Laura’s mother has four children: Stewart, Ursula, Rain and…
* Nicole -> wrong
+ Laura
* Alexandria -> wrong
* Ollie -> wrong
-
{{~Great job!|Very good.|Not much of a challenge}|You knew that one.}

What would you call something that paces back and forth on the ocean floor?
* A crab -> wrong
+ A nervous wreck
* A treasure map -> wrong
* A confused shark -> wrong
-
{{~Great job!|Very good.|Not much of a challenge}|You knew that one.}

If you throw a golden fishing rod into a blue sea what will it be
* Green -> wrong
+ Wet
* Brown -> wrong
* Cold -> wrong
-
{{~Great job!|Very good.|Not much of a challenge}|You knew that one.}

-> defeat

= defeat
No! How could you! #defeat:totem2
(destroyed) #hidedialog
{totem1.defeat: -> bob.last_totem }

-> explore_map

= wrong
Go away kid, come back when you're serious about word-play and lateral thinking.
. #hidedialog

-> explore_map