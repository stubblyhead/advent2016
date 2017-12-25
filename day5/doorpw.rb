require 'digest'

door_id = 'ojvtpuvg'
index = 0
password = '        '

while password.index(' ')
  md5sum = Digest::MD5.hexdigest(door_id + index.to_s)
  if md5sum[0..4] == '00000' and md5sum[5].match(/[0-7]/) and password[md5sum[5].to_i] == ' '
    password[md5sum[5].to_i] = md5sum[6]
    puts "putting #{md5sum[6]} in slot #{md5sum[5]}"
  end
  index += 1
end

puts password
