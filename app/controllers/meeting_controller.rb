class MeetingController < ApplicationController
  def index
    meetings = Meeting.all
    researches = Research.all
    @m_titles = []

    meetings.each{ |m|
      researches.each { |r|
        if r.id == m.research.id then
          @m_titles.push(r.title)
        end
      }
    }
  end
end
