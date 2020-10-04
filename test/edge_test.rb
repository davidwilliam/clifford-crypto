require Dir.pwd + "/test/test_helper"

class TestEdge < Minitest::Test

  def test_protocol
    server = Clifford::EdgeServer.new(256)
    device = Clifford::EdgeDevice.new(256)
    j = 3

    pu_1,s_1 = server.initiate_request(device.party.pu)
    pu_2,s_2 = device.exchange(pu_1,s_1)

    server.register(pu_2,s_2)

    c = server.request_data(pu_2,j)

    d = device.receive_data(c)

    assert_equal server.data[j].data, d.data
  end
end
