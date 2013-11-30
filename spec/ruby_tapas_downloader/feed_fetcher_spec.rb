require 'spec_helper'

describe ElixirSipsDownloader::FeedFetcher do
  subject(:feed_fetcher) {
    ElixirSipsDownloader::FeedFetcher.new agent, email, password
  }

  let(:agent)    { double }
  let(:email)    { 'person@example.com' }
  let(:password) { 'chuncky bacon' }

  describe '#fetch' do
    subject(:fetched_feed) { feed_fetcher.fetch }

    let(:feed_string) { double }
    let(:feed)        { double }

    it 'fetches feed' do
      expect(agent).to receive(:add_auth)
                       .with(
                         ElixirSipsDownloader::Config.urls[:feed],
                         email,
                         password
                       )

      expect(agent).to receive(:get)
                       .with(ElixirSipsDownloader::Config.urls[:feed])
                       .and_return(double body: feed_string)

      expect(RSS::Parser).to receive(:parse).with(feed_string).and_return(feed)

      expect(fetched_feed).to eq(feed)
    end
  end
end
