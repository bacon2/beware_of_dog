execute at @s run tag @p add tamer
execute at @s as @e[type=wolf, distance=..6] unless score @s bd_id matches 0.. store result score @s bd_id run scoreboard players get @p[tag=tamer] bd_id
execute at @s run tag @p remove tamer
advancement revoke @a only beware_of_dog:tame_wolf