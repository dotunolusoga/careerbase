Fabricator(:note) do
  user(fabricator: :user)
  company(fabricator: :company)
  content   { Faker::Lorem.characters(140) }
end
