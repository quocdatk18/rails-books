# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
10.times do
  Author.create(full_name: Faker::Book.author, description: Faker::Lorem.paragraph(sentence_count: 2),
                address: Faker::Address.full_address,
                birthday: Faker::Date.birthday(min_age: 18, max_age: 65))
  Supplier.create(name: Faker::Book.publisher, address: Faker::Address.full_address,
                  phone: Faker::PhoneNumber.cell_phone,
                  description: Faker::Lorem.paragraph(sentence_count: 2))
  Category.create(name: Faker::Book.genre, description: Faker::Lorem.paragraph(sentence_count: 2))
end
100.times do
  book = Book.create(title: Faker::Book.title, description: Faker::Lorem.paragraph(sentence_count: 2),
                     published_date: Faker::Date.between(from: '1990-08-23', to: '2022-09-01'),
                     price: Faker::Number.decimal(l_digits: 2), status: Faker::Number.between(from: 0, to: 2),
                     author_id: Faker::Number.between(from: 1, to: 10),
                     supplier_id: Faker::Number.between(from: 1, to: 10))
  3.times do
    book.categories.push(Category.find_by(id: Faker::Number.unique.between(from: 1, to: 10)))
  end
  Faker::UniqueGenerator.clear
end

Admin.create(email: 'admin@gmail.com', password: 'admin123')
