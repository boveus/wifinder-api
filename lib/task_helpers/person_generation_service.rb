class PersonGenerationService
  def self.generate_people(number = 1)
    Device.more_than_five_ssids.each do |device|
      nickname = "Person-#{number}"
      person = Person.find_or_create_by(nickname: nickname)
      person.add_device(device)
      number += 1
    end
  end
end
