class Breadcrumbs
  attr_accessor :list
  def add(name, path)
    @list ||= []
    @list << {name => path}
  end
end
