require 'spec_helper'

require_relative '../../../../lib/locomotive/steam/adapters/memory/order.rb'

describe Locomotive::Steam::Adapters::Memory::Order do

  let(:order) { Locomotive::Steam::Adapters::Memory::Order.new(*input) }

  describe '#list' do

    subject { order.list }

    let(:input) { nil }
    it { is_expected.to eq [] }

    context 'a string' do

      let(:input) { 'name' }
      it { is_expected.to eq [[:name]] }

    end

    context 'two strings' do

      let(:input) { ['name', 'date.desc'] }
      it { is_expected.to eq [[:name], [:date, :desc]] }

    end

    context 'a string with a comma' do

      let(:input) { 'name, date desc' }
      it { is_expected.to eq [[:name], [:date, :desc]] }

    end

  end

  describe '#apply_to' do

    subject { order.apply_to(entry, :en) }

    let(:input) { 'title, date desc' }
    let(:entry) { instance_double('Entry', title: 'foo', date: Time.now) }
    it { expect(subject.map(&:class)).to eq([Locomotive::Steam::Adapters::Memory::Order::Asc, Locomotive::Steam::Adapters::Memory::Order::Desc]) }

  end

  describe 'sort' do

    let(:array) {
      [
        instance_double('Entry1', id: 1, title: 'b', position: 1),
        instance_double('Entry2', id: 2, title: 'b', position: 2),
        instance_double('Entry3', id: 3, title: 'a', position: 3),
        instance_double('Entry3', id: 4, title: 'c', position: 1)
      ]
    }
    let(:input) { 'title, position desc' }

    subject { array.sort_by { |entry| order.apply_to(entry, :en) } }

    it { expect(subject.map(&:id)).to eq([3, 2, 1, 4]) }

  end

end
