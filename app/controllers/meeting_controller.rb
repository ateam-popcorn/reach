class MeetingController < ApplicationController
  def index
    meetings = Meeting.all
    researches = Research.all
    @m_titles = []


    meetings.each{ |m|
      researches.each { |r|
        if r.id == m.research.id then
          @m_titles.push(id: m.id, title: r.title, start_at: m.start_at, end_at: m.end_at)
        end
      }
    }
  end

  def show
    @meeting = Meeting.find(params[:id])
    @research = Research.find(@meeting.research_id)
  end
end
