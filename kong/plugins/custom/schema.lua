local typedefs = require "kong.db.schema.typedefs"

return {
  name = "custom",
  fields = {
    { consumer = typedefs.no_consumer },
    { protocols = typedefs.protocols_http },
    { config = {
        type = "record",
        fields = {
          { header_name = { type = "string", required = true, default = "X-Platform" }, },
          { header_value = { type = "string", required = true, default = "internal-api" }, },
        },
      },
    },
  },
}

