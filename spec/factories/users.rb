FactoryBot.define do
  factory :first_user, class: User do
    name { "taro" }
    email { "taro@sample.com" }
    password { "password" }
    admin { true }

    trait :with_tasks do
      after(:create) do |user|
        user.tasks.create!(FactoryBot.build(:first_task).attributes)
        user.tasks.create!(FactoryBot.build(:second_task).attributes)
        user.tasks.create!(FactoryBot.build(:third_task).attributes)
      end
    end
    trait :with_labels do
      after(:create) do |user|
        user.labels.create!(FactoryBot.build(:work_label).attributes)
        user.labels.create!(FactoryBot.build(:internal_label).attributes)
        user.labels.create!(FactoryBot.build(:customer_label).attributes)
      end
    end
  end

  factory :second_user, class: User do
    name { "jiro" }
    email { "jiro@sample.com" }
    password { "drowssap" }
    admin { false }

    trait :with_tasks do
      after(:create) do |user|
        user.tasks.create!(FactoryBot.build(:jiro_task).attributes)
      end
    end
    trait :with_labels do
      after(:create) do |user|
        user.labels.create!(FactoryBot.build(:private_label).attributes)
      end
    end
  end

  factory :third_user, class: User do
    name { "hanako" }
    email { "hanako@sample.com" }
    password { "pasuwaado" }
    admin { false }

    trait :with_tasks do
      after(:create) do |user|
        user.tasks.create!(FactoryBot.build(:hanako_task).attributes)
      end
    end
  end
end
