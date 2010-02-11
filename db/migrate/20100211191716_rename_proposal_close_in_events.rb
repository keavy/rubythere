class RenameProposalCloseInEvents < ActiveRecord::Migration
  def self.up
    rename_column :events, :reg_open_date, :reg_date
    rename_column :events, :proposal_close_date, :cfp_close_date
  end

  def self.down
    rename_column :events, :reg_date, :reg_open_date
    rename_column :events, :cfp_close_date, :proposal_close_date
  end
end
