require 'delegate'

module Users
  class LeaderboardPresenter < SimpleDelegator
    def self.wrap(users)
      users.map.with_index(1) { |user, index| new(user, index) }
    end

    private
    attr_reader :user, :rank

    public

    def initialize(user, rank)
      @user = user
      @rank = rank
      super(user)
    end

    def nickname
      user.nickname || 'N/A'
    end

    def rank_emoji
      ranking_emojis_table[rank] || "🏅"
    end

    def in_top_three
      (1..3).include?(rank)
    end

    private

    def ranking_emojis_table
      { 1 => "🥇", 2 => "🥈", 3 => "🥉" }
    end
  end
end
