# puma.rb
if ENV.fetch("RAILS_ENV") == 'production' || ENV.fetch("RAILS_ENV") == 'staging'
  # Config for production
      bind "tcp://0.0.0.0:#{ENV.fetch("PORT") { "3000" }}"
      environment ENV.fetch("RAILS_ENV") { "production" }
      threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
      threads threads_count, threads_count
      workers = ENV.fetch("WEB_CONCURRENCY") { Etc.nprocessors * 2 }
      worker_timeout 3600 if ENV.fetch("RAILS_ENV", "development") == "development"
      preload_app!
      stdout_redirect 'log/puma.log', 'log/puma.log', true
      on_worker_boot do
          ActiveSupport.on_load(:active_record) do
              ActiveRecord::Base.establish_connection
          end
      end
      plugin :tmp_restart
  else
  # Config for development
      threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
      threads threads_count, threads_count
      port        ENV.fetch("PORT") { 3000 }
      environment ENV.fetch("RAILS_ENV") { "development" }
      # Ensure the `tmp/pids/` directory exists
      Dir.mkdir('tmp/pids') unless File.exist?('tmp/pids')
      pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }
      plugin :tmp_restart
  end