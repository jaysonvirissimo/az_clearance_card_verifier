RSpec.describe AzClearanceCardVerifier::CardBuilder do
  let(:file_path) { File.dirname(__FILE__) }
  let(:instance) { described_class.new(example) }

  context 'when data were found' do
    let(:example) do
      File.read(file_path + '/example_markup/found-example.html')
    end

    describe 'returns a collection of cards' do
      let(:cards) { instance.build }

      it { expect(cards).to be_a_kind_of(Array) }
      it { expect(cards.length).to eq(4) }
      it { expect(cards).to all(respond_to(:valid?)) }
    end
  end

  context 'when data were not found' do
    let(:example) do
      File.read(file_path + '/example_markup/not-found-example.html')
    end

    describe 'returns an empty collection' do
      let(:cards) { instance.build }

      it { expect(cards).to be_a_kind_of(Array) }
      it { expect(cards.length).to be_zero }
    end
  end

  context 'when it is likely the schema has changed' do
    let(:example) do
      File.read(file_path + '/example_markup/version-change-example.html')
    end

    it { expect { instance }.to output(/Warning:/).to_stdout }
  end
end
