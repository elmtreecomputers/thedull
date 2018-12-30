#!/usr/bin/ruby

class Player
    @@no_of_customers = 0
    def initialize(name, loc)
        #@room_loc = Array.new([loc_x, loc_y])
       
      @player_name = name
      @player_loc = Array.new(loc)
      @player_row = @player_loc[0]
      @player_col = @player_loc[1]
      @player_objects = Hash.new
      @player_stamina = 100
      @player_score = 0
	    @room_id = 0
    end

    def set_room_id(id)
	    @room_id = id
    end

    def get_room_id()
	    return @room_id
    end

    def display_details()
        #puts "room loc #@room_loc"
      puts "player name #@player_name"
      puts "player loc #@player_loc"
    end


    def set_score(s)
      @player_score = s
    end
    def set_stamina(s)
      @player_stamina = s
    end

    def get_score()
      return @player_score
    end
    def get_stamina()
      return @player_stamina
    end

    def get_name()
      return @player_name
    end
    def get_loc()
      return @player_loc
    end
    def get_objects()
      return @player_objects
    end
    def get_object(item)
      return @player_objects[item]
    end

    def got_object(key)
      if @player_objects.has_key?(key)
      	return true
      end
      return false
    end


    def set_name(name )
      @player_name = name
    end
    def set_loc(loc)
      @player_loc = loc
      @player_row = @player_loc[0]
      @player_col = @player_loc[1]
    end
    def add_object(key,object)
      @player_objects.store(key,object)
    end

    def remove_object(key)
      @player_objects.delete(key)
    end

    def get_row()
      return @player_loc[0]
    end

    def get_col()
      return @player_loc[1]
    end
    
    def set_row(r)
      @player_loc[0] = r
    end

    def set_col(c)
      @player_loc[1] = c
    end
    def present?
      !blank?
    end
end
