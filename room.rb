#!/usr/bin/ruby

class Room
    @@no_of_customers = 0
    def initialize(name, desc)
        #@room_loc = Array.new([loc_x, loc_y])
	@room_id = -1       
        @room_name = name
        @room_desc = desc
        @room_doors = {"north"=>-1,"east"=>-1,"south"=>-1,"west"=>-1,"up"=>-1, "down"=>-1}
        @room_objects = Array.new
    end

    def set_id(id)
	@room_id = id
    end 
    def get_id()
	return @room_id
    end
    def display_details()
        #puts "room loc #@room_loc"
        puts "room name #@room_name"
        puts "room doors #@room_doors"
    end

    def update_door(direction, room)
        #if(@room_doors[direction]=="" and !@room_doors.has_value?(room))
           @room_doors[direction] = room
        #end
    end

    def get_name()
        return @room_name
    end
    def get_desc()
        return @room_desc
    end
    def get_doors()
        return @room_doors
    end

    def setChildRoom(cr)
        @room_doors = cr
    end

    def get_objects()
        return @room_objects
    end 

    def add_object(obj)
        @room_objects.push(obj)
    end

    def remove_object(obj)
        @room_objects.delete(obj)
    end

    def set_objects(objs)
        @room_objects = objs
    end

    def present?
        !blank?
    end
end
