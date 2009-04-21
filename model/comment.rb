require 'sequel'
Sequel::Model.plugin(:schema)

Sequel.connect("sqlite://comments.db")

class Comments < Sequel::Model
  unless table_exists?
    set_schema do
      primary_key :id
      string :name
      string :title
      text :message
      timestamp :posted_date
    end
    create_table
  end

  def date
    self.posted_date.strftime("%Y-%m-%d %H:%M:%S")
  end

  def formatted_message
    Rack::Utils.escape_html(self.message).gsub(/\n/, "<br>")
  end
end
