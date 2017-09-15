class AzClearanceCardVerifier
  class Card
    def initialize(attributes)
      @attributes = attributes
    end

    def application_number
      return unless attributes[:card_number]
      @application_number ||= attributes[:card_number].strip
    end

    def application_received
      return unless attributes[:application_received]
      @application_received ||=
        Date.parse(attributes[:application_received].strip)
    end

    def card_number
      @card_number ||= attributes[:card_number].strip
    end

    def expiration_date
      @expiration_date ||= Date.parse(attributes[:expiration_date].strip)
    end

    def issue_date
      @issue_date ||= Date.parse(attributes[:issue_date].strip)
    end

    def name
      @name ||= attributes[:name].strip
    end

    def status
      @status ||= attributes[:status].strip
    end

    def type
      @type ||= attributes[:type].strip
    end

    def valid?
      status.downcase.intern == :valid
    end

    private

    attr_reader :attributes
  end
end
