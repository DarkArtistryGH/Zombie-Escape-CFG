If you want to know what a stripper is and how they are made, then follow the link - https://gflclan.com/forums/topic/47449-stripper-cfgs-guide/


———————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
"add:" directive, and "filter:" directive. The add directive allows us to use the entity addition feature, whereas the filter directive allows us to use the deletion via filter 
feature. The directives are placed at the top of a block in order to start using them.
———————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
match: This sub-block will search for all entities which match all the specified properties inside the block. 
Using classname/targetname is generally standard convention, as seen in this example, 
however if an entity does not have a targetname or it isn't unique, you may see classname/hammerid or classname/origin instead. 
Classname is rarely required, however it helps to have it there to keep track of what entity class is being modified. 
In the end, the only thing that's required is that your keyvalue combinations only return the entities you want to modify.
———————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
replace: This sub-block will replace the keys of the entities which are returned from the match sub-block, with the keyvalues that you specify inside the replace sub-block. 
In the example, it will replace all matched entities classnames with "trigger_multiple".
———————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
delete: This sub-block will delete the specified properties from the matched entities. In the example, 
it will search for the exact property key and value "filtername" "zombie", and then delete it from an entity returned by the match sub-block if it's present.
———————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
insert: This sub-block will insert the specified value from the key value pair inside the sub-block. In the example, 
it inserts "wait" "0" which is a keyvalue for trigger_multiples that determines how fast it can be re-triggered.
——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
