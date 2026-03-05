local kong = kong

local CustomHandler = {
  VERSION = "1.0.0",
  PRIORITY = 900,
}

function CustomHandler:access(conf)
  -- Inject a custom header towards the upstream service
  if conf.header_name and conf.header_value then
    kong.service.request.set_header(conf.header_name, conf.header_value)
  end

  -- Simple structured log for observability
  kong.log.info(string.format(
    "[custom-plugin] method=%s path=%s client_ip=%s",
    kong.request.get_method(),
    kong.request.get_path(),
    kong.client.get_ip()
  ))
end

return CustomHandler

