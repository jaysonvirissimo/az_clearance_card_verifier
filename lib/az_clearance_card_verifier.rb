require 'az_clearance_card_verifier/version'
require 'httparty'

class AzClearanceCardVerifier
  BASE_URL = 'https://webapps.azdps.gov'.freeze
  PATH = 'public_inq_acct/acct/ClearanceCardStatusAJAX.action'.freeze

  def initialize(application_number: nil, card_number: nil)
    raise ArgumentError unless application_number || card_number
    @application_number = application_number
    @card_number = card_number
  end

  def any_valid?
    cards.any?(&:valid?)
  end

  def cards
    @cards ||= CardBuilder.new(response.body).build
  end

  def latest_card
    cards.sort_by(&:expiration_date).last
  end

  private

  attr_reader :application_number, :card_number

  def full_path
    "#{BASE_URL}/#{PATH}?#{params}"
  end

  def params
    if application_number
      "appNo=#{application_number}"
    else
      "arn=#{card_number}"
    end
  end

  def response
    @response ||= HTTParty.post(full_path)
  end
end
