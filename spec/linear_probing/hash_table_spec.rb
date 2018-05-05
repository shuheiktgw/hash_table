require 'spec_helper'
require_relative '../../linear_probing/hash_table'

RSpec.describe LinearProbing::HashTable do
  let(:hash_table) { LinearProbing::HashTable.new(size) }

  describe 'put/get' do
    subject { hash_table.get(key) }

    context 'when size is big enough' do
      before do
        hash_table.put(:key_one, :value_one)
        hash_table.put(:key_two, :value_two)
        hash_table.put(:key_three, :value_three)
      end

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

      context 'one key is put' do
        subject { hash_table.get(key) }

        before do
          hash_table.put(:key_one, :value_one)
        end

        context 'unknown key is specified' do
          let(:key) { :key_two }

          it { is_expected.to be_nil }
        end

        context 'known key is specified' do
          let(:key) { :key_one }

          it { is_expected.to eq :value_one }
        end
      end

      context 'key two key is put' do
        before do
          hash_table.put(:key_one, :value_one)
        end

        it { expect { hash_table.put(:key_two, :value_two) }.to raise_error RuntimeError, 'HashTable is full' }
      end
    end
  end
end
