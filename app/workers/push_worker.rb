class PushWorker
  include Sidekiq::Worker
  def perform(message_id, count)
    message = Message.find(message_id)
    message.send_push
  end
end
