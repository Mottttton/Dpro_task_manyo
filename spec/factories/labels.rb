FactoryBot.define do
  factory :work_label, class: Label do
    name { "work" }
  end

  factory :private_label, class: Label do
    name { "private" }
  end

  factory :internal_label, class: Label do
    name { "internal" }
  end

  factory :customer_label, class: Label do
    name { "customer" }
  end
end
