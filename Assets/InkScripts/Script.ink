// Story Variables
VAR trustLevel = 0        // Tracks trust with other characters
VAR mentalState = 100     // Tracks mental health/stability
VAR supplies = 50         // Tracks resource management
VAR archetype = ""        // Tracks player's chosen hero archetype

// Sound and Music Cues
// Background tracks:
// - "ambient_bunker.mp3" : Continuous low hum, distant alarms
// - "tension_raiders.mp3": Intense, threatening music
// - "hope_theme.mp3": Uplifting, determined melody
// - "wasteland_ambient.mp3": Desolate, wind-swept soundscape

// Sound effects:
// - "door_open.mp3"
// - "gunshot.mp3"
// - "radio_static.mp3"
// - "explosion_distant.mp3"

EXTERNAL Name(charName)
EXTERNAL TrustLevel(trustLevel)
EXTERNAL MentalState(mentalState)
EXTERNAL Supplies(supplies)
EXTERNAL Archetype(archetype)
EXTERNAL Play(song)
EXTERNAL Sound(sound)


// Story Structure: Hero's Journey
// Play: ambient_bunker.mp3
-> start
=== start ===
~ trustLevel = 0      
~ mentalState = 100     
~ supplies = 50         
~  archetype = "" 
{Play("ambient_bunker")}
{Name("Narrator")}
{TrustLevel(trustLevel)}
{MentalState(mentalState)}
{Supplies(supplies)}
{Archetype(archetype)}
You wake up in a small, dimly lit bunker. Red emergency lights flicker overhead.
The world outside is no longer safe - the apocalypse came swiftly and without mercy.
Before everything fell apart, you were a:

+ [Former Military Medic]
    ~ archetype = "Medic"
    ~ supplies += 10
    {Archetype(archetype)}
    {Supplies(supplies)}
    Your medical training might be crucial for survival.
    The emergency kit in your bag contains vital supplies.
    -> introduction_medic

+ [Survival Expert]
    ~ archetype = "Expert"
    ~ supplies += 5
    ~ mentalState += 10
    {Archetype(archetype)}
    {Supplies(supplies)}
    {MentalState(mentalState)}
    Years of wilderness training prepared you for this.
    Your knowledge of the land could be the difference between life and death.
    -> introduction_expert

+ [Tech Specialist]
    ~ archetype = "Specialist"
    ~ trustLevel += 5
    {Archetype(archetype)}
    {Supplies(supplies)}
    {MentalState(mentalState)}
    Your understanding of systems and technology gives you an edge.
    The tablet in your hand still works - a rare commodity now.
    -> introduction_scholar

=== introduction_medic ===
// Sound: distant_explosion.mp3
{Sound("explosion_distant")}
{Name("Narrator")}
Alarms blare in the distance. The door to the bunker is locked, and you're alone with the sound of your own heartbeat.
Your chosen path will determine not just your survival, but who you become in this new world.

// Sound: door_knock.mp3
{Sound("door_open")}
{Name("Marcus")}
Hey, anyone alive in there? I'm a trader, name's Marcus. 
I can help you out. You don't have to be alone!

+ [How do I know I can trust you?]
    ~ trustLevel += 5
    ~ mentalState += 5
    {TrustLevel(trustLevel)}
    {MentalState(mentalState)}
    I get it, you're cautious. As a fellow healer, I respect that.
    I've got medical supplies we could share.
    -> trust_path_medic

+ [Leave me alone!]
    ~ trustLevel -= 5
    ~ mentalState -= 10
    {TrustLevel(trustLevel)}
    {MentalState(mentalState)}
    Suit yourself. But isolation isn't the answer.
    The world's getting worse out here.
    -> isolation_path
    
=== introduction_expert ===
// Sound: distant_explosion.mp3
{Sound("explosion_distant")}
{Name("Narrator")}
Alarms blare in the distance. The door to the bunker is locked, and you're alone with the sound of your own heartbeat.
Your chosen path will determine not just your survival, but who you become in this new world.

// Sound: door_knock.mp3
{Sound("door_open")}
{Name("Marcus")}
Hey, anyone alive in there? I'm a trader, name's Marcus. 
I can help you out. You don't have to be alone!

+ [How do I know I can trust you?]
    ~ trustLevel += 3
    {TrustLevel(trustLevel)}
    Your survival instincts are good. I've mapped safe routes through the wasteland.
    Together, we could help others navigate this chaos.
    -> trust_path_expert

+ [Leave me alone!]
    ~ trustLevel -= 5
    ~ mentalState -= 10
    {TrustLevel(trustLevel)}
    {MentalState(mentalState)}
    Suit yourself. But isolation isn't the answer.
    The world's getting worse out here.
    -> isolation_path

=== introduction_scholar ===
// Sound: distant_explosion.mp3
{Sound("explosion_distant")}
{Name("Narrator")}
Alarms blare in the distance. The door to the bunker is locked, and you're alone with the sound of your own heartbeat.
Your chosen path will determine not just your survival, but who you become in this new world.

// Sound: door_knock.mp3
{Sound("door_open")}
{Name("Marcus")}
Hey, anyone alive in there? I'm a trader, name's Marcus. 
I can help you out. You don't have to be alone!

+ [How do I know I can trust you?]
    ~ trustLevel += 4
    {TrustLevel(trustLevel)}
    {MentalState(mentalState)}
    Your technical expertise could be invaluable. I've found working communication equipment.
    We could establish a network of survivors.
    -> trust_path_scholar

+ [Leave me alone!]
    ~ trustLevel -= 5
    ~ mentalState -= 10
    {TrustLevel(trustLevel)}
    {MentalState(mentalState)}
    Suit yourself. But isolation isn't the answer.
    The world's getting worse out here.
    -> isolation_path

=== trust_path_medic ===
// Play: hope_theme.mp3
{Play("hope_theme")}

{Name("Narrator")}
You decide to trust Marcus. As you work together, your skills complement each other.
Days pass, and your partnership proves valuable. But the wasteland has other plans.

+ [Share your knowledge]
    ~ trustLevel += 10
    ~ supplies -= 5
    {TrustLevel(trustLevel)}
    {Supplies(supplies)}
    You teach Marcus basic medical care. He's a quick learner.
    Your compassion strengthens your alliance.
    -> medical_crisis
    
=== trust_path_expert ===
// Play: hope_theme.mp3
{Play("hope_theme")}
{Name("Narrator")}
You decide to trust Marcus. As you work together, your skills complement each other.
Days pass, and your partnership proves valuable. But the wasteland has other plans.

+ [Explore together] 
    ~ supplies += 10
    ~ mentalState += 5
    {MentalState(mentalState)}
    {Supplies(supplies)}
    You lead successful scavenging missions. Marcus knows good trading spots.
    Your expertise keeps you both alive.
    -> exploration_crisis
    
=== trust_path_scholar ===
// Play: hope_theme.mp3
{Play("hope_theme")}
{Name("Narrator")}
You decide to trust Marcus. As you work together, your skills complement each other.
Days pass, and your partnership proves valuable. But the wasteland has other plans.

+ [Establish communications]
    ~ trustLevel += 8
    {TrustLevel(trustLevel)}
    You repair an old radio system. Information becomes your currency.
    Your technical skills open new possibilities.
    -> tech_crisis

=== medical_crisis ===
// Play: tension_raiders.mp3
{Play("tension_raiders")}
{Name("Narrator")}
A group of injured survivors arrives at your bunker. Among them is someone you recognize - 
the leader of the raiders who destroyed your old community.

+ [Help everyone equally]
    ~ trustLevel += 15
    ~ supplies -= 20
    ~ mentalState += 10
    {TrustLevel(trustLevel)}
    {MentalState(mentalState)}
    {Supplies(supplies)}
    Your compassion transcends old grudges.
    This choice will be remembered.
    -> healer_ending

+ [Refuse to help the raiders]
    ~ trustLevel -= 10
    ~ mentalState -= 5
    {TrustLevel(trustLevel)}
    {MentalState(mentalState)}
    You stand by your principles, but at what cost?
    The raiders won't forget this.
    -> conflict_ending

=== exploration_crisis ===
// Play: wasteland_ambient.mp3
{Play("wasteland_ambient")}
{Name("Narrator")}
You discover a hidden military bunker, but it's being watched by multiple groups.
Your next move could change everything.

+ [Lead a stealth mission]
    ~ supplies += 30
    ~ mentalState -= 10
    {MentalState(mentalState)}
    {Supplies(supplies)}
    Your survival skills prove crucial.
    But the cost of secrecy weighs heavy.
    -> explorer_ending

+ [Negotiate with other groups]
    ~ trustLevel += 20
    ~ supplies += 10
    {TrustLevel(trustLevel)}
    {Supplies(supplies)}
    You build a network of allies.
    The wasteland becomes less lonely.
    -> diplomat_ending

=== tech_crisis ===
// Sound: radio_static.mp3
{Sound("radio_static")}
{Name("Narrator")}
Your repaired communications reveal a terrible truth - 
a second wave of destruction is coming. You have vital information that could save many.

+ [Broadcast the warning]
    ~ trustLevel += 25
    ~ mentalState -= 15
    {TrustLevel(trustLevel)}
    {MentalState(mentalState)}
    You become a beacon of hope.
    But knowledge brings responsibility.
    -> scholar_ending

+ [Keep the information secret]
    ~ trustLevel -= 20
    ~ supplies += 20
    {TrustLevel(trustLevel)}
    {Supplies(supplies)}
    You focus on personal survival.
    The weight of secrets changes you.
    -> pragmatic_ending

=== healer_ending ===
// Play: hope_theme.mp3
{Play("hope_theme")}
{Name("Narrator")}
Your compassion transforms the wasteland. Former enemies become allies.
You establish a medical haven, saving countless lives.
The world may be broken, but you help heal its people.
-> ending

=== conflict_ending ===
// Play: tension_raiders.mp3
{Play("tension_raiders")}
{Name("Narrator")}
Your stance against the raiders leads to ongoing conflict.
But you build a strong, principled community.
Sometimes survival requires difficult choices.
-> ending

=== explorer_ending ===
// Play: wasteland_ambient.mp3
{Play("wasteland_ambient")}
{Name("Narrator")}
Your knowledge of the wasteland makes you legendary.
You map safe routes and establish trading networks.
In the chaos, you find your true calling.
-> ending

=== diplomat_ending ===
// Play: hope_theme.mp3
{Play("hope_theme")}
{Name("Narrator")}
Your leadership unites different survivor groups.
A new society emerges from the ashes.
Hope returns to the wasteland.
-> ending

=== scholar_ending ===
// Play: tension_raiders.mp3
{Play("tension_raiders")}
{Name("Narrator")}
Your warning saves thousands. Knowledge becomes power.
You establish a network of information and technology.
In understanding the past, you help build the future.
-> ending

=== pragmatic_ending ===
// Play: wasteland_ambient.mp3
{Play("wasteland_ambient")}
{Name("Narrator")}
Your choice to withhold information haunts you.
But your small group survives against all odds.
Sometimes survival comes at a moral cost.
-> ending

// Isolation Path

=== isolation_path ===
// Play: wasteland_ambient.mp3
{Play("wasteland_ambient")}
{Name("Narrator")}
You slam the door shut and retreat into the depths of the bunker. 
The sound of Marcus’s voice fades as you choose to stay alone, avoiding any possible betrayal or danger.
The walls of the bunker close in, but the isolation becomes your new reality.

+ [Search the bunker for supplies]
    ~ supplies += 15
    {Supplies(supplies)}
    You find a hidden stash of canned food and medical supplies.
    But even as you gather, a strange unease settles in your gut.
    -> solitary_crisis

+ [Sit and wait for something to change]
    ~ mentalState -= 5
    {MentalState(mentalState)}
    The hours stretch into days. Every creak and groan of the bunker seems amplified.
    You wonder if you’ve made the right decision.
    -> mental_deterioration

=== solitary_crisis ===
// Play: tension_raiders.mp3
{Play("tension_raiders")}
{Name("Narrator")}
You hear noises outside – faint whispers and footsteps. 
The door to your bunker rattles. Someone is trying to get in.

+ [Prepare to defend yourself]
    ~ supplies -= 5
    ~ mentalState -= 10
    {MentalState(mentalState)}
    {Supplies(supplies)}
    You take the few weapons you have and prepare for a fight. But the silence outside grows louder.
    -> defense_crisis

+ [Stay hidden and wait for them to leave]
    ~ trustLevel -= 5
    ~ mentalState -= 15
    {TrustLevel(trustLevel)}
    {MentalState(mentalState)}
    You hold your breath, hoping the intruders don’t find you. The fear gnaws at you, but you remain silent.
    -> vulnerability_crisis

=== mental_deterioration ===
// Play: tension_raiders.mp3
{Play("tension_raiders")}
{Name("Narrator")}
Your mind begins to slip as you isolate yourself further.
Loneliness and fear creep into your thoughts. You hear voices in the dark, but you’re unsure if they’re real.

+ [Try to repair something in the bunker]
    ~ supplies -= 10
    ~ mentalState -= 20
    {MentalState(mentalState)}
    {Supplies(supplies)}
    You attempt to fix something, anything. The distraction helps momentarily, but it doesn’t quiet the madness.
    -> breakdown

+ [Shout for help]
    ~ trustLevel -= 10
    ~ mentalState -= 25
    {TrustLevel(trustLevel)}
    {MentalState(mentalState)}
    The fear finally overtakes you, and you shout into the emptiness. There’s no answer, only echoes.
    -> breakdown

=== defense_crisis ===
// Play: gunshot.mp3
{Sound("gunshot")}
{Name("Narrator")}
The door bursts open. Raiders pour in, guns drawn. You try to defend yourself, but you're outnumbered.

+ [Fight until the end]
    ~ supplies -= 15
    ~ mentalState -= 30
    {MentalState(mentalState)}
    {Supplies(supplies)}
    You fight bravely, but your strength is fading. The raiders overpower you.
    -> death_by_raid

+ [Surrender and beg for mercy]
    ~ trustLevel -= 10
    ~ mentalState -= 20
    {TrustLevel(trustLevel)}
    {MentalState(mentalState)}
    You drop your weapons and plead for your life. The raiders hesitate for a moment, then laugh.
    -> capture_ending

=== vulnerability_crisis ===
// Play: radio_static.mp3
{Sound("radio_static")}
{Name("Narrator")}
You wait in silence, praying the intruders leave. After hours of tense quiet, the door opens slightly.

+ [Attack the intruder]
    ~ supplies -= 10
    ~ mentalState -= 15
    {MentalState(mentalState)}
    {Supplies(supplies)}
    You try to strike first, but the figure dodges. The struggle is intense, but you manage to push them out.
    -> lone_survival

+ [Call out and reveal yourself]
    ~ trustLevel -= 5
    ~ mentalState -= 10
    {TrustLevel(trustLevel)}
    {MentalState(mentalState)}
    You call out, revealing yourself to whoever is on the other side. It’s Marcus, back with a group.
    -> reuniting_ending

=== breakdown ===
// Play: explosion_distant.mp3
{Sound("explosion_distant")}
{Name("Narrator")}
The isolation has taken its toll. You can no longer tell what’s real and what’s in your head.
The walls close in tighter, the air thinner.

+ [End it now]
    ~ mentalState = 0
    {MentalState(mentalState)}
    You can’t take it anymore. Everything feels meaningless. The weight of the wasteland crushes your spirit.
    -> final_breakdown

+ [Try to hold on]
    ~ mentalState -= 10
    {MentalState(mentalState)}
    You push yourself to survive, but your mind slips further. There’s no escape from the void.
    -> final_breakdown

=== death_by_raid ===
// Play: gunshot.mp3
{Sound("gunshot")}
{Name("Narrator")}
The raiders take you down in a violent barrage of gunfire.
Your last thoughts are of the choices you made, and how isolation led to your end.

-> ending

=== capture_ending ===
// Play: radio_static.mp3
{Sound("radio_static")}
{Name("Narrator")}
The raiders take you captive. Your once peaceful isolation is shattered. 
Now, you’re part of their twisted network. A pawn in a dangerous game.

-> ending

=== lone_survival ===
// Play: wasteland_ambient.mp3
{Play("wasteland_ambient")}
{Name("Narrator")}
You survive the attack, but the loneliness deepens. You’re now a legend among survivors – the lone warrior who fights on against all odds.
But the isolation lingers, haunting your every move.

-> ending

=== reuniting_ending ===
// Play: hope_theme.mp3
{Play("hope_theme")}
{Name("Narrator")}
Marcus returns with a group of survivors. You are no longer alone, but the scars of isolation run deep. 
You rebuild together, but it’s not the same. The weight of your solitary past never fully lifts.

-> ending

=== final_breakdown ===
// Play: tension_raiders.mp3
{Play("tension_raiders")}
{Name("Narrator")}
You’ve reached the breaking point. The isolation, the fear, the endless silence – it has destroyed you. 
There’s nothing left but darkness.

-> ending

=== ending ===
{Name("Narrator")}
You have reached the end of the game. Would you like to start again from inside the bunker?
+ [Yes! Take me at the beginning!]
    Great choice!
    -> start
+ [No, thank you!]
    Okay!
    -> END



// Save/Load System Implementation Notes:
// - Save current variable states (trustLevel, mentalState, supplies)
// - Store chosen archetype
// - Track story position
// - Save array of previous choices
// - Implementation through Unity PlayerPrefs or custom serialization

// Variables to track in Unity:
// 1. trustLevel: int (0-100) - Affects story branches and NPC interactions
// 2. mentalState: int (0-100) - Influences available choices and dialogue
// 3. supplies: int (0-100) - Determines survival options and story paths

// Story Tree Structure:
// - Main Branch: Trust vs. Isolation
// - Character Development Path: Based on chosen archetype
// - Crisis Points: Medical, Exploration, or Technical
// - Multiple Endings: Based on accumulated choices and variables

// Universal Archetypes Used:
// - The Healer (Medic)
// - The Explorer (Expert)
// - The Scholar (Specialist)

// Story Loop Implementation:
// 1. Character Development: Player's choices shape their skills and story.
// 2. Crisis Points: Events trigger new story paths.
// 3. Trust vs Isolation: Trust affects relationships and outcomes.
// 4. Resource Management: Supplies impact survival and decisions.