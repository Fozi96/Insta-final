50.times do |n|
  name = Faker::TvShows::TheITCrowd.character #=> "Roy Trenneman"
  email = Faker::TvShows::TheITCrowd.email #=> "roy.trenneman@reynholm.test"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               )
end
