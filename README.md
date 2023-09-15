
# Teste ZRP - API de Intermediação PokeAPI

Projeto API de intermediação de dados para cadastro de habilidades dos Pokemons no PokeAPI.


## Autores

- [@Lucas Eduardo (KSukoshi)](https://github.com/KSukoshi)
## Funcionalidades

- Consulta a API da PokeAPI e extrai habilidades de um Pokemon
- Criação automática dos dados dentro da API caso não existirem
- Exception Handling caso o Pokemon não é encontrado na PokeAPI


## Stack utilizada

**Back-end:** Ruby on Rails, Docker, Nginx, Postgresql, Redis, Sidekiq


## Imagem Docker

[Imagem do projeto no DockerHub](https://hub.docker.com/r/ksukoshi/zrp-pokemon-api)
## Instalação

Instale o projeto de maneira rápida com o Docker!

Primeiro clone o projeto para uma pasta desejada

```bash
  $ git clone git@github.com:KSukoshi/Pokemon-app.git
  $ cd Pokemon-app
```
Na raiz do projeto, faça uma cópia do env-example e altere as variáveis de ambiente conforme necessário

```bash
  $ cp env-example .env
  $ echo ".env" >> .gitignore
```

Crie os volumes do Postgresql e do Redis

```bash
$ docker volume create --name pokemon-app-api-postgres
$ docker volume create --name pokemon-app-api-redis
```

Agora faça a build do container usando o Docker Compose

```bash
$ docker compose up --build
```
Ao finalizar a build, é normal ter erros de banco de dados pois ainda não foi inicializada dentro do container.
Feche o processo do docker ao finalizar o build e entre os seguintes comandos

```bash
$ docker­ compose run pokemon-app-api rake db:reset
$ docker­ compose run pokemon-app-api rake db:migrate
```

Ao rodar estes comandos, você já terá o banco de dados inicializado e já pode iniciar o projeto pelo Docker Compose

```bash
$ docker compose up
```

Pronto! O projeto está rodando dentro do container e sua endpoint acessível.
## Uso/Exemplos

O uso é simples, você consegue acessar o seguinte end-point e visualizar todas as habilidades salvas no banco de dados no momento

```
http://localhost:8020/pokemon_abilities/
```

Para buscar habilidades de Pokemons, simplesmente coloque o nome do Pokemon no endereço como no exemplo abaixo:

```
http://localhost:8020/pokemon_abilities/pikachu
```
Não importa se houver letras maíusculas, o endpoint sempre salvará a informação do nome do Pokemon e suas habilidades como no retorno abaixo:

**GET**
```json
[
  {
    "id": 1,
    "name": "static",
    "url": "https://pokeapi.co/api/v2/ability/9/"
  },
  {
    "id": 2,
    "name": "lightning-rod",
    "url": "https://pokeapi.co/api/v2/ability/31/"
  }
]
```

Ao acessar as habilidades do Pokemon, elas são salvas no banco de dados, reduzindo o número de requisições efetuadas para trazer essas mesmas informação novamente, o que pode melhorar a performance em alta demanda.

Caso seja acessado um Pokemon que não existe como nesse exemplo, ele retornará um erro.

```
http://localhost:8020/pokemon_abilities/teste
```

**Request Status 400**
```json
{"error":"Pokemon not found"}
```
