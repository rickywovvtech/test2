class Testmongo
    include Mongoid::Document
    include Mongoid::Attributes::Dynamic

    field :title, type: String
    field :body, type: String
end