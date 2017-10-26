class Project < ApplicationRecord
    belongs_to :user
    has_many :ddays, dependent: :destroy

    after_create do |project|
        ddays = []

        for i in (1..66) do
            today = Time.zone.now
            dday = today.to_date.to_datetime + i.day
            ddays << Dday.create(day: dday)
        end

        project.ddays << ddays
    end
end
