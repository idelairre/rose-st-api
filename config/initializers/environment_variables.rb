module EnvironmentVariables
  class Application < Rails::Application
    if Rails.env == 'development' || Rails.env == 'test'
      config.before_configuration do
        env_file = Rails.root.join("config", 'env.yml').to_s
        if File.exists?(env_file)
          YAML.load_file(env_file)[Rails.env].each do |key, value|
            ENV[key.to_s] = value
          end
        end
      end
    end
  end
end
