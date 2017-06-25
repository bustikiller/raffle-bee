class BootstrapTable
  include ActionView::Helpers::TagHelper
  include ActionView::Context

  attr_accessor :headers, :rows
  def initialize

    @headers = []
    @rows = []
  end

  def to_html
    content_tag :table, class: 'table table-striped' do
      build_headers + build_body
    end
  end

  private

  def build_headers
    content_tag :thead do
      @headers.map { |cell| content_tag :th, cell }.inject(:+)
    end
  end

  def build_body
    content_tag :tbody do
      @rows.map do |row|
        content_tag :tr do
          row.map do |cell|
            content_tag :td, cell
          end.inject(:+)
        end
      end.inject(:+)
    end
  end
end
