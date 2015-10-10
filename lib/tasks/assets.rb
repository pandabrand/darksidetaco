namespace :assets do
  desc 'Precompile assets'
  task :precompile => :app do
    assets = Darksidetaco::Routes::Base.assets
    target = Pathname(Darksidetaco::App.root) + 'public/assets'

    assets.each_logical_path do |logical_path|
      if asset = assets.find_asset(logical_path)
        filename = target.join(asset.digest_path)
        FileUtils.mkpath(filename.dirname)
        puts filename
        asset.write_to(filename)

        filename = target.join(logical_path)
        FileUtils.mkpath(filename.dirname)
        asset.write_to(filename)
      end
    end
  end
end