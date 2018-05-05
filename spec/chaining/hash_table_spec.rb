require 'spec_helper'
require_relative '../../chaining/hash_table'

RSpec.describe Chaining::HashTable do
  let(:hash_table) { Chaining::HashTable.new(size) }

  describe 'put/get' do
    subject { hash_table.get(key) }

    before do
      hash_table.put(:key_one, :value_one)
      hash_table.put(:key_two, :value_two)
      hash_table.put(:key_three, :value_three)
    end

    context 'when size is big enough' do
      let(:size) { 97 }

      context 'when existing key is specified' do
        let(:key) { :key_one }

        it { is_expected.to eq :value_one }
      end

      context 'when not-existing key is specified' do
        let(:key) { :key_four }

        it { is_expected.to be_nil }
      end

      context 'when existing value is updated' do
        let(:key) { :key_one }

        before do
          hash_table.put(:key_one, :value_1)
        end

        it { is_expected.to eq :value_1 }
      end
    end

    context 'when size is one' do
      let(:size) { 1 }

      context 'key is key_one' do
        let(:key) { :key_one }

        it { is_expected.to eq :value_one }
      end

      context 'key is key_two' do
        let(:key) { :key_two }

        it { is_expected.to eq :value_two }
      end

      context 'key is key_three' do
        let(:key) { :key_three }

        it { is_expected.to eq :value_three }
      end

      context 'key is key_four' do
        let(:key) { :key_four }

        it { is_expected.to be_nil }
      end
    end
  end
end
