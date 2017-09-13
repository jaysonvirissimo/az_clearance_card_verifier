require 'spec_helper'

RSpec.describe AzClearanceCardVerifier::Card do
  let(:instance) { described_class.new(attributes) }

  context 'with attributes for a valid card' do
    let(:attributes) do
      {
        card_number: ' 3B12238175 ',
        application_number: ' JWQ1784935 ',
        application_received: ' 2017-08-09 ',
        type: ' Level One IVP Clearance Card ',
        status: ' Valid ',
        name: ' VIRISSIMO, JAYSON, A ',
        issue_date: ' 2017-08-21 ',
        expiration_date: ' 2023-08-21 '
      }
    end

    it { expect(instance).to be_valid }
    it { expect(instance.card_number).to be_a_kind_of(String) }
    it { expect(instance.application_number).to be_a_kind_of(String) }
    it { expect(instance.application_received).to be_a_kind_of(Date) }
    it { expect(instance.type).to be_a_kind_of(String) }
    it { expect(instance.status).to be_a_kind_of(String) }
    it { expect(instance.name).to be_a_kind_of(String) }
    it { expect(instance.issue_date).to be_a_kind_of(Date) }
    it { expect(instance.expiration_date).to be_a_kind_of(Date) }
  end

  context 'with attributes for an invalid card' do
    let(:attributes) do
      {
        card_number: ' 3B12238175 ',
        application_number: ' 1111513903 ',
        application_received: ' 2002-06-24 ',
        type: ' Inactive-Class 1 Clearance Card ',
        status: ' Expired ',
        name: ' VIRISSIMO, JAYSON, A ',
        issue_date: ' 2002-09-28 ',
        expiration_date: ' 2005-09-28 '
      }
    end

    it { expect(instance).to_not be_valid }
    it { expect(instance.card_number).to be_a_kind_of(String) }
    it { expect(instance.application_number).to be_a_kind_of(String) }
    it { expect(instance.application_received).to be_a_kind_of(Date) }
    it { expect(instance.type).to be_a_kind_of(String) }
    it { expect(instance.status).to be_a_kind_of(String) }
    it { expect(instance.name).to be_a_kind_of(String) }
    it { expect(instance.issue_date).to be_a_kind_of(Date) }
    it { expect(instance.expiration_date).to be_a_kind_of(Date) }
  end
end
