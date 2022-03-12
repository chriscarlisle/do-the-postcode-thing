class PostcodeChecksController < ApplicationController
  def create
    postcode = PostcodeCheck.new(params[:postcode])

    if postcode.serviced?
      render turbo_stream_modal('success')
    else
      render turbo_stream_modal('failure')
    end
  rescue PostcodeCheck::PostcodeCheckUnavailable
    render turbo_stream_modal('unavailable')
  end

  private

  def turbo_stream_modal(result)
    {
      turbo_stream: turbo_stream.update(
        'modal-container',
        partial: 'modal',
        locals: { result: result }
      )
    }
  end
end
