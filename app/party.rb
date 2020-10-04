module Clifford
  class Party

    attr_accessor :l, :i, :b, :q, :pr, :pu, :g, :s, :k

    def initialize(l,i)
      @l = l
      @i = i
      @b = @l/8
      @q = Tools.next_prime(2**b)
      @pr = Clifford::Tools.generate_random_multivector_mod(@b,@q)
      @pu = Clifford::Tools.generate_random_multivector_mod(@b,@q)
    end

    def set_public_communication_identifier(pu_)
      if i == 1
        @g = pu.gp(pu_)
      elsif i == 2
        @g = pu_.gp(pu)
      end
    end

    def generate_sub_key
      if i == 1
        @s = pr.gp(g)
      elsif i == 2
        @s = g.gp(pr)
      end
    end

    def exchange(s_)
      one = Multivector3DMod.new [1,0,0,0,0,0,0,0], q
      if i == 1
        @k = pr.gp(s_).gp(g).plus(g).plus(one)
      elsif i == 2
        @k = s_.gp(pr).gp(g).plus(g).plus(one)
      end
    end

  end
end
