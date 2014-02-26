Fabricator(:todo) do
  name { "cook dinner" }
  # user { Fabricate(:user) }
end

# Fabricator(:user) do
#   email { "joe@example.com" }

# end



# Fabricator(:todo) do
#   name { Faker::Lorem.words(5).join(" ") }
#   # user { Fabricate(:user) }
# end

# Fabricator(:user) do
#   email { Faker.Internet.email }

# end
