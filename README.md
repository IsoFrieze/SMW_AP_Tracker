# PopTracker pack for SMW: Spicy Mycena Waffles Archipelago Randomizer
An PopTracker pack with map for\
[the SMW: Spicy Mycena Waffles Archipelago Randomizer](https://github.com/TheLX5/Archipelago/tree/waffles)

## Requirements
[PopTracker](https://github.com/black-sliver/PopTracker)

## Installation
1. Download the latest release from the Releases section on GitHub.
2. Place the downloaded zip file in the PopTracker packs directory.

## Usage
The tracker will show you which levels you currently have access to and what checks you can reach in each level.
It will also track your current abilities and egg count.

### Main Map
The main map (accessible via the `World Map` tab) shows which levels are accessible. You have to enter a level at least once before it will show up on this map. As per standard tracker convention, a green box means there are checks you can get in that level. Yellow means there are checks that you can potentially get but they are out of logic (e.g. limited by difficulty settings). Red means there are checks you cannot currently get. Gray means there are no checks left in that level.

The levels currently appear where they are in the vanilla game. If you have level shuffling enabled, this means the levels will seem scattered on the map. For example, if the first level you have access to is Butter Bridge 2 (located at Yoshi's Island 2 in game), you will see a box appear at the top of the world map where Butter Bridge 2 normally lies.

### Level Maps
Each level map (accessible via all the other tabs) shows all the checks that are found in a particular room. There will be one box per check.

There is an additional box at the top left corner of each map. This is a summary of all checks within this room. For example, if there are three checks in the room (a dragon coin and two blocks), this box will include all three checks together. This is useful so you can see at a glance if there is anything you can get in this room. If the dragon coin is out of logic, but the two blocks are in logic, this box will be half red and half green. Room checks will also be found in this box.

There are also boxes visible on every pipe and door. These boxes include summaries of all checks you can access by entering this level transition. This is useful so you can see at a glace if you need to go in that pipe or door.

### Items View
At the bottom of the tracker is a list of all of your current abilities. In order from left to right, top to bottom they are:

- Current number of Golden Yoshi Eggs
- Required number of Golden Yoshi Eggs to complete objective
  - If connected to an Archipelago server, this option will only sync once you have found and visited Yoshi's House
- Progressive Super Star
- P-Switch
- Midway Points
- Item Box
- Progressive Timer

- Progressive Powerup
- Progressive Yoshi
- Carry
- Climb
- Progressive Run
- Progressive Swim
- Spin Jump
- Extra Defense

- Yellow Switch Palace
- Gren Switch Palace
- Red Switch Palace
- Blue Switch Palace
- Special World Effects

### Settings
You can access the settings window on the top menu bar on Poptracker.
If connected to an Archipelago server, these should mostly be synced with the server so you don't need to touch them.

#### Goal Settings
Here you can change the goal between Beat Bowser and Collect Eggs. Current and required number of eggs are shown here too.

#### Check Settings
Here you can enable different types of checks. In order from left to right, top to bottom they are:

- Dragon Coin Checks
- 3-Up Moon Checks
- Hidden 1-Up Checks
- Bonus Block Checks
- Midway Point Checks
- Room Checks

- Coin Block Checks
- Item Block Checks
- Yellow Switch Block Checks
- Green Switch Block Checks
- Invisible Block Checks
- P-Switch Block Checks
- Flying Block Checks

#### Other Settings
Here are the remaining miscellaneous settings. In order from left to right they are:

- View All Levels
  - If enabled, all levels will be visible on the World Map regardless if you have access to them or not
- Auto Tab
  - If enabled and connected to an Archipelago server, the map will automatically change to the current level and room you are in
- Split Dragon Coin Logic
  - If disabled, all dragon coins in a level are tied to the same logic. In other words, all five dragon coins will have the same logic that is required to collect all five dragon coins.
  - If enabled, each dragon coin follows its own logic
    - If connected to an Archipelago server, remember that individual dragon coins are not checks; they will not sync with the server
    - If not connected to a server, the group dragon coin check for a level will turn blue when at least 5 of the individual dragon coin checks are completed to remind you to tick off that check as well
- Yoshi Inventory Logic
  - If enabled, checks that require Yoshi will take into account the ability to give yourself a Yoshi via the overworld inventory
- Enemy Shuffle
  - If enabled, modifies logic for certain checks knowing that certain enemies may not be where they usually are
- Game Mode Difficulty
  - Particularly difficult levels may be marked out of logic if you don't have enough abilities yet
  - Easy Mode
    - Medium levels require at least Big Mario and one of Midway Points or Item Box
    - Hard levels require at least Fire Mario and one of Midway Points, Item Box, or Extra Defense
  - Medium Mode
    - Medium levels require at least Big Mario
    - Hard levels require at least Big Mario and one of Midway Points or Item Box
  - Hard Mode
    - All levels always in logic

#### Carryless Exits
This tab tracks each level that contains a red orb instead of a keyhole, allowing you to get the secret exit without Carry.

If you are connected to an Archipelago server, these currently do not sync as it would introduce spoilers.

#### Extra Logic
This tab controls all of the extra logic settings. In order these are:

- Donut Plains 1 - Yoshi Jump to Key
  - Consider the ability to jump off of Yoshi to get to the secret exit
- Donut Plains 2 - Yoshi Jump to Key
  - Consider the ability to jump off of Yoshi to get to the secret exit
- Vanilla Dome 1 - Itemless Sinking Platform
  - Don't require Run and one of Big Mario or Super Star to get passed the sinking platform room
- Vanilla Dome 2 - Climbless Secret via Yoshi and Midway
  - Consider the ability to bring Yoshi into the midway point of the level and use his tongue to get the secret exit
- Vanilla Dome 4 - Sacrifice for Coin Block #8
  - Consider being able to jump off of Yoshi or Cape swipe the last coin block in the big row of blocks
- Vanilla Secret 1 - Wall Running
  - Consider the ability to wall run up the walls to reach the top of the level via Progressive Run
- Vanilla Secret 3 - Swimless
  - Don't require Swim to complete the level
- Lemmy's Castle - Itemless 1-Up blocks
  - Don't require Big Mario to be able to hit the 1-Up blocks at the start of the level
- Cheese Bridge Area - Secret Exit with Yoshi
  - Consider the ability to jump off of Yoshi to go under the first goal tape
- Ludwig's Castle - Runless
  - Don't require Run to get past the falling ceiling room
- Ludwig's Castle - Climbless
  - Consider the ability to wall run up the walls in the vertical room via Progressive Run
- Forest of Illusion 1 - Secret Exit with Yoshi
  - Consider the ability to jump off of Yoshi to get to the secret exit
- Forest of Illusion 1 - Secret Exit with Cape
  - Consider the ability to use cape flight to get to the secret exit
- Forest of Illusion 3 - Can pass big pipe itemless
  - Don't require Carry or Yoshi to be able to jump over the tall pipe
- Forest of Illusion 3 - Secret Exit with Yoshi
  - Consider the ability to use Yoshi's tongue to grab the key and hit the turn blocks to access the secret exit
- Forest Ghost House - Skip second room
  - Consider the ability to fly over with a Cape or wall run over the tall wall in the first room via Progressive Run
- Forest Secret Area - Itemless 1-Up block
  - Don't require Blue Switch to hit the 1-Up block
- Chocolate Island 1 - Damage Boost Past Munchers
  - Consider the ability to take an intentional hit to get past the row of Munchers
- Valley of Bowser 3 - Itemless Powerup block
  - Don't require Carry to be able to hit the item block by the midway point
- Valley of Bowser 4 - Yoshi Climb
  - Consider the ability to jump off of Yoshi to get past the vine block
- Valley of Bowser 4 - Climbless Secret via Yoshi and Midway
  - Consider the ability to bring Yoshi into the midway point of the level and use his tongue to get the secret exit
- Valley Ghost House - True Carryless Secret Exit
  - Don't require Carry to get the secret exit when the keyhole has been replaced with a red orb
- Star World 3 - Top area with a Star
  - Consider the ability to start the level with a Super Star via the overworld inventory
- Star World 4 - Carryless Secret Exit with Yoshi sacrifice
  - Consider the ability to jump off of Yoshi to get to the secret exit when the keyhole has been replaced with a red orb
- Awesome - Itemless
  - Don't require Super Star or one of Carry or P-Switch to complete the level
- Mondo - Swimless
  - Don't require Swim to complete the level
- Outrageous - Wall Run pipe
  - Don't require Carry or Yoshi's Tongue to pass the tall pipe

## Special Thanks
The Archipelago Community

The SMW Central Community
