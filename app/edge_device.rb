module Clifford
  class EdgeDevice

    attr_accessor :l, :party

    def initialize(l)
      @l = l
      b = @l/8
      q = Tools.next_prime(2**b)
      @party = Party.new @l, 2
    end

    def exchange(pu_,s_)
      party.set_public_communication_identifier(pu_)
      party.generate_sub_key
      party.exchange(s_)
      [party.pu,party.s]
    end

    def receive_data(c)
      d = party.k.inverse.gp(c).gp(party.k.reverse.inverse)
    end

  end
end
