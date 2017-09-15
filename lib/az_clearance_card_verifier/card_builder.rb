require 'nokogiri'

class AzClearanceCardVerifier
  class CardBuilder
    ORDERED_ATTRIBUTES = %i[
      card_number
      application_number
      date_received
      type
      status
      name
      issue_date
      expiration_date
    ].freeze

    def initialize(document)
      @document = document
      check_for_schema_changes
    end

    def build
      relevant_tables.map { |table| Card.new(extract_attributes_from(table)) }
    end

    private

    attr_reader :document

    def check_for_schema_changes
      return unless new_version?
      puts 'Warning: A new version of the API has been released.'
      puts "#{self.class} may need to be modified."
    end

    def extract_attributes_from(table)
      ORDERED_ATTRIBUTES.each_with_object({}).with_index do |(key, hash), index|
        hash[key] = table.css('td')[index].text
      end
    end

    def new_version?
      document.include?('v1.7') || document.include?('v2')
    end

    def page
      @page ||= Nokogiri::HTML(document)
    end

    def relevant_tables
      page.css('tr').reject { |table_row| table_row.css('th').count.positive? }
    end
  end
end
