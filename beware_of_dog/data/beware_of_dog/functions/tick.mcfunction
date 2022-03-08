tag @a[gamemode=adventure] remove bd_near_wolf
#    to make this datapack compatible with other datapacks that make some wolves invulnerable, uncomment the following code
#execute as @e[type=wolf, nbt={Sitting:0b, Invulnerable:1b}] run tag @s add bd_otherwise_invulnerable
#execute as @e[type=wolf, nbt={Sitting:0b}, tag=!bd_otherwise_invulnerable] run data modify entity @s Invulnerable set value 0b
#execute as @e[type=wolf, nbt={Sitting:1b}] run data modify entity @s Invulnerable set value 1b
#    and comment the next 2 lines
execute as @e[type=wolf, nbt={Sitting:1b}] run data modify entity @s Invulnerable set value 1b
execute as @e[type=wolf, nbt={Sitting:0b}] run data modify entity @s Invulnerable set value 0b
execute as @e[type=wolf, nbt={Sitting:0b}] run tag @s remove bd_sat
execute as @e[type=wolf, nbt={Sitting:1b}, tag=!bd_sat] at @s unless entity @e[type=wolf, distance=0.1..30, nbt={Sitting:1b}] run tag @s add bd_sat
execute as @e[type=wolf, nbt={Sitting:1b}, tag=!bd_sat] at @s at @e[type=wolf, distance=0.1..30, nbt={Sitting:1b}] unless score @s bd_id = @e[type=wolf, sort=nearest, limit=1] bd_id run tellraw @p {"text":"Cannot sit dog near another dog", "color":"red"}
execute as @e[type=wolf, nbt={Sitting:1b}, tag=!bd_sat] at @s at @e[type=wolf, distance=0.1..30, nbt={Sitting:1b}] unless score @s bd_id = @e[type=wolf, sort=nearest, limit=1] bd_id run data modify entity @s Sitting set value 0b
execute as @e[type=wolf, nbt={Sitting:1b}] at @s at @a[distance=..30] if score @s bd_id matches 0.. unless score @s bd_id = @p bd_id run tag @p add bd_near_wolf
tellraw @a[gamemode=survival,tag=bd_near_wolf] [{"text":"Area protected by wolf. If stuck, use ", "color":"red"},{"text":"/trigger escape set 1", "color":"green"}]
gamemode adventure @a[gamemode=survival,tag=bd_near_wolf]
gamemode survival @a[gamemode=adventure, tag=!bd_near_wolf]
scoreboard players enable @a[tag=bd_near_wolf] escape
scoreboard players reset @a[tag=!bd_near_wolf] escape
execute as @e[type=wolf, nbt={Sitting:1b}] at @s if data entity @s Owner run function beware_of_dog:wolf_protection
execute as @a unless score @s bd_id matches 0.. store result score @a[limit=1] bd_id run time query gametime
execute as @a[scores={escape=1..}] at @s run function beware_of_dog:escape