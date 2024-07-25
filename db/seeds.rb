# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# User.create!(email: 'admin@admin.com', password: 'password', role: 'admin',name:'Admin')
# User.create!(email: 'staff@admin.com', password: 'staff123', role: 'staff',name:'Staff')
User.create!(email: 'ritika@gmail.com', password: '123456', role: 'user',name:'Ritika')