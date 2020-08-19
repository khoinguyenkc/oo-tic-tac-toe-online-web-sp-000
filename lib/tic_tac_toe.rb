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
  #is changing thecurrentplayer what makes the diff.. i guess
  the_current_player = current_player()
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


  def won?
  WIN_COMBINATIONS.each do |combo|
    # if same value in this row/column/diag and not empty empty empty
    if ( (@board[combo[0]] == @board[combo[1]]) &&  (@board[combo[1]] == @board[combo[2]] ) && position_taken?(combo[0]) )
      return combo
    #critical:
    #do not put an else return nil here. or it will end the entire operation. only return nill if it's looped through EVERYTHING and still found nothing
    end
  end

  return nil
end

def full?
  @board.none? do |item|
    item == " " || item   == ""
  end
end

def draw?
  if full? && won? == nil
    return true
  else
    return false
  end
end


def over?
if draw? || won?
  return true
else
  return false
end
end

def winner
#ex: if winningcombo is [2,4,6], board[winningcombo[0]] = board[2] = either X or O
winningcombo = won?
if winningcombo == nil
  return nil
else
  return @board[winningcombo[0]]
end
end


def play
  #A tic tac toe game must allow players to take turns, checking if the game is over after every turn, and at the conclusion of the game, whether because it was won or because it was a draw, reporting to the user the outcome of the game
  until over? do
    turn

  end

  if over?
    if won?

      puts "Congratulations #{winner(board)}!"
    else #aka a draw
      puts "Cat's Game!"
    end
  end
  #boardnotfull = (board.include?(" ") || board.include?(""))
  #variable must be inside so that e4very loop re calculate the value of boardisfull
  # otherwie it's static
  #crucial
  #if !boardnotfull
  #  break
  #end

end







end
