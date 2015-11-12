class VolumesController < WebsocketRails::BaseController
  def update
    WebsocketRails["meetings_#{message[:meeting_id]}"].trigger(
      :volume_received,
      email: message[:email], volume: message[:volume]
    )
  end
end
