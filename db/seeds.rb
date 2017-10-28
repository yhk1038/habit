# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([
    {email: 'yhk1038@hanmail.net', password: 'ks0352ks'},
    {email: 'yhkks1038@gmail.com', password: 'ks0352ks'}
])

users.each do |user|
    prjs = []
    12.times do |i|
        i+=1
        title = "test#{i}"
        desc = "[#{title}] #{title} #{title} #{title} #{title} #{title} #{title}"
        prj = Project.create(title: title, description: desc)

        prjs << prj
    end

    user.projects << prjs
end
