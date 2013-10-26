module NAdicNumber
  class Base
    class << self
      attr_reader :base_num, :map_table, :reverse_map

      def mapping(ary)
        raise ArgumentError, "map_table is not Array" unless ary.is_a?(Array)
        raise ArgumentError, "map_table is empty" if ary.empty?
        raise ArgementError, "map_table is not unique" if ary.uniq!

        @map_table = ary
        @base_num = ary.size
        @reverse_map = {}
        ary.each_with_index{|ch,i| @reverse_map[ch] = i}
        @keta = (0..9).map{|i| @base_num ** i}
      end

      def keta(pos)
        @keta[pos] ||= @base_num ** pos
      end
    end

    def initialize(seed)
      raise "Not define map_table" unless base_num

      case seed
      when Fixnum
        raise ArgumentError if seed < 0
        @integer = seed
      when String
        @str_chars = seed.reverse.chars
        raise ArgumentError if @str_chars.one?{|ch| !reverse_map.has_key?(ch)}
        @string = seed
      else
        raise ArgumentError
      end
    end

    def to_s
      @string ||= make_string
    end

    def to_i
      @integer ||= make_integer
    end

    %w|+ - * /|.each do |op|
      define_method(op) do |something|
        new_val = self.to_i.__send__(op, something.to_i)
        self.class.new(new_val)
      end
    end

    def inspect
      %Q|#<#{self.class.name}:0x#{"%014x" % (self.object_id << 1)} base:#{base_num} num:#{to_s} integer:#{to_i}>|
    end

    private

    def make_string
      if @integer == 0
        map_table.first.dup
      else
        string = ""
        work = @integer
        while work != 0
          work, num = work.divmod(base_num)
          string << map_table[num]
        end
        string.reverse
      end
    end

    def make_integer
      integer = 0
      @str_chars.each_with_index do |ch, index|
        integer += reverse_map[ch] * keta(index)
      end
      integer
    end

    def base_num
      self.class.base_num
    end

    def keta(pos)
      self.class.keta(pos)
    end

    def map_table
      self.class.map_table
    end

    def reverse_map
      self.class.reverse_map
    end
  end
end
