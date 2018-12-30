
require 'pp'
require_relative 'room'
require_relative 'player'
require_relative 'thing'
require_relative 'food'
require_relative 'enemy'
require 'colorize'
require 'colorized_string'
require 'curses'

def welcome()
	Curses.init_screen
	Curses.start_color
	Curses.init_pair(1,Curses::COLOR_BLUE,Curses::COLOR_BLACK)
	begin
  		win = Curses.stdscr
  		x = win.maxx / 2
  		y = win.maxy / 2
  		win.setpos(y-10, x-50)
  	
  		win.attrset(Curses.color_pair(1)|Curses::A_BOLD)
  		
  		win.addstr("The DULL")
  		win.setpos(y-8, x-50)
  		sleep 1
  		win.addstr("Command words: use, go, look, get, drop, talk, fight")
  		win.refresh
  		win.getch
	ensure
  		Curses.close_screen
	end
end


def victory()
	Curses.init_screen
	Curses.start_color
	Curses.init_pair(1,Curses::COLOR_BLUE,Curses::COLOR_BLACK)
	begin
  		win = Curses.stdscr
  		x = win.maxx / 2
  		y = win.maxy / 2
  		win.setpos(y-10, x-50)
  	
  		win.attrset(Curses.color_pair(1)|Curses::A_BOLD)
  		
  		win.addstr("VICTORIOUS!")
  		win.setpos(y-8, x-50)
  		sleep 1
  		win.addstr("Vrooooom")
  		win.refresh
  		win.getch
	ensure
  		Curses.close_screen
	end
end

'''
def randomise(direction)    
    selected_direction = direction.sample #$direction[prng.rand(3)]
    direction.delete(selected_direction)
    print selected_direction
    return selected_direction
end

def createdoors()
    srng = Random.new
    sides = Array.new(srng.rand(1..3))
    direction = ["north", "east", "south","west"]
    sides.length.times do
        |x| print x
        sel = direction.sample
        sides[x] = sel
        direction.delete(sel)
    
    end
    pp sides
    return sides
end
'''
print
$coin = Thing.new("coin", "Golden coin worth $5", "", true)
$book = Thing.new("book", "How to program with Ruby", "read every page...", true)
$key = Thing.new("key", "Small misterious key", "turn it", true)
$hammer = Thing.new("hammer", "Wooden one, strong enough to knock plastic nails", "swing it... bang!", true)
$map = Thing.new("map", "Dusty local map", "locate your self", true)
$bed = Thing.new("bed", "Comfy spring bed", "you rest well for few hours", false)
$motor = Thing.new("motorcycle", "Getaway motor cycle", "escape to another town", false)
$things = Array.new
$food = Food.new("banana", "simple plain old yellow banana", "satisfy your hunger", true)

'''
def place_a_thing()
    selected_thing = $things.sample #$direction[prng.rand(3)]
    $things.delete(selected_thing)
    print selected_thing
    return [selected_thing]    
end
'''

$bedroom = Room.new("bed room", "your bed room")
$shop = Room.new("shop", "a shop")
$tunnel = Room.new("tunnel", "underground tunnel")
$garden = Room.new("garden", "open garden")
$campus = Room.new("campus", "big campus")

$valid_rooms = Array.new
$maze_row = 0
$maze_col = 0

$maze_max_row = 4
$maze_max_col = 5

$therooms = Array.new

$victorious = false

$a = []

#print "length", a.length



def checksurrounding2(row, col)
    #check north
    #print "#{row} #{col}"
    #print a[row][col].get_name
    if(row==0)
        #print ("#{$row} #{$col} North is nil")

        $a[row][col].update_door("north","")
    else
        #print("North is ", a[row-1][col].get_name)
        $a[row][col].update_door("north", $a[row-1][col].get_name)
    end

    if(row==2)
        #print ("South is nil")    
        $a[row][col].update_door("south","")
    else
        #print("South is ", a[row+1][col].get_name)
        $a[row][col].update_door("south", $a[row+1][col].get_name)
    end

        #check north
    if(col==0)
        #print ("West is nil")    
        $a[row][col].update_door("west","")
    else
        #print("West is ", a[row][col-1].get_name)
        $a[row][col].update_door("west", $a[row][col-1].get_name)
    end
    
    if(col==2)
        #print ("East is nil")    
        $a[row][col].update_door("east","")
    else
        #print("East is ", a[row][col+1].get_name)
        $a[row][col].update_door("east", $a[row][col+1].get_name)
    end
end
def lockdoor(row, col)
    #check north
    #print "#{row} #{col}"
    #print a[row][col].get_name

    #pp $a.length
    if($a[row-1]!=$a[$maze_row-1])
        $a[row][col].update_door("north", $a[row-1][col].get_id)
    else
        $a[row][col].update_door("north", -1)
    end

    if($a[row+1]!=nil)
        $a[row][col].update_door("south", $a[row+1][col].get_id)
    else
        $a[row][col].update_door("south", -1)
    end
    if($a[row][col-1]!=$a[row][$maze_col-1])
        $a[row][col].update_door("west", $a[row][col-1].get_id)
    else
        $a[row][col].update_door("west", -1)
    end
    if($a[row][col+1]!=nil)
        $a[row][col].update_door("east", $a[row][col+1].get_id)
    else
        $a[row][col].update_door("east", -1)
    end
end


def checksurrounding(row, col)
    #check north
    #print "#{row} #{col}"
    #print a[row][col].get_name

    #pp $a.length
    if($a[row-1]!=$a[$maze_row-1])
        $a[row][col].update_door("north", $a[row-1][col].get_id)
    else
        $a[row][col].update_door("north", -1)
    end

    if($a[row+1]!=nil)
        $a[row][col].update_door("south", $a[row+1][col].get_id)
    else
        $a[row][col].update_door("south", -1)
    end
    if($a[row][col-1]!=$a[row][$maze_col-1])
        $a[row][col].update_door("west", $a[row][col-1].get_id)
    else
        $a[row][col].update_door("west", -1)
    end
    if($a[row][col+1]!=nil)
        $a[row][col].update_door("east", $a[row][col+1].get_id)
    else
        $a[row][col].update_door("east", -1)
    end
end


def lookaround()
    items =""
    list = $current_room.get_objects

    if(list.length>0)
        print("You see ")
        list.each do |item|
            pre_item = ""
            post_item = ""
            if(list.length>1)
                if(list.index(item)<list.length-1)
                    post_item = ", "
                else
                    pre_item = "and "
                end
            end
            print(pre_item + item.get_name.yellow + post_item)

        end
        puts(" nearby.")
    else
        puts("You see nothing special here.")
    end
    
end

def inspectitem(result)
  items =  Hash.new
  list = $current_room.get_objects

  list.each do |item|
    items.store(item.get_name, item)
  end

  if items.has_key?(result)
    desc = items[result].get_desc
    print "You are carefully examining #{result} which looks like a #{desc}."
    $player.set_stamina($player.get_stamina()-1)
  else
            #puts "There is no such thing nearby."
    return ""
  end
end

def dropitem(item)
  if ($player.get_objects.has_key?(item))
    $therooms[$player.get_room_id].add_object($player.get_object(item))
	$player.remove_object(item)
    puts "You dropped the #{item}."
  else
    puts "You haven't got a #{item}."
  end  
end

def pickitem(result)
    items =  Hash.new
    list = $current_room.get_objects

    list.each do |item|
        items.store(item.get_name, item)
    end
    if items.has_key?(result)
        if(items[result].get_removable)
            desc = items[result]
            print "You are carefully picking up the #{desc.get_name}.".green
            $player.add_object(items[result].get_name, desc)
            $current_room.remove_object(desc)
            $player.set_score($player.get_score()+50)
            #print "Score : #{$player.get_score()}"
            
        else
            print "Pfff... no matter how hard you try...".light_red
        end
        $player.set_stamina($player.get_stamina()-2)
    elsif result == ""
        print "Hmmm..."
    else
        print "Picking up empty air as if it was a #{result}"
    end
end


$stamina_flag = true
$steps = 0

def stamina(s, e)
    #puts ("from #{s} to #{e}" )
    0.step(s, 1) do |i|
      printf("\rStamina: [%-50s]#{i}", "=" * (i/2))
      print("%")
    end
    s.step(e+s, 1) do |i|
      printf("\rStamina: [%-50s]#{i}", "=" * (i/2))
      print("%")
      $stdout.flush
      sleep(0.1)
    end
    puts
end

def stamina2(s, stamina_increment)

  ending = stamina_increment * 10
  progress = 'Progress ['
  ending.times do |i|

# i is number from 0-999
  j = s + i

  # add 1 percent every 10 times
    if j % 10 == 0
      progress << "="
    # move the cursor to the beginning of the line with \r
      print "\r"
    # puts add \n to the end of string, use print instead
      print progress + "] #{j / 10} %"

    # force the output to appear immediately when using print
    # by default when \n is printed to the standard output, the buffer is flushed. 
      $stdout.flush
      sleep 0.05
    end
  end
  puts "\nDone!"
end

def go(dir)
    result = -1
    begin
      result = $current_room.get_doors[dir]
      if result == nil
        result = -3
      end        
    rescue
      result = -3
    end

    if result == -2
	    puts("There is no door from here. Try and get a round it".light_red)

    elsif result == -1 or $therooms[result].get_name=="void"
      $current_room =  $a[$player.get_row][$player.get_col]
      print("No, can't go #{dir} from this #{$current_room.get_name}.".light_red)
      $player.set_stamina($player.get_stamina()-3)
        #puts ("Stamina: #{$player.get_stamina()}%")
    elsif dir == "south" || dir == "north" || dir == "west" || dir == "east"
        #puts ("You are now in #{$current_room.get_desc}")
        #puts ("r #{$player.get_row} c#{$player.get_col}")
        #print "Loc", $player.get_loc
	    puts ("Going #{dir} into a #{$therooms[result].get_name}.".green)
      sleep(1)
    #  system("clear")

      if(dir =="south")
        if($player.get_row<$maze_row-1)
          $player.set_row($player.get_row+1) 
        end
      elsif(dir =="north")
        if($player.get_row>0)
          $player.set_row($player.get_row-1) 
        end
      elsif(dir =="west")
        if($player.get_col>0)
          $player.set_col($player.get_col-1)
        end
      elsif(dir =="east")
        if($player.get_col<$maze_col-1)
          $player.set_col($player.get_col+1)
        end    
      end
      $current_room = $a[$player.get_row][$player.get_col]
	    $player.set_room_id($current_room.get_id)
      topscreen(true)
      print ("You are now in #{$current_room.get_desc}.")
      $player.set_stamina($player.get_stamina()-3)
      lookaround()
        #puts ("Stamina: #{$player.get_stamina()}%")

      if($current_room.get_name!="bed room")
        $steps += 1
      end

      if($steps > 5)
        $stamina_flag = true
      end  
    else
      $current_room =  $a[$player.get_row][$player.get_col]
      puts ("We are going cocomo! But you are still in the same #{$current_room.get_name}! Idiot..".light_red)
      $player.set_stamina($player.get_stamina()-1)
        #puts ("Stamina: #{$player.get_stamina()}%")
    end
end

def inventory
    list = $player.get_objects

    if(list.length==0)
        puts "You got nothing in your pocket.".light_red
        return
    end

    puts "You are carrying:"
    list.each do |item , value|
        print "a #{item}".yellow
        print "\t #{value.get_desc}\n"
    end
    $player.set_stamina($player.get_stamina()-1)
end


def use(i)
    list = $player.get_objects
    if($player.get_object(i).class==Food)
    	puts "You eat #{$player.get_object(i).get_name} until there's no more..."
    	$player.set_stamina($player.get_stamina + $player.get_object(i).get_energy)
    	$player.remove_object($player.get_object(i).get_name)
      sleep 1
      topscreen(true)
      puts "and regained some energy."
    elsif(i == "motorcycle" and $player.got_object('key') and $current_room.got_object(i))
      puts "You hopped onto the motorcycle and inserted the key..."
      puts "VROOOM"
      sleep 1
      puts "In no time you escaped this town... into the NEXT ADVENTURE OF THE DULL"
      $victorious = true
    elsif (i == "bed" and $current_room.got_object(i) and $current_room.get_name=="bed room")
        if($stamina_flag)
            puts "Sleeping..."
            stamina_point = 25
            if(($player.get_stamina + stamina_point) >=100)    
                stamina_point  = 100 - $player.get_stamina
                stamina($player.get_stamina, stamina_point)
                $player.set_stamina(100)
                
            else 
                total_stamina = $player.get_stamina+stamina_point
                stamina($player.get_stamina, stamina_point)
                $player.set_stamina(total_stamina)
            end
            #puts "Stamina increases to #{$player.get_stamina}%"
            $stamina_flag = false
            $steps = 0 
            puts "Energised!".green
            sleep(1)
            topscreen(true)
            
        else
            puts "You are too busy for that!".light_red
            #puts "Stamina : #{$player.get_stamina}%"
        end
    elsif  list.has_key?(i)    
        puts "You pull out your #{i} and #{list[i].get_usage}".green
        if(i=="map")
#            print("\n======================================\n")
            print_map()
        end
        $player.set_stamina($player.get_stamina()-1)
    else
        puts "You haven't got that!".light_red
    end
end

def print_map()
  $maze_row.times do |row|
    puts
    $maze_col.times do |col|
      r = $a[row][col].get_name
		  a =""
		  if($a[row][col].get_doors()["west"] ==-2)
        print "|".ljust(5)
      else
        print "".ljust(5)
      end

	    if($a[row][col].get_doors()["north"] ==-1 or $a[row][col].get_doors()["north"] ==-2)
		    a += "-N-"
      end

      if($player.get_row() == row and $player.get_col == col)
		    a += "#{r}".on_green
      else
        a += r
      end
	    
      if($a[row][col].get_doors()["south"] ==-1 or $a[row][col].get_doors()["south"] ==-2)
		    a += "-S-"
      end

	    print a.center(10)
	    if($a[row][col].get_doors()["east"] ==-2)
        print "|".rjust(5)
      else
        print "".rjust(5)
      end
	  end
  end
  puts
end

def replace_void()
  $therooms.each do|a_room|
    void_number = 0
    doors = []
    #pp a_room
    if a_room.get_name!="void"
      a_room.get_doors.each do |key,void|
        if $therooms[void].get_name=="void"
          void_number+=1
     #     print ("PUSHING KEY #{key}")
          doors.push(void)
        end
      end
    end
   # pp a_room.get_doors
    if void_number>1
      r = doors.sample
      $therooms[r].set_name("new road")
      $therooms[r].set_desc("the long and winding road")
      pp "replacing void with a road"
    end
  end
end

def prepare_world()
    index = 0 
    $things = [$coin, $book, $hammer, $map].shuffle
    $valid_rooms = [$bedroom, $shop, $tunnel, $garden, $campus].shuffle

    $bedroom.add_object($bed)

    srng = Random.new
    $things.each do |thing|
        $valid_rooms[srng.rand($valid_rooms.length-1)].add_object(thing)
    end

    maze_random = Random.new

    $maze_row = maze_random.rand(3..$maze_max_row) 
    $maze_col = maze_random.rand(3..$maze_max_col)

    maze_size = $maze_row * $maze_col
    #puts " maze = #{$maze_size} rooms = #{$valid_rooms.length}"
    void_random = Random.new
    voids_number = 2
    if(maze_size>15)
        voids_number = void_random.rand(2..3)
    elsif(maze_size>9 and maze_size<=15)
        voids_number = void_random.rand(1..2)
    else
        voids_number = 1
    end 
    roads_number = maze_size - $valid_rooms.length - voids_number
    #puts " roads = #{$roads_number}"

    roads_number.times do 
        $therooms.push(Room.new("road", "the long and winding road"))
    end

    $valid_rooms.each do |room|
        $therooms.push(room) 
    end

    srng = Random.new
    $therooms[srng.rand($therooms.length-1)].add_object($food)

    voids_number.times do 
        $therooms.push(Room.new("void", "no go zone"))
    end

    $therooms = $therooms.shuffle
    $a = Array.new($maze_row) { Array.new($maze_col, 0) }

    $maze_row.times do |row|
        $maze_col.times do |column|
    	    $therooms[index].set_id(index)
          $a[row][column] = $therooms[index]
          index+=1
        end
    end

    $maze_row.times do |row|
 #       print("\n")
        $maze_col.times do |col|
            #print "\t" , $a[row][col].get_name
            #print row, col
            checksurrounding(row, col)
        end
#        print("\n======================================\n")
    end
    
    replace_void
    $therooms.each do |r|
    #  p r.get_id
	  #  p r.get_name
	  #  p r.get_doors

	    doors=[]
	    r.get_doors.each do | key, door |
		    if door!=-2 and door!=-1 and r.get_name !="void" and $therooms[door].get_name!="void"
			  #puts "#{key} => #{door}"
			    doors.push(key)
		    end
	    end

     # pp doors
	    if doors.length>3
        #doors.push("nothing") #force an opportunity not to add a blocked door
        #doors.push("nothing")
        s = doors.sample
	      door = r.get_doors()[s]
      #  print ("randomise door to update ")
        if s =="north"
          if($therooms[door].get_name!="void")
	          r.update_door(s,-2)
            $therooms[door].update_door("south",-2)
          end
        elsif s =="south"
          if($therooms[door].get_name!="void")
	          r.update_door(s,-2)
            $therooms[door].update_door("north",-2)
          end
        elsif s =="west"
          if($therooms[door].get_name!="void")
	          r.update_door(s,-2)
            $therooms[door].update_door("east", -2)
          end
        elsif s =="east"
          if($therooms[door].get_name!="void")
            $therooms[door].update_door("west", -2)
	          r.update_door(s,-2)
          end
        end

	     # pp(r.get_doors)
	    end
    end
end

def hit(actor)
  impact = 0
  if $player.get_room_id == $enemy.get_room_id and $enemy.get_name.downcase==actor.downcase
    if ($enemy.get_stamina>0)
      if ($player.get_objects.has_key?("hammer"))
        puts "You pull out that hammer of yours and swing it on #{$enemy.get_name}'s head!"
        limit = 2
        srng = Random.new
        impact = srng.rand(35..60)
        puts impact
      else
        puts "You got no weapon so you aim to hit #{$enemy.get_name} with your bare knuckles..."
        limit = 7  
        srng = Random.new
        impact = srng.rand(5..20)
        puts impact
 
      end
      srng = Random.new
      chance = srng.rand(1..10)
      puts chance
      if chance>=limit
        sleep 1
        if(impact >40)
          puts "You hit him hard, he gets dizzy..."
        else
          puts "You hit your target, but he barely feels any pain"
        end
      else
        sleep 1
        puts "And you miss miserably..."
      end
      sleep 1
      $enemy.set_stamina($enemy.get_stamina-impact)
      if($enemy.get_stamina<=0)
        puts "KNOCKED OUT and ambulance sirense could be heard from a distant, and you decided to flee the scene."
        obj = $enemy.get_object("key")
        $enemy.remove_object("key")
        $current_room.add_object(obj)
        lookaround()
        roads = []
        $therooms.each do |r|
          if(r.get_name=="road")
            roads.push(r.get_id)
          end
        end
    
        $therooms[roads.sample].add_object($motor)

        
      else
        puts "He goes back up! And attack you with his knife!"
        sleep 1
        srng = Random.new
        impact = srng.rand(10..50)
        puts impact
        srng = Random.new
        chance = srng.rand(1..10)
        puts chance
        if chance>4
          if(impact>1 and impact <20)
            puts "The knice slightly cuts your skin..."
          else
            puts "He cuts you deep, blood splattered everywhere"
          end
          $player.set_stamina($player.get_stamina-impact)
        else
          puts "You dodged away and avoided his knife"
        end

        sleep 2
        topscreen(true)
      end
    elsif $player.get_stamina <=0
      puts "You were fatally stabbed. GAME OVER"
    else
      puts "He is already down. You better run before police comes!"
    end

  else
    puts "You practice against your own shadow... sadly."
  end
end

class String
  def black; "\e[30m#{self}\e[0m" end
  def red; "\e[31m#{self}\e[0m" end
  def green; "\e[32m#{self}\e[0m" end
  def brown; "\e[33m#{self}\e[0m" end
  def blue; "\e[34m#{self}\e[0m" end
  def magenta; "\e[35m#{self}\e[0m" end
  def cyan; "\e[36m#{self}\e[0m" end
  def gray; "\e[37m#{self}\e[0m" end
 
  def bg_black; "\e[40m#{self}\e[0m" end
  def bg_red; "\e[41m#{self}\e[0m" end
  def bg_green; "\e[42m#{self}\e[0m" end
  def bg_brown; "\e[43m#{self}\e[0m" end
  def bg_blue; "\e[44m#{self}\e[0m" end
  def bg_magenta; "\e[45m#{self}\e[0m" end
  def bg_cyan; "\e[46m#{self}\e[0m" end
  def bg_gray; "\e[47m#{self}\e[0m" end
 
  def bold; "\e[1m#{self}\e[22m" end
  def italic; "\e[3m#{self}\e[23m" end
  def underline; "\e[4m#{self}\e[24m" end
  def blink; "\e[5m#{self}\e[25m" end
  def reverse_color; "\e[7m#{self}\e[27m" end
end

def topscreen(c)
    if(c==true)
      puts `clear`
    end
    print "#{$therooms[$player.get_room_id].get_name.upcase}"
    print "Stamina:#{$player.get_stamina()}%".rjust(90).light_blue
    puts " Score:#{$player.get_score()}".light_blue
    puts ""
end

def play()
    #system('cls')
  puts `clear`
  puts "THE DULL".center(100).white.on_blue.bold
  puts "A 2018 Ruby text-based adventure by Dipto Pratyaksa".center(100).white.on_blue
  puts ""
    #ColorizedString.color_samples
#pp a
  srng = Random.new
  n = c =  "void"
 
  while n=="void"
    pc = srng.rand(0..($maze_col-1))
    pr = srng.rand(0..($maze_row-1))
    $current_room = $a[pr][pc]   
    n = $current_room.get_name 
    $player = Player.new("Dipto", [pr, pc])
    $player.set_room_id($current_room.get_id)
  end

  #pp $player


  while c=="void"
    ec = srng.rand(0..($maze_col-1))
    er = srng.rand(0..($maze_row-1))
    $enemy_room = $a[er][ec]
    c = $enemy_room.get_name
    $enemy = Player.new("Bandito", [er, ec])
    $enemy.set_room_id($enemy_room.get_id)
  end

  $enemy.add_object("key", $key)


  #pp $enemy
  #puts $current_room.get_name.upcase
  topscreen(false)
  puts
  print "You are in #{$current_room.get_desc}. "
  lookaround()

  e = ""
  if($player.get_room_id == $enemy.get_room_id and $enemy.get_stamina>0)
    puts "#{$enemy.get_name} Your ARCH ENEMY is HERE! You will DIE!".red.blink
  end


  prompt = "\n> "
  print "What do you want to do?"
  print prompt

#pp $player
#pp $enemy
  $current_room = $a[$player.get_row][$player.get_col]

  while user_input = $stdin.gets.chomp # loop while getting user input
    topscreen(true)
    param = user_input.partition(" ")[2]
    case user_input.partition(" ")[0]
      when "where am I"
        puts("You are in #{$current_room.get_name}.")
      when "use"
        use(param)
        if($victorious)
          victory()
          break
        end
      when "inventory", "items", "objects" , "pocket"
        inventory()
      when "take", "get", "pick"
        pickitem(param)
      when "inspect" , "examine"
        inspectitem(param)
      when "view", "see" 
        lookaround()
      when "hit", "fight"
        hit(param)
        
        if($player.get_room_id == $enemy.get_room_id and $enemy.get_stamina>0)
          e=  "#{$enemy.get_name} Your ARCH ENEMY is HERE! You will DIE!".red.blink
        else
          e = ""
        end
         if($player.get_stamina<0)
          puts "Such is life..."
          break
        end
      when "look"
        system('cls')
        if param !=""
          if param == "north" || param == "west" ||param == "east" ||param == "south"
            result = $current_room.get_doors[param]
            if result == "" || $therooms[result].get_name == "void"
                result  = "blocking wall. You can't look through"
            end
            puts "Looking #{user_input.partition(" ")[2]} you see #{$therooms[result].get_name}.".green
          elsif param == "around"
            lookaround()
          elsif inspectitem(param)==""
            puts "There's not such thing nearby".light_red

          end
        else
          lookaround()
        #puts "The #{param} is looking back at you."
        end
#    break # make sure to break so you don't ask again
      when "go"

        go(param)
        print_map()
        if($player.get_room_id == $enemy.get_room_id and $enemy.get_stamina>0)
          e=  "#{$enemy.get_name} Your ARCH ENEMY is HERE! You will DIE!".red.blink
        else
          e = ""
        end
        if($player.get_stamina >25 && $player.get_stamina <50)
          puts "You feel a little exhausted...".light_red
        elsif($player.get_stamina >0 && $player.get_stamina <=25)
          puts "Get rest, eat or die. DO SOMETHING!".red.blink
        elsif ($player.get_stamina <=0)
          puts "You become so weak and exhausted, and DIE of thirst.".on_red
          puts "Total score : #{$player.get_score}"
          puts "Goodbye loser!"
          break
      end
#   
    #    break # make sure to break so you don't ask again
      when "drop"
        dropitem(param)
      when "exit"
        break
      else
        puts "Hmmm I don't quite understand that".light_red
      end
      print e + prompt
    end
end

prepare_world
welcome
play 

