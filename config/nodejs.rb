# NodeJS's configuration
# Node will be treated as a separate programming language for now

Inch::Config.register(:nodejs) do
  codebase do
    object_provider :JSDoc
    include_files   ['src/**/*.js']
    exclude_files   []
  end
end
