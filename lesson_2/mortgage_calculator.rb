def valid_number?(num)
  num.to_f.nonzero? || num == '0'
end

def yes_response?(response)
  response == 'y' || response == 'yes'
end

puts 'We are pleased to provide you with this mortgage calculator!'
puts
puts 'We will first gather some information to determine your monthly payment.'
puts 'Please readand answer the following questions carefully.'
puts

loop do
  loan = ''
  apr = ''
  loan_dur_y = ''

  loop do
    puts 'What is the full amount of your mortgage?'
    loan = gets.chomp
    if loan.include? ","
      puts 'Please do not include any punctuation'
    elsif valid_number?(loan)
      puts "You entered $#{loan}. Is this correct ('y' or 'n')?"
      reply = gets.chomp
      break if yes_response?(reply)
    elsif loan.start_with?("$")
      puts 'Please do not include a $'
    else
      puts 'Please enter a valid number'
    end
  end

  loop do
    puts 'What is the annual percentage rate (APR) for your mortgage?'
    puts 'Please enter as a percentage.'
    apr = gets.chomp
    if valid_number?(apr)
      if apr.include?("%")
        puts "You entered #{apr}. Is this correct ('y' or 'n')?"
      else
        puts "You entered #{apr}%. Is this correct ('y' or 'n')?"
      end
      reply = gets.chomp
      break if yes_response?(reply)
    else
      puts 'Please enter a valid number'
    end
  end

  apr = apr.to_f / 100

  loop do
    puts 'What is the duration of your mortgage in years?'
    loan_dur_y = gets.chomp
    if valid_number?(loan_dur_y)
      puts "You entered #{loan_dur_y} years. Is this correct ('y' or 'n')?"
      reply = gets.chomp
      break if yes_response?(reply)
    else
      puts 'Please enter a valid number'
    end
  end

  # Calculate monthly interest rate
  int_m = apr / 12

  # Calculate loan duration in months
  loan_dur_m = loan_dur_y.to_i * 12

  # Calculate monthly payment
  payment = loan.to_i * (int_m / (1 - (1 + int_m)**-loan_dur_m))

  puts "For a #{loan_dur_y} year mortgage of $#{loan} at #{apr * 100}%,"
  puts "your monthly payment is $#{payment.round(2)}."

  puts 'Would you care to recalculate with different values?'
  reply = gets.chomp
  break unless yes_response?(reply)
end
