require 'spec_helper'

RSpec.describe AzClearanceCardVerifier do
  let(:happy_path) do
    "#{File.dirname(__FILE__)}/example_markup/found-example.html"
  end
  let(:instance) { described_class.new(application_number: 'ABCD1234') }
  let(:response_double) { double(body: File.read(happy_path)) }

  it 'has a version number' do
    expect(AzClearanceCardVerifier::VERSION).not_to be_nil
  end

  describe 'knows the correct base URL' do
    let(:url) { 'https://webapps.azdps.gov' }

    it { expect(AzClearanceCardVerifier::BASE_URL).to eq(url) }
  end

  describe 'knows the correct path' do
    let(:path) { 'public_inq_acct/acct/ClearanceCardStatusAJAX.action' }

    it { expect(AzClearanceCardVerifier::PATH).to eq(path) }
  end

  context 'with application number' do
    let(:params) { { application_number: '123-abc' } }

    it 'does not raise an error' do
      expect { described_class.new(params) }.to_not raise_error
    end
  end

  context 'with card number' do
    let(:params) { { application_number: '789-xyz' } }

    it 'does not raise an error' do
      expect { described_class.new(params) }.to_not raise_error
    end
  end

  context 'with neither application number nor card number' do
    let(:params) { {} }

    it 'raises an error' do
      expect { described_class.new(params) }.to raise_error(ArgumentError)
    end
  end

  describe '#cards' do
    let(:cards) { instance.cards }

    before do
      expect(instance).to receive(:response).and_return(response_double)
    end

    it { expect(cards.first).to respond_to(:valid?) }
    it { expect(cards.first).to respond_to(:application_number) }
    it { expect(cards.first).to respond_to(:card_number) }
    it { expect(cards.first).to respond_to(:name) }
    it { expect(cards.first).to respond_to(:status) }
    it { expect(cards.first).to respond_to(:type) }
    it { expect(cards.first).to respond_to(:application_received) }
    it { expect(cards.last.expiration_date).to be_a_kind_of(Date) }
    it { expect(cards.last.issue_date).to be_a_kind_of(Date) }
  end

  describe '#latest_card' do
    let(:card) { instance.latest_card }

    before do
      expect(instance).to receive(:response).and_return(response_double)
    end

    it { expect(card).to be_valid }
    it { expect(card.name.downcase).to match(/jayson/) }
  end
end
