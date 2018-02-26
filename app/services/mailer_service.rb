class MailerService
  require 'sendgrid-ruby'
  include SendGrid

  TICKETS_MAIL_TEMPLATE = 'd98af60e-516b-4ee6-8f7b-1bf57d35b3c8'
  SENDER_MAIL = 'rafflebeeservice@gmail.com'

  def send(name:, raffle:, email:, tickets:)
    mail = Mail.new
    mail.from = Email.new(email: "#{raffle_name} <#{SENDER_MAIL}>")

    personalization = Personalization.new
    personalization.add_to(Email.new(email: email, name: name))
    personalization.add_substitution(Substitution.new(key: '-name-', value: name.capitalize))
    personalization.add_substitution(Substitution.new(key: '-tickets-', value: tickets.join(', ')))
    personalization.add_substitution(Substitution.new(key: '-raffle_name-', value: raffle.name))
    personalization.add_substitution(Substitution.new(key: '-award-', value: raffle.award))
    mail.add_personalization(personalization)
    mail.add_content(Content.new(type: 'text/html', value: 'body placeholder'))
    mail.template_id = TICKETS_MAIL_TEMPLATE

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    begin
      response = sg.client.mail._("send").post(request_body: mail.to_json)
    rescue Exception => e
      Rails.logger.error e.message
    end
    Rails.logger.info "Mail sent to #{email} with the following tickets: #{tickets.join(', ')}"
    puts response.status_code
    puts response.body
    puts response.headers
  end
end
