# Simple Test Server for testing HTTP Protocol Features

There are two API's for this server . They are..

- `/test(.:format)`
- `/random(.:format)`

The supported formats are `html`, `json`, `msgpack`

---

## /test(.:format)

Test exists to test various http protocol features. You can send parameters to the server to make it act in certain ways.
This api will echo back whatever parameter you send to it.

#### Available Parameters (Optional)

`status_code` *Integer*
The status code you want the response to return.

`redirect` *Integer*
The number of times you want the request to redirect using 302 Found + Location header. Note that It will redirect to itself. 

`sleep` *Float*
Number of seconds you want the server to sleep before returning a response.

`fresh` *Boolean*
Will add a `Cache-Control: no-cache` to the response header and prevent the server from returning a 304 Not Modified.

`cookies` *KeyValuePair*
Allows you to set multiple cookies on the server side. `name` acts key and a hash as value. The hash must contain a `value`. The hash can contain additional parameters such as `secure`, `httponly`, and `expires`. Note that `expires` is set by sending the number of seconds until the expiration time. So an example request parameter might look like `cookies[test][value]=1&cookies[test][expires]=10&cookies[test][httponly]=true`

---

## /random(.:format)

/random was created to return random strings of defined length

#### Available Parameters (Optional)

`length` *Integer* (default: 1000)
The length of the random string you want returned. 

---

## /static/[file_size].bin

These are static files you can use to test downloading of static content (not chunked). I created the following files with different sizes.

- 1kb.bin
- 10kb.bin
- 100kb.bin
- 1mb.bin
- 10mb.bin
- 100mb.bin

If you're not satisfied with the files here you can always make you own by executing `mkfile -n size[b|k|m|g] filename` (MacOS only)
