require 'spec_helper'

describe ElixirSipsDownloader::Login do
  subject(:ruby_tapas_downloader) {
    ElixirSipsDownloader::Login.new agent, email, password
  }

  let(:agent)    { double get: page }
  let(:email)    { 'someone@example.com' }
  let(:password) { 'chunky bacon' }

  let(:page)       { double forms: [login_form] }
  let(:login_form) {
    double :username= => nil,
           :password= => nil,
           :submit    => nil
  }

  describe '#login' do
    it 'requests the login page' do
      expect(agent).to receive(:get)
                       .with(ElixirSipsDownloader::Config.urls.fetch(:login))
      ruby_tapas_downloader.login
    end

    it 'fills in the login form' do
      expect(login_form).to receive(:username=).with(email)
      expect(login_form).to receive(:password=).with(password)
      ruby_tapas_downloader.login
    end

    it 'submits the login form' do
      expect(login_form).to receive(:submit)
      ruby_tapas_downloader.login
    end
  end
end
