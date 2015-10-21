class Pet
  attr_reader :name, :cause_of_death

  def initialize(n)
    @name = n.chomp
    @kind = 'Краб'.chomp
    @health = rand(70..100)
    @mood = rand(70..100)
    @fullnes = rand(70..100)
    @cheerfulness = rand(70..100)
    @agressiveness = rand(0..20)
    @cause_of_death = ''

  end

  def help
    puts "  Возможные действия:
    Узнать дату рождения
    Кормить
    Выгулять
    Ударить
    Накричать
    Ждать
    Уложить спать
    Гладить "
  end

  def stroke
    @mood += rand(7..14)
    @agressiveness -= rand(3..5)
    pass_time
    puts "Ты погладил(а) #{@name}, твой #{@kind.downcase} любит это =)"
  end

  def sleep(n)
    @sleep_phrases = ["#{@name} во время сна перекрутился вокруг своей оси...", "#{@name} увидел во сне Патрика-звезду..", "#{@name} перевернулся на панцерь..", "#{@name} во сне разговаривал со свои пра-пра-дедом...","#{@name} сопел во сне..."]
    n.times do
      puts @sleep_phrases[rand(5)]
      @cheerfulness += 5 + rand(5)
      #pass_time
      next unless bad_state?
      puts "Cледи за показателями, чтобы твой #{@kind.downcase} не обиделся а тебя и не умер.."
      break
    end
  end

  def cry_out
    if @agressiveness > 25
      puts "#{@name} испугался ваших криков.."
      @agressiveness += rand(3..10)
      @mood -= rand(5..15)
    else
      puts "#{@name} притих и очень напуган.."
      @agressiveness -= rand(6..10)
      @mood -= rand(3..5)
    end
    pass_time
  end

  def kick
    @health -= rand(5)
    @mood -= rand(10..25)
    @cheerfulness -= rand(5)
    @agressiveness += rand(6..15)
    pass_time
    puts "Ты ударл(а) #{@name}а, он обиделся.."
  end

  def play
    @health += rand(5..10)
    @mood += rand(5..10)
    @fullnes -= rand(15..30)
    @cheerfulness -= rand(5..10)
    @agressiveness -= rand(3..5)
    pass_time
    puts "#{@name} хорошо выгулян, но #{@name} устал и проголодался немного..."
  end

  def eat
    @fullnes += 15
    @cheerfulness += rand(5..10)
    @health += rand(4)
    pass_time
    puts "#{@name} поел..."
  end

  def wait(n)
    phrases = ["#{@name} плавает по аквариуму",
               "#{@name} испугался твоего кота...",
               "#{@name} залип в одну точку",
               "#{@name} вещает мудрые мысли",
               "#{@name} задумался",
               "#{@name} заснул..."]
     n.times do
      r = rand(100)
      puts phrases[rand(6)]
      if r > 80
        puts "#{@name} плавая по аквариуму, натер себе лапку =("
        @health -= 10
        @mood -= rand(10)
      elsif r < 15
        puts "#{@name} подружился с рыбкой Немо =)"
        @mood += 15
        @health += rand(5)
      end
      pass_time
      if bad_state?
        puts "Следи за показателями, чтобы твоя #{@kind.downcase} не был в очень лохом состоянии..."
        break
      end
    end
  end

  def view_state
    puts"
    Здоровье       : #{@health} %
    Голод          : #{@fullnes} %
    Настроение     : #{@mood} %
    Бодрость       : #{@cheerfulness} %
    Агрессивность  : #{@agressiveness} %
    "
  end

private

  def bad_state?
    @health < 15 || @mood < 15 || @fullnes > 15 || @cheerfulness < 15
  end

  def pass_time
    @health -= rand(15)
    @mood -= rand(15)
    @fullnes += rand(15)
    @cheerfulness -= rand(15)
    @agressiveness += rand(5)
    r = rand(100)
    if r < @agressiveness / 2
      puts "#{@kind} слишком агресивный!".chomp
      @agressiveness -= 10
      @cheerfulness -= 10
      @mood -= 10
      @fullnes += 10
    end
    @health = 100 if @health > 100
    @mood = 100 if @mood > 100
    @fullnes = 100 if @fullnes > 100
    @cheerfulness = 100 if @cheerfulness > 100
    @agressiveness = 0 if @agressiveness < 0
    @agressiveness = 100 if @agressiveness > 100
    @cause_of_death = "#{@name} очень сильо заболел.." if @health <= 0
    @cause_of_death = "#{@name} депрессия у твоего #{@kind}а о_О" if @mood <= 0
    @cause_of_death = "#{@name} очень сильно хочет есть! Немедленно покорми его" if @fullnes <= 3
    @cause_of_death = "#{@name} умер от скуки.." if @cheerfulness <= 0
  end
end


puts "Как назовешь своего вредного краба?"
crab = Pet.new(gets)
@date_born = (Time.new)
puts "Твой #{@kind} #{crab.name} вылупился на свет #{@date_born} "

command = ''
until command == 'exit' || crab.cause_of_death != ''
  crab.view_state if crab.cause_of_death == ''
  puts 'Что бы ты хотел(а) сделать? (Если не знаешь, что можно делать, воспользуйся помощью "help")'
  command = gets.chomp

  case command
  when 'exit'
    break
  when 'help'
    crab.help
  when 'Узнать дату рождения'
    puts "Твой краб #{crab.name} родился #{@date_born}"
  when 'Кормить'
    crab.eat
  when 'Выгулять'
    crab.play
  when 'Ударить'
    crab.kick
  when 'Накричать'
    crab.cry_out
  when 'Ждать'
    puts 'Сколько часиков подождать?'
    crab.wait(gets)
  when 'Уложить спать'
    puts 'Скільки годин спати?'
    crab.sleep(gets.to_i)
  when 'Гладить'
    crab.stroke
  else
    puts 'Не известное действие'
  end


  puts crab.cause_of_death if crab.cause_of_death != ''

end
