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

    def since_from_create
        created_day = self.created_at.to_date
        current_day = Time.zone.now.to_date
        (current_day - created_day).to_i
    end

    def progress
        ddays_all = self.ddays
        ddays_done = ddays_all.done

        total = ddays_all.count.to_f
        done = ddays_done.count.to_f

        progress_rate = ((done/total).round(3)*100).to_s + '%'

        progress_data = {
            rate: progress_rate,
            total: total.to_i,
            done: done.to_i,
            left: (total - done).to_i
        }
        progress_data
    end
end
