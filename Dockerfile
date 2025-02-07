# Use a imagem oficial do Ruby
FROM ruby:3.2

WORKDIR /app
# Instala dependências
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN apt-get update && apt-get install -y libvips

# Define o diretório de trabalho
COPY Gemfile .
COPY Gemfile.lock .
# Copia os arquivos do projeto
RUN bundle install

COPY . .

# Instala gems

# Expõe a porta padrão do Rails
EXPOSE 3000

# Comando para iniciar o servidor
CMD ["rails", "server", "-b", "0.0.0.0"]
