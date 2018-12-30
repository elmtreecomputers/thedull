#!/usr/bin/ruby

require_relative 'thing'

class Food < Thing
    def initialize(name, desc, usage, removable)
    	super(name, desc, usage, removable)
    	@energy = 25
    end

	def get_energy()
		return @energy
	end

	def set_energy(e)
		@energy = e
	end
end