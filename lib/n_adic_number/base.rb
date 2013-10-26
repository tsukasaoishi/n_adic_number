module NAdicNumber
  class Base
    class << self
      attr_reader :config

      def map_table(ary)
        raise ArgumentError, "map_table is not Array" unless ary.is_a?(Array)
        raise ArgumentError, "map_table is empty" if ary.empty?
        raise ArgementError, "map_table is not unique" if ary.uniq!

        base_num = ary.size
        reverse_map = {}
        ary.each_with_index{|ch,i| reverse_map[ch] = i}

        @config = {
          :map_table => ary,
          :base_num => base_num,
          :keta => (0..9).map{|i| base_num ** i},
          :reverse_map => reverse_map
        }
      end
    end

    attr_reader :map_table, :base_num, :keta, :reverse_map

    def initialize(seed)
      raise "Not define map_table" unless self.class.config

      %w|map_table base_num keta reverse_map|.each do |variable_name|
        instance_variable_set("@#{variable_name}", self.class.config[variable_name.to_sym])
      end

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
      @raw_data.reverse
    end

    def to_i
      ret = 0
      @raw_data.chars.each_with_index do |ch, index|
        ret += reverse_map[ch] * (keta[index] || (base_num ** i))
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
        @raw_data = map_table.first
      else
        @raw_data = ""
        work = int
        while work != 0
          work, num = work.divmod(base_num)
          @raw_data << map_table[num]
        end
      end
    end

    def initialize_by_string(str)
      raise ArgumentError unless str.split(//).all?{|s| map_table.include?(s)}
      @raw_data = str.reverse
    end
  end
end
