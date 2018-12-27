#!/usr/bin/ruby

class Thing
    def initialize(name, desc, usage, removable)
        #@room_loc = Array.new([loc_x, loc_y])
       
        @object_name = name
        @object_desc = desc
        @object_removable = removable
        @object_content = Array.new([])
        @object_usage = usage
    end

    def display_details()
        #puts "room loc #@room_loc"
        puts "object name #@object_name"
        puts "object desc #@object_desc"
        puts "object removable #object_removable"
    end

    def get_name()
        return @object_name
    end
    def get_desc()
        return @object_desc
    end

    def get_usage()
        return @object_usage
    end

    def get_removable()
        return @object_removable
    end
    def set_name(name )
        @object_name = name
    end
    def set_desc(d)
        @object_desc = d
    end

    def set_removable(r)
        @object_removable = r
    end

    def add_content(c)
        @object_content.push(c)
    end

    def remove_content(c)
        @object_content.delete(c)
    end

    def present?
        !blank?
    end
end
