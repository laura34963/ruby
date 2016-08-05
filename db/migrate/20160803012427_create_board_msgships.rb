class CreateBoardMsgships < ActiveRecord::Migration[5.0]
  def change
    create_table :board_msgships do |t|

      t.timestamps
    end
  end
end
