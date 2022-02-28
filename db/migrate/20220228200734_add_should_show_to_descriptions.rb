class AddShouldShowToDescriptions < ActiveRecord::Migration[6.1]
  def change
    add_column :descriptions, :should_show, :boolean, default: false
  end
end
