class AddAttachableToAttachments < ActiveRecord::Migration
  def change
    #change_table :attachments do |t|
     # t.remove_references :question
     # t.references :attachable, polymorphic: true
    #end

    remove_reference :attachments, :question

    add_reference :attachments, :attachable, polymorphic: true

    add_index :attachments, [:attachable_id, :attachable_type]
  end
end
