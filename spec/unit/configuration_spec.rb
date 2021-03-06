require 'spec_helper'

describe Locomotive::Steam::Configuration do

  subject { Locomotive::Steam::Configuration.new }

  describe 'default values' do

    it { expect(subject.mode).to eq(:production) }
    it { expect(subject.serve_assets).to eq(true) }
    it { expect(subject.assets_path).to eq(nil) }

  end

  describe 'assign a different value' do

    before { subject.mode = :test }
    it { expect(subject.mode).to eq(:test) }

    context 'the initial value was true' do

      before { subject.serve_assets = false }
      it { expect(subject.serve_assets).to eq(false) }

    end

  end

  describe 'overriding a method' do

    before { subject.site_path = '/42' }
    it { expect(subject.assets_path).to eq('/42/public') }

  end

end
