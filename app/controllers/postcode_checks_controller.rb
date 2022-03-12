class PostcodeChecksController < ApplicationController
  def create
    render turbo_stream: turbo_stream.update(
      'modal-container',
      partial: 'modal',
      locals: { result: 'failure' }
    )
  end
end
