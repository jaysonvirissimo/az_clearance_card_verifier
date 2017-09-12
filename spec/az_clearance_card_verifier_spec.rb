require 'spec_helper'

RSpec.describe AzClearanceCardVerifier do
  describe 'has a version number' do
    it { expect(AzClearanceCardVerifier::VERSION).not_to be nil }
  end

  describe 'knows the correct base URL' do
    let(:url) { 'https://webapps.azdps.gov' }

    it { expect(AzClearanceCardVerifier::BASE_URL).to eq(url) }
  end

  describe 'knows the correct path' do
    let(:path) { '/public_inq_acct/acct/ClearanceCardStatusAJAX.action' }

    it { expect(AzClearanceCardVerifier::PATH).to eq(path) }
  end
end
