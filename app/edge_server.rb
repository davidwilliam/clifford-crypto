module Clifford
  class EdgeServer

    attr_accessor :l, :adb, :data, :party

    def initialize(l)
      @l = l
      b = @l/8
      q = Tools.next_prime(2**b)
      @adb = []
      @data = Array.new(8){ Tools.generate_random_multivector_mod(b,q)}
    end

    def initiate_request(pu_)
      @party = Party.new @l, 1
      @party.set_public_communication_identifier(pu_)
      @party.generate_sub_key
      [@party.pu,@party.s]
    end

    def register(pu_,s_)
      party.exchange(s_)
      @adb << [pu_.data,party.k,false]
      pu = party.pu
      s = party.s
      @party = nil
    end

    def request_data(pu_,j)
      selection = @adb.select{|s| s[0] == pu_.data && s[2] == false}
      if selection.empty?
        raise EdgeServerAccessError, "Invalid request access."
      else
        d = @data[j]
        k = selection[0][1]
        c = k.gp(d).gp(k.reverse)
        @adb.select{|s| s[0] == pu_.data}[0][2] = true
        return c
      end
    end

  end
end
