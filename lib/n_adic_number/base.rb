module NAdicNumber
  class Base
    class << self
      attr_reader :base_num, :map_list, :reverse_map

      def map_table(ary)
        raise ArgumentError, "map_table is not Array" unless ary.is_a?(Array)
        raise ArgumentError, "map_table is empty" if ary.empty?
        raise ArgementError, "map_table is not unique" if ary.uniq!

        @map_list = ary
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
        initialize_by_fixnum(seed)
      when String
        initialize_by_string(seed)
      else
        raise ArgumentError
      end
    end

    def to_s
      @raw_data.reverse.join
    end

    def to_i
      ret = 0
      @raw_data.each_with_index do |ch, index|
        ret += reverse_map[ch] * keta(index)
      end
      ret
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

    def initialize_by_fixnum(int)
      raise ArgumentError if int < 0

      if int == 0
        @raw_data = [map_table.first]
      else
        @raw_data = []
        work = int
        while work != 0
          work, num = work.divmod(base_num)
          @raw_data << map_table[num]
        end
      end
    end

    def initialize_by_string(str)
      raise ArgumentError unless str.chars.all?{|s| map_table.include?(s)}
      @raw_data = str.reverse.chars
    end

    def base_num
      self.class.base_num
    end

    def keta(pos)
      self.class.keta(pos)
    end

    def map_table
      self.class.map_list
    end

    def reverse_map
      self.class.reverse_map
    end
  end
end
