file = File.join("config", "redis", "#{Rails.env}.conf")
path = Rails.root.join(file)
config = File.read(path)

`redis-server #{path}`

running = `ps aux | grep [r]edis-server.*#{file}`

if running.empty?
  raise "Could not start redis"
end

port = config[/port.(\d+)/, 1]
$redis = Redis.new(:port => port)