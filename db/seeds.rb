# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'

# Creating User

user = User.create(email: 'user1@test.te', password: '123456')

# Creating Cards

url  = 'http://1000mostcommonwords.com/1000-most-common-german-words'
page = Nokogiri::HTML(open(url))
rows = page.xpath('//*[@id="post-188"]/div/table/tbody/tr[position() > 1]/td[position() > 1]')
rows.each_slice(2) do |original, translated|
  Card.create(original_text:   original.text,
              translated_text: translated.text,
              user_id:         user.id)
end
