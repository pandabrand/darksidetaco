namespace :assets do
  desc 'Precompile assets'
  task :precompile => :app do
    assets = Darksidetaco::Routes::Base.assets
    target = Pathname(Darksidetaco::App.root) + 'public/assets'

    assets.find_all_linked_assets do |asset|
      if asset #= assets.find_asset(logical_path)
        filename = target.join(asset.digest_path)
        FileUtils.mkpath(filename.dirname)
        asset.write_to(filename)

        filename = target.join(logical_path)
        FileUtils.mkpath(filename.dirname)
        asset.write_to(filename)
      end
    end
  end
end