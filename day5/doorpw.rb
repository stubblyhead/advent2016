require 'digest'

door_id = 'abc'
index = 0
count = 0

until count == 8
  md5sum = Digest::MD5.hexdigest(door_id + index.to_s)
  if md5sum[0..4] == '00000'
    print md5sum[5]
    count += 1
  end
  index += 1
end
