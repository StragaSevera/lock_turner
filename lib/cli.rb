# frozen_string_literal: true

require_relative 'lock_turner'

module CLI
  module_function

  def start!
    puts 'Enter starting combination:'
    start = loop do
      input = input_code
      if (1..6).include?(input.size)
        break input
      else
        warn 'The code size should be in the range of 1..6'
      end
    end

    code_length = start.length
    puts 'Enter final combination:'
    stop = loop do
      input = input_code
      if input.size == code_length
        break input
      else
        warn 'The code size should be equal to the size of starting code'
      end
    end

    puts 'Enter forbidden combinations (or empty string to stop):'
    forbidden = []
    loop do
      input = input_code
      if input.size == code_length
        forbidden << input
      elsif input.empty?
        break
      else
        puts 'warn'
        warn 'The code size should be equal to the size of starting code'
      end
    end

    path = LockTurner.new(start, stop, forbidden).solve
    if path.empty?
      puts 'There is no path!'
    else
      puts 'The path is:'
      path.each do |node|
        puts node.join(' ')
      end
    end
  end

  def input_code
    loop do
      input = gets.split.map { |s| Integer(s) }
      break input
    rescue ArgumentError
      warn 'The code should contain only integer numbers split by whitespace!'
    end
  end
end
