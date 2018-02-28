require "rails_helper"

RSpec.describe MailerService do
  describe '#format_date_es' do
    it 'formats the date in Spanish' do
      expect(described_class.new.send(:format_date_es, Date.new(2018, 4, 6))).to eq '6 de abril de 2018'
    end
  end
end