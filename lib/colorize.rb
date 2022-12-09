class String
  def black   = "\e[30m#{self}\e[0m"
  def red     = "\e[31m#{self}\e[0m"
  def green   = "\e[32m#{self}\e[0m"
  def yellow  = "\e[33m#{self}\e[0m"
  def blue    = "\e[34m#{self}\e[0m"
  def magenta = "\e[35m#{self}\e[0m"
  def cyan    = "\e[36m#{self}\e[0m"
  def white   = "\e[37m#{self}\e[0m"
  def bright_black   = "\e[90m#{self}\e[0m"
  def bright_red     = "\e[91m#{self}\e[0m"
  def bright_green   = "\e[92m#{self}\e[0m"
  def bright_yellow  = "\e[93m#{self}\e[0m"
  def bright_blue    = "\e[94m#{self}\e[0m"
  def bright_magenta = "\e[95m#{self}\e[0m"
  def bright_cyan    = "\e[96m#{self}\e[0m"
  def bright_white   = "\e[97m#{self}\e[0m"

  def rgb(*args)
    if args.length == 1
      num = args[0].to_i
      r = num >> 16 & 0xFF
      g = num >> 8  & 0xFF
      b = num >> 0  & 0xFF
    elsif args.length == 3
      r, g, b = args.map{_1.to_i.clamp(0..255)}
    else
      raise ArgumentError.new("wrong number of arguments (given #{args.size}, expected 1 or 3)")
    end
    "\e[38;2;#{r};#{g};#{b}m#{self}\e[0m"
  end
  def rgb_bg(*args)
    if args.length == 1
      num = args[0].to_i
      r = num >> 16 & 0xFF
      g = num >> 8  & 0xFF
      b = num >> 0  & 0xFF
    elsif args.length == 3
      r, g, b = args.map{_1.to_i.clamp(0..255)}
    else
      raise ArgumentError.new("wrong number of arguments (given #{args.size}, expected 1 or 3)")
    end
    "\e[48;2;#{r};#{g};#{b}m#{self}\e[0m"
  end
end
