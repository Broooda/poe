class A < ActiveRecord::Migration
  def change
    create_table :simplexes do |t|
      t.string  :text
    end
  end
end
