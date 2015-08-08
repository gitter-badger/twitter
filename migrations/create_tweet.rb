 # Aug_7_12_44_56_PDT_2015

class CreateTweet < ActiveRecord::Migration
  # hmm...
  def change
    create_table :tweets do |t|
      t.integer :tweet_id, null: false
    }
  end
end

