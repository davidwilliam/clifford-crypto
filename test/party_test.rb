require Dir.pwd + "/test/test_helper"

class TestParty < Minitest::Test

  def test_key_exchange_protocol
    l = 256

    party1 = Clifford::Party.new(l,1)
    party2 = Clifford::Party.new(l,2)

    party1.set_public_communication_identifier(party2.pu)
    party2.set_public_communication_identifier(party1.pu)

    party1.generate_sub_key
    party2.generate_sub_key

    party1.exchange(party2.s)
    party2.exchange(party1.s)

    assert_equal party1.g.data, party2.g.data
    assert_equal party1.pr.gp(party1.g).data, party1.s.data
    assert_equal party2.g.gp(party2.pr).data, party2.s.data
    assert_equal party1.k.data, party2.k.data
  end
end
