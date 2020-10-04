require Dir.pwd + "/test/test_helper"

class TestCrypto< Minitest::Test

  def test_encryption_decryption
    l = 128
    m_10 = 23

    crypto = Clifford::Crypto.new l
    c = crypto.encrypt(m_10)

    assert_equal m_10, crypto.decrypt(c)
  end
end
