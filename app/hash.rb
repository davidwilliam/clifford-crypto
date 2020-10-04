module Clifford
  class Hash

    attr_accessor :l, :s, :b, :q, :v, :m, :r, :hash_value

    def initialize(l,s)
      @l = l
      @s = s
      @b = @l / 8
      @q = 2**(@b)
      @r = 20

      preprocessing
      message_schedule
      create_hash_value
    end

    def to_s
      hash_value
    end

    def inspect
      to_s
    end

    def create_v
      primes = Prime.first(8)
      values = primes.map{|p| Math.sqrt(p).to_s.split('.')[-1].to_i.to_s(2)[0..(l/8)-1].to_i(2) }
      Multivector3DMod.new values, q
    end

    def create_m
      n = Tools.s_to_n(s)
      Tools.number_to_multivector_mod(n,b,q)
    end

    def preprocessing
      @v = create_v
      @m = create_m
    end

    def message_schedule
      r.times do
        @v = @v.reverse.plus(@v.gp(@v.cc).gp(@v)).plus(@v.reverse)
        @m = @v.reverse.minus(@m.gp(@m.cc).gp(@m)).minus(@m)
      end
    end

    def create_hash_value
      @hash_value = @m.data.map{|d| d.to_s(16)}.join
    end

    def binary
      hash_value.to_i(16).to_s(2)
    end

  end
end
