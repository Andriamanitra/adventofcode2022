require_relative '../lib/colorize.rb'

MOVES = {
  2i => 1i,
  -2i => -1i,
  2+0i => 1,
  -2+0i => -1,
  1+2i => 1+1i,
  2+1i => 1+1i,
  2+2i => 1+1i,
  1-2i => 1-1i,
  2-1i => 1-1i,
  2-2i => 1-1i,
  -1+2i => -1+1i,
  -2+1i => -1+1i,
  -2+2i => -1+1i,
  -1-2i => -1-1i,
  -2-1i => -1-1i,
  -2-2i => -1-1i,
}
MOVES.default = 0

DIRECTIONS = { 'D' => -1i, 'U' => 1i, 'L' => -1, 'R' => 1 }

$origin = 0 + 0i
$VBOUNDS = (0..35)
$HBOUNDS = (0..80)
$FRAME_DELAY = 0.05

def draw(ch, pos)
  r = (pos - $origin).imag.to_i
  c = (pos - $origin).real.to_i
  return unless $VBOUNDS === r && $HBOUNDS === c
  STDOUT.write("\x1b7\x1b[#{r};#{c}f#{ch}\x1b8")
end

def clear()
  STDOUT.write("\x1b[2J")
end

def main()
  STDOUT.write("\x1b[?25l") # hide cursor

  instructions = File.readlines("input.txt")
                     .map{|line| a, b = line.split; [a, b.to_i]}

  head = 10 + 10i
  tails = Array.new(9){head}

  draw('H', head)
  
  visited = []
  instructions.each do |dir, steps|
    head_char = dir.tr('DULR','▄▀▐▌')
    steps.times do
      head += DIRECTIONS[dir]
      prev = head
      tails.each_index do |i|
        movement = MOVES[prev - tails[i]]
        break if movement == 0
        tails[i] += movement
        prev = tails[i]
      end

      if (head - $origin).imag > $VBOUNDS.end - 7
        $origin += 1i
      elsif (head - $origin).imag < $VBOUNDS.begin + 7
        $origin -= 1i
      end
      if (head - $origin).real > $HBOUNDS.end - 7
        $origin += 1
      elsif (head - $origin).real < $HBOUNDS.begin + 7
        $origin -= 1
      end
      clear
      visited.each do |v|
        draw('▒'.bright_black, v)
      end
      tails.each do |t, i|
        draw('█'.rgb(55,155,55), t)
      end
      draw('█'.rgb(0,100,0), tails.last)
      draw(head_char.rgb(55,155,55).rgb_bg(55,255,55), head)
      sleep $FRAME_DELAY

      visited.push(tails.last) if tails.last != visited.last
    end
  end
ensure
  clear
  puts "Tail visited #{visited.uniq.size} squares"
  STDOUT.write("\x1b[?25h") # show cursor
  exit
end

main
