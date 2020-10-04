module Clifford
  class Crypto

    attr_accessor :l, :b, :q, :k, :r

    def initialize(l)
      @l = l
      @b = l/8
      @q = Tools.next_prime(2**@b)
      @k = Tools.generate_random_multivector_mod(@b,@q)
      @r = 20
    end

    def encrypt(m_10)
      c = Tools.number_to_random_multivector_mod(m_10,b,q)
      k_ = k.clone
      r.times do
        k_ = k_.reverse.plus(k_.gp(k_.cc).gp(k_)).plus(k_.reverse)
        c = k_.reverse.gp(k_).gp(c).gp(k_).gp(k_.reverse)
      end

      c
    end

    def decrypt(c)
      ks = []
      k_ = k.clone

      r.times do
        k_ = k_.reverse.plus(k_.gp(k_.cc).gp(k_)).plus(k_.reverse)
        ks << k_
      end

      (0..r-1).to_a.reverse.each do |i|
        c = ks[i].inverse.gp(ks[i].reverse.inverse.gp(c).gp(ks[i].reverse.inverse)).gp(ks[i].inverse)
      end

      c.e3
    end

  end
end
