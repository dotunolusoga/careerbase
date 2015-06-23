Fabricator(:company) do
  name   { Faker::Name.name }
  url    { Faker::Internet.url }
end
