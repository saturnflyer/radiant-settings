module SettingsTags
  include Radiant::Taggable

  class TagError < StandardError; end
  
  desc %{
    Renders the Radiant::Config setting specified by the required 'name' attribute.
  
  *Usage*:

  <pre><code><r:setting name="admin.title" /></code></pre>
  }
  tag "setting" do |tag|
    raise TagError, "'name' attribute required" unless name = tag.attr['name']
    Radiant::Config["#{name}"]
  end

end