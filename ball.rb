require 'yaml'

class Ball
  ANSWERS = YAML.load_file('answers.yml')

  def shake
    index = rand(ANSWERS.size)

    case index
    when 0..4
      color_string = 31
    when 5..9
      color_string = 32
    when 10..14
      color_string = 33
    when 15..19
      color_string = 34
    end

    puts "\e[#{color_string}m#{ANSWERS[index]}\e[0m"
    ANSWERS[index]

  end
end
