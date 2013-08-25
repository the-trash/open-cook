def _join *params
  params.join ' && '
end

def template(from, to)
  script_root = File.dirname File.absolute_path __FILE__
  erb         = File.read script_root + "/templates/#{from}"
  put ERB.new(erb).result(binding), to
end

def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end