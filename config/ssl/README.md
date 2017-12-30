[How to Setting up HTTPS for Puma](https://www.devmynd.com/blog/rails-local-development-https-using-self-signed-ssl-certificate/)

`openssl req -x509 -sha256 -nodes -newkey rsa:2048 -days 365 -keyout config/ssl/localhost.key -out config/ssl/localhost.crt`

`rails s -b 'ssl://localhost:3000?key=config/ssl/localhost.key&cert=config/ssl/localhost.crt'`
