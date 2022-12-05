class Pie
  attr_reader :area, :izum, :height, :width

  def initialize(pie)
    @pie = pie
    @izum = pie.count('o')

    pie = pie.split("\n")

    @width = pie.first ? pie.first.length : 0
    @height = pie.length

    @area = @width * @height
  end

  def possible_widths
    if self.area % self.izum != 0
      return []
    end

    widths = ((self.area / self.izum) / (self.height + 1) + 1..self.width).to_a.select { |i| (self.area / self.izum) % i == 0 }
    widths.reverse
  end

  def to_s
    @pie
  end
end

class Slice
  attr_reader :pie, :x, :y, :area, :izum, :width, :height

  def initialize(pie, x, y, width)
    @pie = pie
    @x = nil
    @y = nil
    @area = nil
    @izum = nil
    @width = nil
    @height = nil

    if x < 0 || x >= pie.width || y < 0 || y >= pie.height
      return
    end
    @x = x
    @y = y

    @area = pie.area % pie.izum == 0 ?
              pie.area / pie.izum : nil
    if @area == nil || width <= 0
      return
    end

    @height = @area % width == 0 ? @area / width : nil
    if @height == nil
      return
    end
    @width = width

    if x + width > pie.width || y + self.height > pie.height
      return
    end

    @pie = (self.y...(self.y + @height)).to_a.map do |i|
      self.pie.to_s.split("\n")[i][self.x...(self.x + self.width)]
    end.join("\n")
    @izum = @pie.count "o"
  end

  def to_s
    @pie
  end

  def contains_point?(x, y)
    self.x <= x && self.x + self.width > x &&
      self.y <= y && self.y + self.height > y ?
             true : false
  end

  def valid?
    @izum != nil
  end
end

class Slices
  attr_reader :pie, :slices, :length

  def initialize(pie, *slices)
    @pie = pie
    @slices = slices
    @length = slices.length
  end

  def free_dotes
    self.pie.height.times do |row|
      self.pie.width.times do |col|
        if self.slices.all? { |p| !p.contains_point?(col, row) }
          return [col, row]
        end
      end
    end
    nil
  end

  def valid?()
    self.slices.last.valid?
  end

  def overlap?()
    self.slices.any? do |dot|
      self.slices.any? do |d|
        d != dot && (
          d.contains_point?(dot.x, dot.y) ||
            d.contains_point?(dot.x + dot.width - 1, dot.y) ||
            d.contains_point?(dot.x, dot.y + dot.height - 1) ||
            d.contains_point?(dot.x + dot.width - 1, dot.y + dot.height - 1))
      end
    end
  end

  def only_one_izum?()
    self.slices.all? do |d|
      d.izum == 1
    end
  end

  def next_slices()
    if self.slices.empty?
      return self
    end
    earlier = self.slices.first(self.length - 1)
    forget = self.slices.last
    widths = self.pie.possible_widths
    i = widths.find_index(forget.width)
    if i + 1 == widths.length
      return Slices.new(self.pie, *earlier).next_slices
    end
    np = Slice.new(self.pie, forget.x, forget.y, widths[i + 1])
    na = [*earlier, np]
    Slices.new(self.pie, *na)
  end

  def new_slices()
    if self.free_dotes.nil?
      return self
    end
    x, y = self.free_dotes
    np = Slice.new(self.pie, x, y, self.pie.possible_widths.first)
    na = [*self.slices, np]
    Slices.new(self.pie, *na)
  end
end

def cut pie

  pie = Pie.new(pie)
  sl = Slice.new(pie, 0, 0, pie.possible_widths.first)
  done = Slices.new(pie, sl)

  while done.length > 0 && done.length <= pie.izum
    if done.length == pie.izum
      if done.valid? && done.only_one_izum? && !done.overlap? && done.free_dotes.nil?
        return done.slices.map { |p| p.to_s }
      else
        done = done.next_slices
        next
      end
    else
      if done.valid? && done.only_one_izum? && !done.overlap?
        done = done.new_slices
        next
      else
        done = done.next_slices
        next
      end
    end
  end
  []
end

pie = "
.o.o....
........
....o...
........
.....o..
........
".strip

res = cut(pie)
res = res.join(", \n\n")

puts res

