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

        stride = 1

        {
            # calculated
            rate: progress_rate,
            total: total.to_i,
            done: done.to_i,
            left: (total - done).to_i,

            # info
            start: ddays_all.first.day.strftime('%F (%a)'),
            finish: ddays_all.last.day.strftime('%F (%a)'),
            stride: stride
        }
    end

    def pendding
        status = ''
        message = ''
        case self.success
        when true
            status += '완료되었습니다.'
            message += '축하드립니다! 습관만들기에 성공하셨군요:)'

        when false
            status += '진행중입니다.'
            message += '멋진 습관을 얻기까지 <b>'+self.progress[:left].to_s+'일</b> 남았습니다:)'

        end

        {
            status: status,
            message: message
        }
    end
end
