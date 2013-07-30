#!/Users/troy/.rvm/rubies/ruby-1.9.2-p320/bin/ruby
## ^ change to desired ruby location
################################################################################
# A simple character generator for Swords and Wizardry Core 4th printing       #
# From Mythmere and Frog God Games                                             #
# Coded by Troy Truchon while learning Ruby and LaTeX                          #
# Expect Mistakes                                                              #
################################################################################
# Send any questions/comments to:                                              #
#   Capheind@pdp10.org                                                         #
# Though totally unnecessary you can send donations (if so moved) to:          #
#   Capheind@gmail.com                                                         #
################################################################################
# Started 20130722                                                             #
#20130730 added Character class, removed testing puts, added Dicecup           #
################################################################################
#ToDo:                                                                         #
#-Implement some way to determine highest ability score of Character and select#
# a class based on that.                                                       #
#-Select starting equipment, probably will just implement a simple hash with   #
# strings of pre-generated equipment lists the way I handled ability score     #
# Tables.                                                                      #
#-Implement some way of outputting latex code using the template provided by   #
# Paul Gorman                                                                  #
#-Implement Ascending AC, I don't use it so its low on the priority list       #
################################################################################
3
## Dicerolling class
class Dicecup
   def stat ()
      (1 + rand(5)) + (1 + rand(5)) + (1 + rand(5))
   end
end

## The Character class will generate and hold all the information about the character being generated. 
class Character
   ## Generates ability scores for the new Character, 3D6 in order. 
   def initialize ()
      roll = Dicecup.new
      @strength = roll.stat
      @dexterity = roll.stat
      @constitution = roll.stat
      @intelligence = roll.stat
      @wisdom = roll.stat
      @charisma = roll.stat
      @highstat =  { @strength => "Strength", @dexterity => "Dexterity", @constitution => "Constitution", @intelligence => "Intelligence", @wisdom => "Wisdom", @charisma => "Charisma" }.max
   end
   ## Outputting the ability scores
   def str ()
      @strength
   end
   def dex ()
      @dexterity
   end
   def con ()
      @constitution
   end
   def int ()
      @intelligence
   end
   def wis ()
      @wisdom
   end
   def cha ()
      @charisma
   end
   def highstat ()
      @highstat
   end
end

## Strength table, pg. 6
str_bonus_table = {
    3 => { :to_hit_mod => -2, :dam_mod => -1, :open_doors => "1", :carry_mod => -10  },
    4 => { :to_hit_mod => -2, :dam_mod => -1, :open_doors => "1", :carry_mod => -10  },
    5 => { :to_hit_mod => -1, :dam_mod => -0, :open_doors => "1", :carry_mod => -5   },
    6 => { :to_hit_mod => -1, :dam_mod => -0, :open_doors => "1", :carry_mod => -5   },
    7 => { :to_hit_mod => 0, :dam_mod => 0, :open_doors => "1-2", :carry_mod => 0    },
    8 => { :to_hit_mod => 0, :dam_mod => 0, :open_doors => "1-2", :carry_mod => 0    },
    9 => { :to_hit_mod => 0, :dam_mod => 0, :open_doors => "1-2", :carry_mod => 5    },
    10 => { :to_hit_mod => 0, :dam_mod => 0, :open_doors => "1-2", :carry_mod => 5   },
    11 => { :to_hit_mod => 0, :dam_mod => 0, :open_doors => "1-2", :carry_mod => 5   },
    12 => { :to_hit_mod => 0, :dam_mod => 0, :open_doors => "1-2", :carry_mod => 5   },
    13 => { :to_hit_mod => 1, :dam_mod => 0, :open_doors => "1-2", :carry_mod => 10  },
    14 => { :to_hit_mod => 1, :dam_mod => 0, :open_doors => "1-2", :carry_mod => 10  },
    15 => { :to_hit_mod => 1, :dam_mod => 0, :open_doors => "1-2", :carry_mod => 10  },
    16 => { :to_hit_mod => 1, :dam_mod => 1, :open_doors => "1-3", :carry_mod => 15  },
    17 => { :to_hit_mod => 2, :dam_mod => 2, :open_doors => "1-4", :carry_mod => 30  },
    18 => { :to_hit_mod => 2, :dam_mod => 3, :open_doors => "1-5", :carry_mod => 50  },
}

## Dexterity table, pg. 7
dex_bonus_table = {
    3 => { :missle_hit_mod => -1, :ac_mod => 1    },
    4 => { :missle_hit_mod => -1, :ac_mod => 1    },
    5 => { :missle_hit_mod => -1, :ac_mod => 1    },
    6 => { :missle_hit_mod => -1, :ac_mod => 1    },
    7 => { :missle_hit_mod => -1, :ac_mod => 1    },
    8 => { :missle_hit_mod => -1, :ac_mod => 1    },
    9 => { :missle_hit_mod => 0, :ac_mod => 0     },
    10 => { :missle_hit_mod => 0, :ac_mod => 0    },
    11 => { :missle_hit_mod => 0, :ac_mod => 0    },
    12 => { :missle_hit_mod => 0, :ac_mod => 0    },
    13 => { :missle_hit_mod => +1, :ac_mod => -1  },
    14 => { :missle_hit_mod => +1, :ac_mod => -1  },
    15 => { :missle_hit_mod => +1, :ac_mod => -1  },
    16 => { :missle_hit_mod => +1, :ac_mod => -1  },
    17 => { :missle_hit_mod => +1, :ac_mod => -1  },
    18 => { :missle_hit_mod => +1, :ac_mod => -1  },
}

## Constitution table, pg. 7
con_bonus_table = {
    3 => { :hp_mod => -1, :rd_survival => 50   },
    4 => { :hp_mod => -1, :rd_survival => 50   },
    5 => { :hp_mod => -1, :rd_survival => 50   },
    6 => { :hp_mod => -1, :rd_survival => 50   },
    7 => { :hp_mod => -1, :rd_survival => 50   },
    8 => { :hp_mod => -1, :rd_survival => 50   },
    9 => { :hp_mod => 0, :rd_survival => 75    },
    10 => { :hp_mod => 0, :rd_survival => 75   },
    11 => { :hp_mod => 0, :rd_survival => 75   },
    12 => { :hp_mod => 0, :rd_survival => 75   },
    13 => { :hp_mod => +1, :rd_survival => 100 },
    14 => { :hp_mod => +1, :rd_survival => 100 },
    15 => { :hp_mod => +1, :rd_survival => 100 },
    16 => { :hp_mod => +1, :rd_survival => 100 },
    17 => { :hp_mod => +1, :rd_survival => 100 },
    18 => { :hp_mod => +1, :rd_survival => 1002 },
}

## Intelligence table, pg. 7
int_bonus_table = {
    3 => { :max_lang => 0, :max_spell_level => 4, :learn_spell => 30, :minmax_spells_per_level => "2/4"    },
    4 => { :max_lang => 0, :max_spell_level => 4, :learn_spell => 30, :minmax_spells_per_level => "2/4"    },
    5 => { :max_lang => 0, :max_spell_level => 4, :learn_spell => 30, :minmax_spells_per_level => "2/4"    },
    6 => { :max_lang => 0, :max_spell_level => 4, :learn_spell => 30, :minmax_spells_per_level => "2/4"    },
    7 => { :max_lang => 0, :max_spell_level => 4, :learn_spell => 30, :minmax_spells_per_level => "2/4"    },
    8 => { :max_lang => 1, :max_spell_level => 5, :learn_spell => 40, :minmax_spells_per_level => "3/5"    },
    9 => { :max_lang => 1, :max_spell_level => 5, :learn_spell => 45, :minmax_spells_per_level => "3/5"    },
    10 => { :max_lang => 2, :max_spell_level => 5, :learn_spell => 50, :minmax_spells_per_level => "4/6"   },
    11 => { :max_lang => 2, :max_spell_level => 6, :learn_spell => 50, :minmax_spells_per_level => "4/6"   },
    12 => { :max_lang => 3, :max_spell_level => 6, :learn_spell => 55, :minmax_spells_per_level => "4/6"   },
    13 => { :max_lang => 3, :max_spell_level => 7, :learn_spell => 65, :minmax_spells_per_level => "5/8"   },
    14 => { :max_lang => 4, :max_spell_level => 7, :learn_spell => 65, :minmax_spells_per_level => "5/8"   },
    15 => { :max_lang => 4, :max_spell_level => 8, :learn_spell => 75, :minmax_spells_per_level => "6/10"  },
    16 => { :max_lang => 5, :max_spell_level => 8, :learn_spell => 75, :minmax_spells_per_level => "7/10"  },
    17 => { :max_lang => 5, :max_spell_level => 9, :learn_spell => 85, :minmax_spells_per_level => "7/All" },
    18 => { :max_lang => 6, :max_spell_level => 9, :learn_spell => 95, :minmax_spells_per_level => "8/All" },
}

## Charisma table, pg. 7
cha_bonus_table = {
    3 => { :max_hirelings => 1 },
    4 => { :max_hirelings => 1 },
    5 => { :max_hirelings => 2 },
    6 => { :max_hirelings => 2 },
    7 => { :max_hirelings => 3 },
    8 => { :max_hirelings => 3 },
    9 => { :max_hirelings => 4 },
    10 => { :max_hirelings => 4 },
    11 => { :max_hirelings => 4 },
    12 => { :max_hirelings => 4 },
    13 => { :max_hirelings => 5 },
    14 => { :max_hirelings => 5 },
    15 => { :max_hirelings => 5 },
    16 => { :max_hirelings => 6 },
    17 => { :max_hirelings => 6 },
    18 => { :max_hirelings => 7 },
}

oneshot = Character.new

puts "Strength: %s, To Hit Modifier: %s, Damage Modifier: %s, Chance to open doors: %s, Carrying Capacity Modifier: %s" % [ oneshot.str, str_bonus_table[oneshot.str][:to_hit_mod], str_bonus_table[oneshot.str][:dam_mod], str_bonus_table[oneshot.str][:open_doors], str_bonus_table[oneshot.str][:carry_mod] ]
puts "Dexterity: %s, Missle To Hit Modifier: %s, Armor Class Modifier: %s" % [ oneshot.dex, dex_bonus_table[oneshot.dex][:missle_hit_mod], dex_bonus_table[oneshot.dex][:ac_mod] ]
puts "Constitution: %s, Hit Point Modifier: %s, Raise Dead Survival Chance: %s" % [ oneshot.con, con_bonus_table[oneshot.con][:hp_mod], con_bonus_table[oneshot.con][:rd_survival] ]
puts "Intelligence: %s, Maximum number of Additional Languages: %s, Maximum Spell Level: %s, Chance to Learn Spell: %s, Min/Max number of Basic Spells Understandable per Level: %s" % [ oneshot.int, int_bonus_table[oneshot.int][:max_lang], int_bonus_table[oneshot.int][:max_spell_level], int_bonus_table[oneshot.int][:learn_spell], int_bonus_table[oneshot.int][:minmax_spells_per_level] ]
puts "Wisdom: %s" % [ oneshot.wis ]
puts "Charisma: %s, Maximum Number of Special Hirelings: %s" % [ oneshot.cha, cha_bonus_table[oneshot.cha][:max_hirelings] ]
puts oneshot.highstat
