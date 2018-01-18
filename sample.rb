require_relative 'lib/ruby_archives'

class Corgi < RubyArchives
  self.finalize!

  belongs_to("human", {
    foreign_key: "owner_id",
    class_name: "Human",
    primary_key: "id"
  })

  has_one_through("house", "human", "house")
end

class Human < RubyArchives
  self.finalize!

  has_many("corgis", {
    foreign_key: "owner_id",
    class_name: "Corgi",
    primary_key: "id"
    })

  belongs_to("house", {
    foreign_key: "house_id",
    class_name: "House",
    primary_key: "id"
    })
end


class House < RubyArchives
  self.finalize!

  has_many("humans", {
    foreign_key: "house_id",
    class_name: "Human",
    primary_key: "id"
    })
end
