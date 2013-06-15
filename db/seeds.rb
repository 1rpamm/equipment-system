# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

time=Time.now

# создание кабинетов
c = 1
room_file=File.new("./db/seed/rooms.txt")
room_file.each_line do |room_name|
  new_room = Room.create(:name=>room_name.strip)
  new_room.save!
  print "\rCreating rooms: #{c} of 12"
  c += 1
end
print "\n"


# создание типов актов
c = 1
acttype_file=File.new("./db/seed/acttypes.txt")
acttype_file.each_line do |act_name|
  new_act = ActType.create(:name=>act_name.strip)
  new_act.save!
  print "\rCreating acts: #{c} of 14"
  c += 1
end
print "\n"

# создание инвентарных номеров
c = 1
inventory_file=File.new("./db/seed/inventories.txt")
50.times do
  new_inventory = Inventory.create(:inv_num => c.to_s,
                                   :act_num=>rand(89999999)+1,
                                   :act_type_id => rand(14)+1,
                                   :body => "some text ##{c}",
                                   :accept_date => Time.now)
  new_inventory.save!
  print "\rCreating inventories: #{c} of 50"
  c += 1
end
print "\n"

# создание пользователей
c = 1
usernames_file=File.new("./db/seed/usernames.txt")
logins=%w(admin ololow arapova barmin blinov volodin volodina korunkov mahar ostapenko pasko wkolnik silaev sitnikov shavrin slowpoke jesus sidorov ivanov mouse)
email="@msiu.ru"
password="qwerty"
admin=User.create(:login => logins[c-1],
                  :name => "Cупер-Администратор",
                  :email => logins[c-1]+email,
                  :password => password,
                  :password_confirmation => password,
                  :admin_user => 1,
                  :admin_equip => 1,
                  :admin_inv => 1,
                  :responsible => 1,
                  :assistant => 1 )
admin.save
print "\rCreating users: #{c} of 20"
c += 1
usernames_file.each_line do |username|
  new_user=User.create(:login => logins[c-1],
                       :name => username.strip,
                       :email => logins[c-1]+email,
                       :password => password,
                       :password_confirmation => password,
                       :admin_user => rand(2),
                       :admin_equip => rand(2),
                       :admin_inv => rand(2),
                       :responsible => rand(2),
                       :assistant => rand(2) )
  new_user.save
  print "\rCreating users: #{c} of 20"
  c += 1
end
usernames_file.close
print "\n"

#создание производителей
c = 1
pre = "0x"
file = File.new("./db/seed/pci.ids", "r")
#while (line = file.gets)
while (c <= 1000)
  line = file.gets
  if line[0] == "#"
    #~ p line
  else
    if line[0] != "\t"
      data = line.strip.split(' ', 2)
      new_vendor = Vendor.create(:vendor_hex => pre+data[0],
                                 :name => data[1])
      new_vendor.save!
      vendor_id = new_vendor.id
    elsif line[0] == "\t" && line[1] != "\t"
      data = line.strip.split(' ', 2)
      new_device = Device.create(:vendor_id => vendor_id,
                                 :device_hex => pre+data[0],
                                 :name => data[1])
      new_device.save!
      device_id = new_device.id
    elsif line[0] == "\t" && line[1] == "\t"
      data = line.strip.split(' ', 3)
      new_subsystem = Subsystem.create(:device_id => device_id,
                                       :subvendor_hex => pre+data[0],
                                       :subdevice_hex => pre+data[1], :name => data[2])
      new_subsystem.save!
    end
  end
  print "\rCreating vendors, devices and subsystems: #{c} of 1000"
  c += 1
end
file.close
print "\n"

# создание деталей
c = 1
vendors_count = Vendor.count
while c <= 500
  offset = rand(vendors_count)
  while (Vendor.first(:offset => offset).devices) == []
    offset = rand(vendors_count)
  end
  vendor = Vendor.first(:offset => offset)
  offset=rand(vendor.devices.count)
  device = vendor.devices.first(:offset => offset)
  new_detail = Detail.create(:vendor_id => vendor.id,
                             :device_id => device.id,
                             :rev => (rand(3)+rand).to_s[0..2],
                             :name => "#{vendor.name} #{device.name}",
                             :serial => rand(9000000) + 1000000)
  if vendor.devices.first(:offset => offset).subsystems != []
    offset = rand(device.subsystems.count)
    new_detail.subsystem_id = device.subsystems.first(:offset => offset).id
  end
  new_detail.save!
  print "\rCreating details: #{c} of 500"
  c += 1
end
print "\n"

# создание оборудования
c = 1
users = User.where(:responsible => 1)
while c <= 150
  host=%w(mars stone fire ice monster gorynich ghost lib)
  responsible = users.order("random()").first!
  room = Room.order("random()").first!
  inventory = Inventory.order("random()").first!
  details_count = rand(10)+1
  details = []
  details_count.times do
    details += Detail.where(:id => rand(500)+1)
  end
  new_equipment = Equipment.create(:responsible_id => responsible.id,
                                   :room_id => room.id,
                                   :inventory_id => inventory.id,
                                   :domain_name => "#{host[rand(8)]} #{rand(24)+1}",
                                   :details => details)

  if rand(2)==1
    new_equipment.accepted_at = Time.now
  end
  if rand(2)==1
    new_equipment.deleted_at = Time.now
  end
  new_equipment.save!
  print "\rCreating equipment: #{c} of 150"
  c += 1
end
print "\n"

# создание комментариев
c = 1
equipments = Equipment.all
equipments.each do |equipment|
  3.times do
    user = User.where(:responsible => 1).order("random()").limit(1).first
    new_comment = Comment.create(:equipment_id => equipment.id,
                              :user_id => user.id,
                              :body => "test comment ##{c}")
    new_comment.save!
    print "\rCreating comments: #{c} of 450"
    c += 1
  end
end
print "\n"

puts " => #{Time.now-time}"
