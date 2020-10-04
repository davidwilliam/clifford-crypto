module Clifford
  class Tools

    def self.random_number(bits)
      OpenSSL::BN::rand(bits).to_i
    end

    def self.random_prime(bits)
      # recall that OpenSLL library does not generate primes with less than
      # 16 bits
      if bits < 16
        Prime.first(100).select{|prime| prime.bit_length == bits}.sample
      else
        OpenSSL::BN::generate_prime(bits).to_i
      end
    end

    def self.next_prime(n)
      while true
        break if OpenSSL::BN.new(n).prime?
        n += 1
      end
       n
    end

    def self.number_to_multivector_input(n,b)
      data = [
                                n % 2**b,
                                (n / 2**b) % 2**b,
                                (n / 2**(2*b)) % 2**b,
                                (n / 2**(3*b)) % 2**b,
                                (n / 2**(4*b)) % 2**b,
                                (n / 2**(5*b)) % 2**b,
                                (n / 2**(6*b)) % 2**b,
                                (n / 2**(7*b)) % 2**b,
                              ]
    end

    def self.number_to_multivector(n,b)
      data = number_to_multivector_input(n,b)
      Multivector3D.new data
    end

    def self.number_to_multivector_mod(n,b,q)
      data = number_to_multivector_input(n,b)
      m_mod = Multivector3DMod.new data, q
    end

    def self.string_to_multivector(s,b)
      n = s_to_n(s)
      m = number_to_multivector(n,b)
    end

    def self.s_to_n(s)
      n = 0
      s.each_byte do |b|
        n = n * 256 + b
      end
      n
    end

    def self.string_to_multivector_mod(s,b,q)
      n = s_to_n(s)
      m = number_to_multivector_mod(n,b,q)
    end

    def self.generate_random_input(b)
      Array.new(8){ random_number(b) }
    end

    def self.generate_random_multivector(b)
      data = generate_random_input(b)
      Clifford::Multivector3D.new data
    end

    def self.generate_random_multivector_mod(b,q)
      data = generate_random_input(b)
      Clifford::Multivector3DMod.new data, q
    end

    def self.generate_random_multivector_mod_ni(b,q)
      data = generate_random_input(b)
      r1 = Clifford::Multivector3DMod.new data, q
      r_10 = random_number(b)
      r2 = Multivector3DMod.new [r_10] * 8, q
      r = r1.gp(r2)
    end

    def self.number_to_random_multivector_mod(n,b,q)
      m = generate_random_multivector_mod(b,q)
      m.e3 = n
      m
    end

    def self.multivector_to_number(m,b)
      n = 0
      m.data.reverse.each do |d|
        n = n * 2**b + d
      end
      n
    end

    def self.mod_inverse(num, mod)
      g, a, b = extended_gcd(num, mod)
      unless g == 1
        raise ZeroDivisionError.new("#{num} has no inverse modulo #{mod}")
      end
      a % mod
    end

    def self.extended_gcd(x, y)
      if x < 0
        g, a, b = extended_gcd(-x, y)
        return [g, -a, b]
      end
      if y < 0
        g, a, b = extended_gcd(x, -y)
        return [g, a, -b]
      end
      r0, r1 = x, y
      a0 = b1 = 1
      a1 = b0 = 0
      until r1.zero?
        q = r0 / r1
        r0, r1 = r1, r0 - q*r1
        a0, a1 = a1, a0 - q*a1
        b0, b1 = b1, b0 - q*b1
      end
      [r0, a0, b0]
    end

     def self.generate_pairing_modulus(b)
       primes = nil
       m = nil
       while true
         primes = Array.new(8){ random_prime(b) }
         m = Clifford::Multivector3D.new primes
         break if m.data.uniq.size == 8 && m.gp(m.inverse).data == [1,0,0,0,0,0,0,0]
       end
       m
     end

     def self.generate_pairing_modulus_mod(b,q)
       m_ = generate_pairing_modulus(b)
       m = Clifford::Multivector3DMod.new m_.data, q
     end

      def self.cidiv(a,b)
        r = a.gp(b.inverse)
        r = Clifford::Multivector3D.new r.data.map{|d| d.round }
      end

      def self.cmod(a,b)
        r = cidiv(a,b)
        a.minus(r.gp(b))
      end

  end
end
