ActionDispatch::Request.parameter_parsers[:msgpack] = ->(raw_post) do
  MessagePack.unpack(raw_post) || {}
end
