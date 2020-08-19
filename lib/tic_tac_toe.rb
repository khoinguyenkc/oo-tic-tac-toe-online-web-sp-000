require 'pry'
class TicTacToe
 WIN_COMBINATIONS = [
   [0,1,2],
   [3,4,5],
   [6,7,8],
   [0,3,6],
   [1,4,7],
   [2,5,8],
   [0,4,8],
   [6,4,2]
 ]

  def initialize
    @board = [" "] * 9
  end

  def display_board
    #i guess we make this an instance method cuz there has been no obvious need to do class method
    #if we make it class method, we'll have to specify to go to the instance and grab its board variable
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
  user_input.to_i - 1
end

def move( index, current_player = "X")
  @board[index] = current_player
end

def position_taken?(location)
  @board[location] != " " && @board[location] != ""
end

def valid_move?(index)
  index.between?(0,8) && !position_taken?(index)
end


def turn
  the_current_player = current_player()
  binding.pry
  #careful. we do not have currentplayer yet, and we want it to reference the method, not itself. no board ...
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  if valid_move?(index)
    move(index, the_current_player)
    display_board()


  else
    #put it in a loop
    inputnowvalid = false

    until inputnowvalid == true
      puts "Please enter 1-9:"
      input = gets.strip
      getthenewmove = input_to_index(input)

      inputnowvalid = valid_move?(getthenewmove)
      #if vaid, input nowvalid becomes true. that will stop the loop.
      #othrewise, this keeps going forever
    end #end of loop

    #if loop is finished, take new move and send it in
    move( getthenewmove, the_current_player)
    display_board()
  end #end of if & else

end

  def current_player
    turns = turn_count()

    if (turns % 2 == 0)
      return "X"
    else
      return "O"
    end
  end


  def turn_count
    turns = 0

    @board.each do | item |
      if item == "X" || item == "O"
        turns +=1
      end
    end

    return turns
  end



end
