FactoryBot.define do
  factory :first_task, class: Task do
    title {'first_task'}
    content {'企画書を作成する。'}
    created_at {'2022-02-18'}
    deadline_on {'2022-02-18'}
    priority {1}
    status {0}
  end

  factory :second_task, class: Task do
    title {'second_task'}
    content {'顧客へ営業のメールを送る。'}
    created_at {'2022-02-17'}
    deadline_on {'2022-02-17'}
    priority {2}
    status {1}
  end

  factory :third_task, class: Task do
    title {'third_task'}
    content {'議事録を作成する。'}
    created_at {'2022-02-16'}
    deadline_on {'2022-02-16'}
    priority {0}
    status {2}
  end
end
