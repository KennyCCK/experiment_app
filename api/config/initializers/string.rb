class String
  def encrypt(key)
    cipher = OpenSSL::Cipher.new('aes-256-cfb').encrypt
    cipher.key = Digest::SHA1.hexdigest key
    s = cipher.update(self) + cipher.final

    s.unpack('H*')[0].upcase
  end

  def decrypt(key)
    cipher = OpenSSL::Cipher.new('aes-256-cfb').decrypt
    cipher.key = Digest::SHA1.hexdigest key
    s = [self].pack("H*").unpack("C*").pack("c*")

    cipher.update(s) + cipher.final
  end
end