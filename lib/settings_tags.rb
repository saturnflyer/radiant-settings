module SettingsTags
  include Radiant::Taggable

  class TagError < StandardError; end
  
  tag "config" do |tag|
    tag.expand
  end
  
  desc %{
    Renders the Radiant::Config setting specified by the required 'key' attribute.
  
  *Usage*:

  <pre><code><r:config:setting key="admin.title" /></code></pre>
  }
  tag "config:setting" do |tag|
    raise TagError, "'key' attribute required" unless key = tag.attr['key']
    Radiant::Config["#{key}"]
  end

end