class EnableExtensionForUuid < ActiveRecord::Migration[5.2]
  def change
    # UUIDを有効化
    enable_extension 'pgcrypto'
  end
end
