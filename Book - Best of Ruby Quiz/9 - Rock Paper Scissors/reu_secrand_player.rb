require 'securerandom'

class JEGRandomPlayer < Player
 QUEUE = [ :rock, :scissors, :paper ]
 def choose
  QUEUE[SecureRandom.random_bytes(1).ord % 3]
 end
end